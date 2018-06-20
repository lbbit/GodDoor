#ifndef DBCONNECTION_H
#define DBCONNECTION_H
#include<QtSql>
#include <QSqlDatabase>

class DBConnection
{
public:
    DBConnection();
    static QSqlDatabase initDB();
};

#endif // DBCONNECTION_H
