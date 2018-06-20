#-------------------------------------------------
#
# Project created by QtCreator 2018-05-03T22:37:34
#
#-------------------------------------------------

QT       += core gui
QT       += network
QT       += sql
QT       += multimedia

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = GodDoorClient
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += main.cpp\
        mainwidget.cpp \
    loginwidget.cpp \
    registerwidget.cpp \
    dbconnection.cpp \
    devicelistwidget.cpp \
    changepwwidget.cpp \
    monitorwidget.cpp \
    adddevicedialog.cpp

HEADERS  += mainwidget.h \
    loginwidget.h \
    registerwidget.h \
    dbconnection.h \
    devicelistwidget.h \
    changepwwidget.h \
    monitorwidget.h \
    adddevicedialog.h
win32:CONFIG(release, debug|release): LIBS += -L$$PWD/vlc-lib/ -lVLCQtCore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/vlc-lib/ -lVLCQtCored

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/vlc-lib/ -lVLCQtWidgets
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/vlc-lib/ -lVLCQtWidgetsd
