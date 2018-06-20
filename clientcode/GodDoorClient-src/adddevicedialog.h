#ifndef ADDDEVICEDIALOG_H
#define ADDDEVICEDIALOG_H

#include <QDialog>
#include <QWidget>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QFormLayout>
class AddDeviceDialog : public QDialog
{
    Q_OBJECT
public:
    explicit AddDeviceDialog(QWidget *parent = 0,QString userid = "");

signals:

public slots:

private:
    //变量
    QString userID;
    //控件

    //函数
};

#endif // ADDDEVICEDIALOG_H
