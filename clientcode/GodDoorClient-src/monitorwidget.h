#ifndef MONITORWIDGET_H
#define MONITORWIDGET_H

#include <QWidget>
#include <VLCQtCore/Common.h>
#include <VLCQtCore/Instance.h>
#include <VLCQtCore/Media.h>
#include <VLCQtCore/Video.h>
#include <VLCQtCore/Audio.h>
#include <VLCQtWidgets/WidgetSeek.h>
#include <VLCQtWidgets/WidgetVideo.h>
#include <VLCQtWidgets/WidgetVolumeSlider.h>
#include <VLCQtCore/MediaPlayer.h>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QHostAddress>
#include <QUdpSocket>
#include <QAudioInput>
#include <QFile>
#include <QTcpSocket>

class MonitorWidget : public QWidget
{
    Q_OBJECT
public:
    explicit MonitorWidget(QWidget *parent = 0,QString url="rtmp://easy.lbbit.com/live/test",int porta=10000,int portc=10001);
    void initPlayer(const QString &url, bool isLocalVideoAddr);//true表示本地地址，false表示流地址

signals:


public slots:
    void on_pushButtonPlay_clicked();

    void on_pushButtonPause_clicked();

    void on_pushButtonStop_clicked();

    void on_pushButtonOpenLock_clicked();

    void on_pushButtonSendVoice_clicked();

    void readPendingDatagrams();

    void goOnSend(qint64 numBytes);  //传送文件内容

private:
    //控件
    QPushButton *button_play;
    QPushButton *button_pause;
    QPushButton *button_stop;
    QPushButton *button_OpenLock;
    QPushButton *button_SendVoice;
    VlcWidgetVideo *m_vlcWidgetVideo;
    QHBoxLayout *hlayout_down;
    QVBoxLayout *vlayout_all;
    //成员
    QTcpSocket *tcpClient;
    QFile *localFile;
    QString fileName;  //文件名
    QString originFilename; //录音原始文件名

    QByteArray outBlock;  //分次传
    qint64 loadSize;  //每次发送数据的大小
    qint64 byteToWrite;  //剩余数据大小
    qint64 totalSize;  //文件总大小

    QFile outputFile;   // class member.
    QAudioInput* audio; // class member.
    bool b_isRecording;
    QUdpSocket *qus;
    QString rtmp_url;
    int port_A,port_C;
    VlcMediaPlayer *_player;
    WId m_winid;
    VlcInstance *_instance;
    VlcMedia *_media;
    //函数
    void send();  //传送文件头信息
    void init_layout();
    void init_connect();
    qint64 addWavHeader(QString catheFileName , QString wavFileName);
};

#endif // MONITORWIDGET_H
