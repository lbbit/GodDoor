#ifndef MAINWIDGET_H
#define MAINWIDGET_H

#include <QWidget>
#include <QStackedLayout>
#include "loginwidget.h"
#include "registerwidget.h"
#include "devicelistwidget.h"

class MainWidget : public QWidget
{
    Q_OBJECT

public:
    MainWidget(QWidget *parent = 0);
    ~MainWidget();

public slots:
    void change_stackIndex(int index);
    void show_dw(QString userid);


private:
    QStackedLayout *stack_allwidget;
    LoginWidget *lw;
    RegisterWidget *rw;
    DeviceListWidget *dw;
};

#endif // MAINWIDGET_H
