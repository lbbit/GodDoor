#include "mainwidget.h"
#include "loginwidget.h"
#include "registerwidget.h"
#include "devicelistwidget.h"
#include "dbconnection.h"
#include "monitorwidget.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qDebug()<<"1";
    QSqlDatabase db = DBConnection::initDB();
    if(!db.open())
    {
        qDebug()<<db.lastError().text();
        return 1;
    }
    MainWidget w;
    w.show();
//    LoginWidget lw;
//    lw.show();
//    RegisterWidget rw;
//    rw.show();
//    DeviceListWidget dw(NULL,"lbb");
//    dw.show();
//    MonitorWidget mw(0,"rtmp://easy.lbbit.com/live/test",10001,10002);
//    mw.show();
    return a.exec();
}
