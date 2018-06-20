#include "loginwidget.h"
#include "dbconnection.h"
#include <QMessageBox>

LoginWidget::LoginWidget(QWidget *parent) : QWidget(parent)
{
    //初始化界面
    init_layout();
    //初始化连接
    init_connect();
}

void LoginWidget::init_connect()
{
    connect(button_confirm,&QPushButton::clicked,this,&LoginWidget::action_login);
    connect(button_register,&QPushButton::clicked,this,&LoginWidget::action_register);
}

void LoginWidget::init_layout()
{
    //控件
    label_name = new QLabel("用户名");
    label_name->setParent(this);
    label_passwd = new QLabel("密码");
    label_passwd->setParent(this);
    lineedit_name = new QLineEdit(this);
    lineedit_name->setMaxLength(16);
    lineedit_passwd = new QLineEdit(this);
    lineedit_passwd->setMaxLength(16);
    lineedit_passwd->setEchoMode(QLineEdit::Password);
    button_confirm = new QPushButton("登录");
    button_confirm->setParent(this);
    button_register = new QPushButton("注册");
    button_register->setParent(this);
    //布局
//    formlayout_loginform = new QFormLayout();
//    formlayout_loginform->addRow(label_name,lineedit_name);
//    formlayout_loginform->addRow(label_passwd,lineedit_passwd);
//    formlayout_loginform->addRow(button_confirm,button_register);
//    formlayout_loginform->setAlignment(Qt::AlignCenter);
//    this->setLayout(formlayout_loginform);
    vlayout_all = new QVBoxLayout();
    hlayout_name = new QHBoxLayout();
    hlayout_pw = new QHBoxLayout();
    hlayout_button = new QHBoxLayout();
    hlayout_name->addWidget(label_name);
    hlayout_name->addWidget(lineedit_name);
    hlayout_pw->addWidget(label_passwd);
    hlayout_pw->addWidget(lineedit_passwd);
    hlayout_button->addWidget(button_confirm);
    hlayout_button->addWidget(button_register);
    vlayout_all->addLayout(hlayout_name);
    vlayout_all->addLayout(hlayout_pw);
    vlayout_all->addLayout(hlayout_button);
    this->setLayout(vlayout_all);
}

void LoginWidget::action_login()
{
    if (lineedit_name->text().isEmpty() || lineedit_passwd->text().isEmpty())
    {
        //提示没输入
        QMessageBox::warning(this,
                                 tr("警告"),
                                 tr("用户名密码不能为空！"));
    }
    else
    {
        QString username = lineedit_name->text();
        QString passwd_md5 = QCryptographicHash::hash(lineedit_passwd->text().toLatin1(),QCryptographicHash::Md5).toHex();
        QSqlQuery sql_query;
        QString selectsql="select * from tb_user where user_name = ? and password = ?";
        sql_query.prepare(selectsql);
        sql_query.bindValue(0,username);
        sql_query.bindValue(1,passwd_md5);
        if(!sql_query.exec())
        {
            qDebug()<<sql_query.lastError().text();
            QMessageBox::warning(this,
                                         tr("警告"),
                                         tr("查询数据库出错!"));
            return ;
        }
        else
        {
            if(!sql_query.next())
            {
                //登录失败
                QMessageBox::warning(this,
                                         tr("警告"),
                                         tr("用户名密码错误！"));
                return;
            }
            else
            {
                //登录成功
                emit signal_login(username);
            }
        }
    }

}

void LoginWidget::action_register()
{
    emit signal_toRegister(1);
}
