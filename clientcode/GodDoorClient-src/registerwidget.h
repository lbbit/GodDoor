#ifndef REGISTERWIDGET_H
#define REGISTERWIDGET_H

#include <QWidget>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QFormLayout>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QFormLayout>

class RegisterWidget : public QWidget
{
    Q_OBJECT
public:
    explicit RegisterWidget(QWidget *parent = 0);

signals:
    void signal_cancel(int);//点击退出按钮时发出0信号
public slots:
    void action_submit();
    void action_cancel();
    void action_check_cpw();
    void action_check_pw();
private:
    //私有变量
    bool b_pwLIsEnough;
    bool b_cpwIsRight;
    //私有控件
    QLabel *label_name;
    QLabel *label_pw;
    QLabel *label_pw_flag;
    QLabel *label_cpw;
    QLabel *label_cpw_flag;
    QLineEdit *lineedit_name;
    QLineEdit *lineedit_pw;
    QLineEdit *lineedit_cpw;
    QPushButton *button_submit;
    QPushButton *button_cancel;
    QHBoxLayout *hlayout_name;
    QHBoxLayout *hlayout_pw;
    QHBoxLayout *hlayout_cpw;
    QHBoxLayout *hlayout_button;
    QVBoxLayout *vlayout_all;
    //私有函数
    void init_layout();
    void init_connect();
    void init_data();
    int userIDIsAvailable(QString userid);
    int registerOneUser(QString userid,QString passwd);
};

#endif // REGISTERWIDGET_H
