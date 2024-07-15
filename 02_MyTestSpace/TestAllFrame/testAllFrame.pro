QT = core

#test models
lessThan(QT_MAJOR_VERSION, 6): win32: QT += winextras #for test windows jumpList
#widgets
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
#QQuick
QT += quick qml

#makefile template
TEMPLATE = app

#msvc Chinese character
msvc {
    QMAKE_CFLAGS += /utf-8
    QMAKE_CXXFLAGS += /utf-8
}

CONFIG += c++17 cmdline

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#Common:
SOURCES += \
    TestClasses/TestQStringCapacity.cpp \
    main.cpp
HEADERS += \
    TestClasses/TestQStringCapacity.h \
    TestFunctions/Test_Functions.h \
    general_configuration.h
#Above Qt6.0:
greaterThan(QT_MAJOR_VERSION, 6): SOURCES += \
    TestClasses/TestQString.cpp
greaterThan(QT_MAJOR_VERSION, 6): HEADERS += \
    TestClasses/TestQString.h
#Below Qt6.0:
lessThan(QT_MAJOR_VERSION, 6): SOURCES += \
    TestClasses/TestWinRegistryQSetting.cpp \
    TestClasses/TestWinJumpList.cpp
lessThan(QT_MAJOR_VERSION, 6): HEADERS += \
    TestClasses/TestWinRegistryQSetting.h \
    TestClasses/TestWinJumpList.h

#The Qt Quick Controls 1 module is deprecated since Qt 5.12
#test QuickControls 1 Official Example, QML with C++:
greaterThan(QT_MAJOR_VERSION, 5) | greaterThan(QT_MINOR_VERSION, 12): include(TestClasses/12_TestCalendar_Controls1OfficalExample.pi)

#test use "xxx"_L1
#greaterThan(QT_MAJOR_VERSION, 6): DEFINES += QT_NO_CAST_FROM_ASCII


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/TestQMLModels

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD/TestQMLModels

#general config
DEFINES += GENERAL_CONFIGURATION_H

TARGET = Test_execute

DISTFILES +=

RESOURCES += \
    qml.qrc \
    usedFiles.qrc
