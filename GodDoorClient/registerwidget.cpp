#include "registerwidget.h"
#include <QMessageBox>
#include "dbconnection.h"

RegisterWidget::RegisterWidget(QWidget *parent) : QWidget(parent)
{
    init_layout();
    init_connect();
}

void RegisterWidget::action_cancel()
{
    lineedit_name->clear();
    lineedit_pw->clear();
    lineedit_cpw->clear();
    emit signal_cancel(0);
}

void RegisterWidget::action_submit()
{
    //用户输入信息有误
    if(!b_pwLIsEnough || !b_cpwIsRight || lineedit_name->text().isEmpty())
    {
        QMessageBox::warning(this,
                                         tr("警告"),
                                         tr("请正确输入用户名及密码!"));
    }
    else
    {
        //向服务器发送注册请求
        if(0 == userIDIsAvailable(lineedit_name->text()))
        {
            //用户名可用
            if (0 == registerOneUser(lineedit_name->text(),lineedit_pw->text()))
            {
                QMessageBox::information(this,
                                                 tr("提示"),
                                                 tr("注册成功，请返回登录!"));
                lineedit_name->clear();
                lineedit_pw->clear();
                lineedit_cpw->clear();
            }
            else
            {
                //网络问题注册失败
                QMessageBox::warning(this,
                                             tr("警告"),
                                             tr("注册失败!"));
            }
        }
        else
        {
            QMessageBox::warning(this,
                                         tr("警告"),
                                         tr("注册失败!"));
        }
    }
}

void RegisterWidget::action_check_pw()
{
    if(lineedit_pw->text().isEmpty())
    {
        b_pwLIsEnough = false;
        label_pw_flag->clear();
        return;
    }
    if(lineedit_pw->text().length()<6)
    {
        b_pwLIsEnough = false;
        label_pw_flag->setText("少于6位");
    }
    else
    {
        b_pwLIsEnough = true;
        label_pw_flag->clear();
    }
}

void RegisterWidget::action_check_cpw()
{
    if(lineedit_cpw->text().isEmpty())
    {
        b_cpwIsRight = false;
        label_cpw_flag->clear();
        return;
    }
    if(lineedit_cpw->text() == lineedit_pw->text())
    {
        label_cpw_flag->setStyleSheet("color:green");
        label_cpw_flag->setText("正确");
        b_cpwIsRight = true;
    }
    else
    {
        label_cpw_flag->setStyleSheet("color:red");
        label_cpw_flag->setText("密码不同");
        b_cpwIsRight = false;
    }
}

void RegisterWidget::init_data()
{
    b_pwLIsEnough = false;
    b_cpwIsRight = false;
}

//检查用户名是否可用
//回值：
//-1：查询出错
//0：可用
//1：已被占用
int RegisterWidget::userIDIsAvailable(QString userid)
{
    QSqlQuery sql_query;
    QString selectsql="select * from tb_user where user_name = ?";
    sql_query.prepare(selectsql);
    sql_query.bindValue(0,userid);
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError().text();
        QMessageBox::warning(this,
                                     tr("警告"),
                                     tr("查询数据库出错!"));
        return -1;
    }
    else
    {
        if(sql_query.next())
        {
            QMessageBox::warning(this,
                                         tr("警告"),
                                         tr("用户名已被注册!"));
            return 1;
        }
        return 0;
    }
}
/*
 * 注册新用户
 * 返回值：
 * 0：注册成功
 * 1：注册失败
*/
int RegisterWidget::registerOneUser(QString userid, QString passwd)
{
    QString passwd_md5 = QCryptographicHash::hash(passwd.toLatin1(),QCryptographicHash::Md5).toHex();
    QSqlQuery sql_query;
    QString insertsql="insert into tb_user(user_name,password) values(?,?)";
    sql_query.prepare(insertsql);
    sql_query.bindValue(0,userid);
    sql_query.bindValue(1,passwd_md5);
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError().text();
        QMessageBox::warning(this,
                                     tr("警告"),
                                     tr("查询数据库出错!"));
        return 1;
    }
    else
    {
        return 0;
    }

}

void RegisterWidget::init_connect()
{
    connect(button_submit,&QPushButton::clicked,this,&RegisterWidget::action_submit);
    connect(button_cancel,&QPushButton::clicked,this,&RegisterWidget::action_cancel);
    connect(lineedit_cpw,&QLineEdit::textChanged,this,&RegisterWidget::action_check_cpw);
    connect(lineedit_pw,&QLineEdit::textChanged,this,&RegisterWidget::action_check_pw);
}

void RegisterWidget::init_layout()
{
    this->setMinimumSize(400,300);
    //控件
    label_name = new QLabel("用户名");
    label_name->setParent(this);
    label_pw = new QLabel("密码");
    label_pw->setParent(this);
    label_pw_flag = new QLabel(this);
    label_pw_flag->setStyleSheet("color:red");
    label_cpw = new QLabel("确认密码");
    label_cpw->setParent(this);
    label_cpw_flag = new QLabel(this);
    label_pw_flag->setStyleSheet("color:red");
    lineedit_name = new QLineEdit(this);
    lineedit_name->setMaxLength(16);
    lineedit_pw = new QLineEdit(this);
    lineedit_pw->setMaxLength(16);
    lineedit_pw->setEchoMode(QLineEdit::Password);
    lineedit_cpw = new QLineEdit(this);
    lineedit_cpw->setMaxLength(16);
    lineedit_cpw->setEchoMode(QLineEdit::Password);
    button_submit = new QPushButton("确认注册");
    button_submit->setParent(this);
    button_cancel = new QPushButton("返回登录");
    button_cancel->setParent(this);
    //布局
    hlayout_name = new QHBoxLayout();
    hlayout_name->addWidget(label_name);
    hlayout_name->addWidget(lineedit_name);
    hlayout_pw =new QHBoxLayout();
    hlayout_pw->addWidget(label_pw);
    hlayout_pw->addWidget(lineedit_pw);
    hlayout_pw->addWidget(label_pw_flag);
    hlayout_cpw = new QHBoxLayout();
    hlayout_cpw->addWidget(label_cpw);
    hlayout_cpw->addWidget(lineedit_cpw);
    hlayout_cpw->addWidget(label_cpw_flag);
    hlayout_button = new QHBoxLayout();
    hlayout_button->addWidget(button_submit);
    hlayout_button->addWidget(button_cancel);
    vlayout_all = new QVBoxLayout();
    vlayout_all->addStretch();
    vlayout_all->addLayout(hlayout_name);
    vlayout_all->addStretch();
    vlayout_all->addLayout(hlayout_pw);
    vlayout_all->addStretch();
    vlayout_all->addLayout(hlayout_cpw);
    vlayout_all->addStretch();
    vlayout_all->addLayout(hlayout_button);
    vlayout_all->addStretch();
    this->setLayout(vlayout_all);
}
