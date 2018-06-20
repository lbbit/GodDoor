#include "devicelistwidget.h"
#include <QHeaderView>
#include <QInputDialog>
#include <QMessageBox>
#include "dbconnection.h"
#include "monitorwidget.h"


DeviceListWidget::DeviceListWidget(QWidget *parent,QString userid) : QWidget(parent)
{
    userID = userid;
    init_layout();
    init_connect();
    init_data();
    flush();
}

void DeviceListWidget::action_changePW()
{
    bool ok;
    QString newpasswd = QInputDialog::getText(this, tr("修改密码"),
                                         tr("请输入新密码:"), QLineEdit::Normal,
                                         tr(""), &ok);
    if(!ok)
        return;
    if(newpasswd.length()<6||newpasswd.length()>16)
    {
        QMessageBox::warning(this,
                                     tr("提示"),
                                     tr("修改失败，请确保密码长度在6-16个字符！"));
        return;
    }
    else
    {
        QString passwd_md5 = QCryptographicHash::hash(newpasswd.toLatin1(),QCryptographicHash::Md5).toHex();
        QSqlQuery sql_query;
        QString updatesql="update tb_user set password = ? where user_name = ?";
        sql_query.prepare(updatesql);
        sql_query.bindValue(0,passwd_md5);
        sql_query.bindValue(1,userID);
        if(!sql_query.exec())
        {
            qDebug()<<sql_query.lastError().text();
            return;
        }
        else
        {
            QMessageBox::information(this,
                                         tr("提示"),
                                         tr("密码修改成功！"));
            return;
        }

    }
}

void DeviceListWidget::action_addDev()
{
    bool ok;
    int devIDtoAdd = QInputDialog::getInt(this, tr("添加设备"),
                                         tr("请输入需要添加的设备ID:"), 1, 1, 1000, 1, &ok);
    if(!ok)
        return;
    int userIDinsql,devIDinsql;
    QSqlQuery sql_query;
    //检查设备是否存在
    QString selectsql1 = "select id from tb_device where name = ?";
    //检查设备是否已经绑定
    QString selectsql2 = "select * from tb_device,tb_relation,tb_user where tb_device.name = ? and tb_user.user_name = ?"
                         " and tb_device.id = tb_relation.device_id and tb_user.id = tb_relation.user_id";
    //查到用户id
    QString selectsql3 = "select id from tb_user where user_name = ?";
    //新增设备
    QString insertsql = "insert into tb_relation(user_id,device_id) values(?,?)";
    sql_query.prepare(selectsql1);
    sql_query.bindValue(0,devIDtoAdd);
    qDebug()<<"devIDtoAdd:"<<devIDtoAdd;
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError().text();
        return;
    }
    if(!sql_query.next())
    {
        QMessageBox::warning(this,
                                     tr("提示"),
                                     tr("设备不存在！"));
        return;
    }
    else
    {
        devIDinsql = sql_query.value(0).toInt();
        qDebug()<<"devIDinsql:"<<devIDinsql;
        sql_query.prepare(selectsql2);
        sql_query.bindValue(0,devIDtoAdd);
        sql_query.bindValue(1,userID);
        if(!sql_query.exec())
        {
            qDebug()<<sql_query.lastError().text();
            return;
        }
        if(sql_query.next())
        {
            QMessageBox::warning(this,
                                         tr("提示"),
                                         tr("该设备已绑定！"));
            return;
        }
        else
        {
            sql_query.prepare(selectsql3);
            sql_query.bindValue(0,userID);
            if(!sql_query.exec())
            {
                qDebug()<<sql_query.lastError().text();
                return;
            }
            sql_query.next();
            userIDinsql = sql_query.value(0).toInt();
            qDebug()<<"userIDinsql:"<<userIDinsql;
            sql_query.prepare(insertsql);
            sql_query.bindValue(0,userIDinsql);
            sql_query.bindValue(1,devIDinsql);
            if(!sql_query.exec())
            {
                qDebug()<<sql_query.lastError().text();
                return;
            }
            else
            {
                QMessageBox::information(this,
                                             tr("提示"),
                                             tr("设备绑定成功！"));
                flush();
                return;
            }
        }
    }
}

void DeviceListWidget::action_OpenLock()
{
    //取消使用，移到监控界面
}

void DeviceListWidget::action_sendVoice()
{
    //取消使用，移到监控界面
}

void DeviceListWidget::action_Monitor()
{
    int row = table_devlist->currentRow();
    QString url = "rtmp://easy.lbbit.com/live/"+table_devlist->item(row,0)->text();
    int porta = table_devlist->item(row,2)->text().toInt();
    int portc = table_devlist->item(row,3)->text().toInt();
    MonitorWidget *mw = new MonitorWidget(0,url,porta,portc);
    mw->show();
}

void DeviceListWidget::action_deleteDev()
{
    QString devid = table_devlist->item(table_devlist->currentRow(),0)->text();
    QMessageBox::StandardButton rb = QMessageBox::question(NULL, "删除设备", "是否确认删除改设备？", QMessageBox::Yes | QMessageBox::No, QMessageBox::Yes);
    if(rb == QMessageBox::Yes)
    {
        QSqlQuery sql_query;
        QString deletesql = "delete from tb_relation where device_id in (select id from tb_device where name = ?)";
        sql_query.prepare(deletesql);
        sql_query.bindValue(0,devid);
        if(!sql_query.exec())
        {
            qDebug()<<sql_query.lastError().text();
            return;
        }
        else
        {
            QMessageBox::information(this,
                                         tr("提示"),
                                         tr("设备删除成功！"));
            flush();
            return;
        }
    }


}

