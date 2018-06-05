#include "mainwidget.h"

MainWidget::MainWidget(QWidget *parent)
    : QWidget(parent)
{
    stack_allwidget = new QStackedLayout();
    lw = new LoginWidget();
    rw = new RegisterWidget();
    stack_allwidget->addWidget(lw);
    stack_allwidget->addWidget(rw);
    stack_allwidget->setCurrentIndex(0);
    this->setLayout(stack_allwidget);
    connect(lw,&LoginWidget::signal_toRegister,this,&MainWidget::change_stackIndex);
    connect(rw,&RegisterWidget::signal_cancel,this,&MainWidget::change_stackIndex);
    connect(lw,&LoginWidget::signal_login,this,&MainWidget::show_dw);
}

MainWidget::~MainWidget()
{

}

void MainWidget::change_stackIndex(int index)
{
    stack_allwidget->setCurrentIndex(index);
}

void MainWidget::show_dw(QString userid)
{
    if (stack_allwidget->count() <= 3)
    {
        dw = new DeviceListWidget(0,userid);
        stack_allwidget->addWidget(dw);
        stack_allwidget->setCurrentIndex(2);
    }
    else
    {
        stack_allwidget->removeWidget(dw);
        dw = new DeviceListWidget(0,userid);
        stack_allwidget->addWidget(dw);
        stack_allwidget->setCurrentIndex(2);

    }

}
