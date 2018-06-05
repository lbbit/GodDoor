#include "monitorwidget.h"
#include <QMessageBox>
#include <QAudioFormat>

struct WAVFILEHEADER
{
    // RIFF 头
    char RiffName[4];
    unsigned long nRiffLength;

    // 数据类型标识符
    char WavName[4];

    // 格式块中的块头
    char FmtName[4];
    unsigned long nFmtLength;

    // 格式块中的块数据
    unsigned short nAudioFormat;
    unsigned short nChannleNumber;
    unsigned long nSampleRate;
    unsigned long nBytesPerSecond;
    unsigned short nBytesPerSample;
    unsigned short nBitsPerSample;

    // 数据块中的块头
    char    DATANAME[4];
    unsigned long   nDataLength;
};

MonitorWidget::MonitorWidget(QWidget *parent, QString url, int porta, int portc) : QWidget(parent),
    m_vlcWidgetVideo(NULL),
    _player(NULL),
    _instance(NULL),
    _media(NULL)
{
    rtmp_url = url;
    port_A = porta;
    port_C = portc;

    b_isRecording = false;

    init_layout();
    init_connect();

    qus = new QUdpSocket(this);
    qus->bind(QHostAddress("0.0.0.0"), 10000);
    connect(qus,&QUdpSocket::readyRead, this, &MonitorWidget::readPendingDatagrams);

    tcpClient = new QTcpSocket(this);
    connect(tcpClient, SIGNAL(bytesWritten(qint64)), this, SLOT(goOnSend(qint64)));
    tcpClient->connectToHost(QHostAddress("118.25.43.148"), port_A);
//    tcpClient->connectToHost(QHostAddress("118.25.43.148"), 10137);
    loadSize = 0;
    byteToWrite = 0;
    totalSize = 0;
    outBlock.clear();
    fileName = "./indexaudio.wav";
    originFilename = "./indexaudio.raw";
}


void MonitorWidget::initPlayer(const QString &url, bool isLocalVideoAddr)
{
    _media = new VlcMedia(url,isLocalVideoAddr,_instance);
    _player->setVideoWidget(m_vlcWidgetVideo);
    m_vlcWidgetVideo->setMediaPlayer(_player);
    _player->openOnly(_media);
}

void MonitorWidget::on_pushButtonPlay_clicked()
{
    _player->play();
}

void MonitorWidget::on_pushButtonPause_clicked()
{
    _player->pause();
}

void MonitorWidget::on_pushButtonStop_clicked()
{
    _player->stop();
}

void MonitorWidget::on_pushButtonOpenLock_clicked()
{
//    int ret;
    QByteArray msg = "OpenLock";
    qDebug() <<"sendopenlock";
    qus->writeDatagram(msg, QHostAddress("118.25.43.148"), quint16(port_C));
//    qus->writeDatagram(msg, QHostAddress("118.25.43.148"), 10136);
    //qDebug()<<"ret: "<<ret;
}

void MonitorWidget::on_pushButtonSendVoice_clicked()
{
    if(!b_isRecording)
    {
        button_SendVoice->setText("正在录音，点击发送");
        b_isRecording = !b_isRecording;

        outputFile.setFileName("./indexaudio.raw");
        outputFile.open( QIODevice::WriteOnly | QIODevice::Truncate );
        QAudioFormat format;
        // set up the format you want, eg.
        format.setSampleRate(8000);
        format.setChannelCount(1);
        format.setSampleSize(16);
        format.setCodec("audio/pcm");
        format.setByteOrder(QAudioFormat::LittleEndian);
        format.setSampleType(QAudioFormat::UnSignedInt);
        QAudioDeviceInfo info = QAudioDeviceInfo::defaultInputDevice();
        if (!info.isFormatSupported(format)) {
           qWarning()<<"default format not supported try to use nearest";
           format = info.nearestFormat(format);
        }
        audio = new QAudioInput(format, this);
        audio->start(&outputFile);

    }
    else
    {
        button_SendVoice->setText("发送语音");
        b_isRecording = !b_isRecording;
        audio->stop();
        outputFile.close();
        delete audio;
        addWavHeader(originFilename,fileName);
        send(); //发送语音
    }
}

void MonitorWidget::readPendingDatagrams()
{
    qDebug()<<"recive";
    QByteArray datagram;
    datagram.resize(qus->pendingDatagramSize());
    QHostAddress sender;
    quint16 senderPort;
    qus->readDatagram(datagram.data(), datagram.size(),
                         &sender, &senderPort);
    if(datagram.toInt() == 1)
    {
        QMessageBox::information(this,
                                     tr("提示"),
                                     tr("开锁成功！"));
        return;
    }
    else
    {
        QMessageBox::warning(this,
                                     tr("提示"),
                                     tr("设备端错误，开锁失败！"));
        return;
    }
}