void DeviceListWidget::action_FlushButton()
{
    int row = table_devlist->currentRow();
    if(row == -1)
    {
        button_deleteDev->setEnabled(false);
        button_Monitor->setEnabled(false);
    }
    else if(table_devlist->item(row,1)->text() == "在线")
    {
        button_deleteDev->setEnabled(true);
        button_Monitor->setEnabled(true);
    }
    else
    {
        button_deleteDev->setEnabled(true);
        button_Monitor->setEnabled(false);
    }
}

void DeviceListWidget::init_data()
{
    clock_flush.setInterval(20000);
    connect(&clock_flush,SIGNAL(timeout()),this,SLOT(flush()));
    clock_flush.start();
}

void DeviceListWidget::flush()
{
    QSqlQuery sql_query;
    QString selectsql="select tb_device.name,unix_timestamp(now())-unix_timestamp(tb_device.update_time) as a,"
                      "tb_device.port_a,tb_device.port_c from tb_device,tb_relation,tb_user "
                      "where tb_device.id = tb_relation.device_id and tb_user.id = tb_relation.user_id "
                      "and tb_user.user_name = ? "
                      "order by a";
    sql_query.prepare(selectsql);
    sql_query.bindValue(0,userID);
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError().text();
        return;
    }
    int rowindex = 0;
    while(sql_query.next())
    {
        table_devlist->setRowCount(++rowindex);
        for(int col = 0;col < 4;col++)
        {
            if(col == 1)
            {
                //显示在线状态，33秒内活跃过表示在线
                if(sql_query.value(col).toInt()<=33)
                {
                    table_devlist->setItem(rowindex-1,col,new QTableWidgetItem("在线"));
                }
                else
                {
                    table_devlist->setItem(rowindex-1,col,new QTableWidgetItem("离线"));
                }
            }
            else
                table_devlist->setItem(rowindex-1,col,new QTableWidgetItem(sql_query.value(col).toString()));
        }
    }
}

void DeviceListWidget::init_layout()
{
    //控件
    label_user = new QLabel("用户名");
    label_user->setParent(this);
    label_userID = new QLabel();
    label_userID->setParent(this);
    label_userID->setText(userID);
    button_changePW = new QPushButton("修改密码",this);
    button_addDev = new QPushButton("添加设备",this);
    button_deleteDev = new QPushButton("删除设备",this);
    button_deleteDev->setEnabled(false);
    button_Monitor = new QPushButton("查看监控",this);
    button_Monitor->setEnabled(false);
    button_OpenLock = new QPushButton("远程开锁");
    button_OpenLock->setEnabled(false);
    button_sendVoice = new QPushButton("发送语音");
    button_sendVoice->setEnabled(false);
    table_devlist = new QTableWidget(this);
    table_devlist->setMinimumSize(600,400);
    table_devlist->setColumnCount(4);
    QStringList table_header;   //表头
    table_header<<"设备ID"<<"设备状态"<<"语音端口"<<"控制端口";
    table_devlist->setHorizontalHeaderLabels(table_header);
    table_devlist->setSelectionBehavior ( QAbstractItemView::SelectRows); //设置选择行为，以行为单位
    table_devlist->setSelectionMode ( QAbstractItemView::SingleSelection); //设置选择模式，选择单行
    table_devlist->setEditTriggers(QAbstractItemView::NoEditTriggers);   //设置禁止编辑
    table_devlist->horizontalHeader()->setStretchLastSection(true);  //设置表格最后一列延伸至表格最右边
    //布局
    hlayout_top = new QHBoxLayout();
    hlayout_top->addWidget(label_user);
    hlayout_top->addWidget(label_userID);
    hlayout_top->addStretch();
    hlayout_top->addWidget(button_changePW);
    vlayout_left = new QVBoxLayout();
    vlayout_left->addWidget(button_addDev);
//    vlayout_left->addWidget(button_OpenLock);
//    vlayout_left->addWidget(button_sendVoice);
    vlayout_left->addWidget(button_Monitor);
    vlayout_left->addWidget(button_deleteDev);
    vlayout_left->addStretch();
    hlayout_down = new QHBoxLayout();
    hlayout_down->addLayout(vlayout_left);
    hlayout_down->addWidget(table_devlist);
    vlayout_all = new QVBoxLayout();
    vlayout_all->addLayout(hlayout_top);
    vlayout_all->addLayout(hlayout_down);
    this->setLayout(vlayout_all);

}

void DeviceListWidget::init_connect()
{
    connect(button_addDev,&QPushButton::clicked,this,&DeviceListWidget::action_addDev);
    connect(button_changePW,&QPushButton::clicked,this,&DeviceListWidget::action_changePW);
    connect(button_deleteDev,&QPushButton::clicked,this,&DeviceListWidget::action_deleteDev);
    connect(button_Monitor,&QPushButton::clicked,this,&DeviceListWidget::action_Monitor);
    connect(button_OpenLock,&QPushButton::clicked,this,&DeviceListWidget::action_OpenLock);
    connect(button_sendVoice,&QPushButton::clicked,this,&DeviceListWidget::action_sendVoice);
    connect(table_devlist,&QTableWidget::itemSelectionChanged,this,&DeviceListWidget::action_FlushButton);
}


