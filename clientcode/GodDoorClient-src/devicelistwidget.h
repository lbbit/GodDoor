#ifndef DEVICELISTWIDGET_H
#define DEVICELISTWIDGET_H

#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QTableWidget>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QTimer>

class DeviceListWidget : public QWidget
{
    Q_OBJECT
public:
    explicit DeviceListWidget(QWidget *parent = 0,QString userid = "");

signals:

public slots:
    void action_changePW();
    void action_addDev();
    void action_OpenLock();
    void action_sendVoice();
    void action_Monitor();
    void action_deleteDev();
    void action_FlushButton();
    void flush();

private:
    //控件
    QLabel *label_user;
    QLabel *label_userID;
    QPushButton *button_changePW;
    QPushButton *button_addDev;
    QPushButton *button_OpenLock;
    QPushButton *button_sendVoice;
    QPushButton *button_Monitor;
    QPushButton *button_deleteDev;
    QTableWidget *table_devlist;
    QHBoxLayout *hlayout_top;
    QVBoxLayout *vlayout_left;
    QHBoxLayout *hlayout_down;
    QVBoxLayout *vlayout_all;
    //变量
    QString userID;
    QTimer clock_flush;
    //函数
    void init_layout();
    void init_connect();
    void init_data();
};

#endif // DEVICELISTWIDGET_H