void MonitorWidget::send()
{
    loadSize = 0;
    byteToWrite = 0;
    totalSize = 0;
    outBlock.clear();
    localFile = new QFile(fileName);
    if(!localFile->open(QFile::ReadOnly))
    {
        QMessageBox::warning(this,
                                     tr("提示"),
                                     tr("打开文件错误，发送语音失败！"));
        delete localFile;
        return;
    }
    else
    {
        byteToWrite = localFile->size();  //剩余数据的大小
        totalSize = localFile->size();

        loadSize = 4*1024;  //每次发送数据的大小


        //QString currentFileName = fileName.right(fileName.size() - fileName.lastIndexOf('/')-1);
        int indexsize = int(localFile->size());
        qDebug()<<"indexsize:"<<indexsize;
        totalSize += sizeof(int);  //总大小为文件大小加上一个64位整数
        byteToWrite += sizeof(int);
        qDebug()<<"sizeof int "<<sizeof(int);


//        out<<qint64(0)<<qint64(0)<<currentFileName;

//        totalSize += outBlock.size();  //总大小为文件大小加上文件名等信息大小
//        byteToWrite += outBlock.size();

//        out.device()->seek(0);  //回到字节流起点来写好前面连个qint64，分别为总大小和文件名等信息大小
//        out<<totalSize<<qint64(outBlock.size());


        //将读到的文件发送到套接字
        if(tcpClient->write((char*)(&indexsize),4) < 0)
        {
            QMessageBox::warning(this,
                                         tr("提示"),
                                         tr("网络连接错误，发送语音失败！"));
            delete localFile;
            return;
        }
    }
}

void MonitorWidget::goOnSend(qint64 numBytes)
{
    byteToWrite -= numBytes;  //剩余数据大小
    outBlock = localFile->read(qMin(byteToWrite, loadSize));
    if(tcpClient->write(outBlock) < 0)
    {
        QMessageBox::warning(this,
                                     tr("提示"),
                                     tr("网络连接错误，发送语音失败！"));
        delete localFile;
        return;
    }
    if(byteToWrite == 0)  //发送完毕
    {
        QMessageBox::information(this,
                                     tr("提示"),
                                     tr("发送语音成功！"));
        delete localFile;
        return;
    }
}

void MonitorWidget::init_layout()
{
    button_play = new QPushButton("播放",this);
    button_pause = new QPushButton("暂停",this);
    button_stop = new QPushButton("停止",this);
    button_OpenLock = new QPushButton("远程开锁",this);
    button_SendVoice = new QPushButton("发送语言",this);
    m_vlcWidgetVideo = new VlcWidgetVideo(this);
    m_vlcWidgetVideo->setMinimumSize(600,400);
    _instance = new VlcInstance(VlcCommon::args());
    _player = new VlcMediaPlayer(_instance);
    initPlayer(rtmp_url,false);
    hlayout_down = new QHBoxLayout();
    hlayout_down->addWidget(button_play);
    hlayout_down->addWidget(button_pause);
    hlayout_down->addWidget(button_stop);
    hlayout_down->addStretch();
    hlayout_down->addWidget(button_OpenLock);
    hlayout_down->addWidget(button_SendVoice);
    vlayout_all = new QVBoxLayout();
    vlayout_all->addWidget(m_vlcWidgetVideo);
    vlayout_all->addLayout(hlayout_down);
    this->setLayout(vlayout_all);
}

void MonitorWidget::init_connect()
{
    connect(button_play,&QPushButton::clicked,this,&MonitorWidget::on_pushButtonPlay_clicked);
    connect(button_pause,&QPushButton::clicked,this,&MonitorWidget::on_pushButtonPause_clicked);
    connect(button_stop,&QPushButton::clicked,this,&MonitorWidget::on_pushButtonStop_clicked);
    connect(button_OpenLock,&QPushButton::clicked,this,&MonitorWidget::on_pushButtonOpenLock_clicked);
    connect(button_SendVoice,&QPushButton::clicked,this,&MonitorWidget::on_pushButtonSendVoice_clicked);
}

qint64 MonitorWidget::addWavHeader(QString catheFileName, QString wavFileName)
{
    // 开始设置WAV的文件头
    // 这里具体的数据代表什么含义请看上一篇文章（Qt之WAV文件解析）中对wav文件头的介绍
    WAVFILEHEADER WavFileHeader;
    qstrcpy(WavFileHeader.RiffName, "RIFF");
    qstrcpy(WavFileHeader.WavName, "WAVE");
    qstrcpy(WavFileHeader.FmtName, "fmt ");
    qstrcpy(WavFileHeader.DATANAME, "data");

    // 表示 FMT块 的长度
    WavFileHeader.nFmtLength = 16;
    // 表示 按照PCM 编码;
    WavFileHeader.nAudioFormat = 1;
    // 声道数目;
    WavFileHeader.nChannleNumber = 1;
    // 采样频率;
    WavFileHeader.nSampleRate = 8000;

    // nBytesPerSample 和 nBytesPerSecond这两个值通过设置的参数计算得到;
    // 数据块对齐单位(每个采样需要的字节数 = 通道数 × 每次采样得到的样本数据位数 / 8 )
    WavFileHeader.nBytesPerSample = 2;
    // 波形数据传输速率
    // (每秒平均字节数 = 采样频率 × 通道数 × 每次采样得到的样本数据位数 / 8  = 采样频率 × 每个采样需要的字节数 )
    WavFileHeader.nBytesPerSecond = 16000;

    // 每次采样得到的样本数据位数;
    WavFileHeader.nBitsPerSample = 16;

    QFile cacheFile(catheFileName);
    QFile wavFile(wavFileName);

    if (!cacheFile.open(QIODevice::ReadWrite))
    {
        return -1;
    }
    if (!wavFile.open(QIODevice::WriteOnly))
    {
        return -2;
    }

    int nSize = sizeof(WavFileHeader);
    qint64 nFileLen = cacheFile.bytesAvailable();

    WavFileHeader.nRiffLength = nFileLen - 8 + nSize;
    WavFileHeader.nDataLength = nFileLen;

    // 先将wav文件头信息写入，再将音频数据写入;
    wavFile.write((char *)&WavFileHeader, nSize);
    wavFile.write(cacheFile.readAll());

    cacheFile.close();
    wavFile.close();

    return nFileLen;
}

