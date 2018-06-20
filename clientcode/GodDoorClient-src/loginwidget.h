#ifndef LOGINWIDGET_H
#define LOGINWIDGET_H

#include <QWidget>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QFormLayout>
#include <QVBoxLayout>
#include <QHBoxLayout>
class LoginWidget : public QWidget
{
    Q_OBJECT
public:
    explicit LoginWidget(QWidget *parent = 0);

//信号函数
signals:
    void signal_login(QString);
    void signal_toRegister(int);

//槽函数
public slots:
    void action_login();
    void action_register();

private:
    //私有控件
    QLabel *label_name;
    QLabel *label_passwd;
    QLineEdit *lineedit_name;
    QLineEdit *lineedit_passwd;
    QPushButton *button_confirm;
    QPushButton *button_register;
    QFormLayout *formlayout_loginform;
    QHBoxLayout *hlayout_name;
    QHBoxLayout *hlayout_pw;
    QHBoxLayout *hlayout_button;
    QVBoxLayout *vlayout_all;
    //私有函数
    //初始化信号槽
    void init_connect();
    //初始化界面
    void init_layout();
};

#endif // LOGINWIDGET_H
