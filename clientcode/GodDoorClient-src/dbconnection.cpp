#include "dbconnection.h"

DBConnection::DBConnection()
{

}

QSqlDatabase DBConnection::initDB()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("easy.lbbit.com");
    db.setDatabaseName("base");
    db.setPort(3306);
    //根据数据库进行配置
    db.setUserName("root");
    db.setPassword("root");
    return db;
}
