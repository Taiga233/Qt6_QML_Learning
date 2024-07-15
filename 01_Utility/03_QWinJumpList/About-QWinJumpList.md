# About QWinJumpList

[TOC]

> 前言：最近发现桌面任务栏右键有个跳转菜单，这样固定到任务栏之后不需要点进去应用就可以实现一些功能，比如打开最近项目之类的。

------

简介：

- Jump Lists是Windows 7开始引入的新功能，该功能允许用户查看固定在任务栏中程序最近打开的文件。
- Jump Lists由应用软件或者系统创建，作用是方便用户可以直接跳转到最近打开的文件或文件夹。
- Jump List显示的列表数量是有限的，在Windows 7/8操作系统中，用户可以通过更改注册表来修改Jump List的条数，但在Windows 10中，这个数量被固定了，用户无法自行修改。

## Qt5

### QGUI方案

*My Kits：Qt5.15.2 MSVC2019/MinGW8.1.0 32/64bit*

- 首先工程文件中添加模块`QT += winextras`；

- 头文件：

  - `#include <QWinJumpList>`
  - `#include <QWinJumpListCategory>`
  - `#include <QWinJumpListItem>`

- `TestWinJumpList.h`

- ```c++
  #include <QObject>
  #include <QWinJumpList>
  #include <QWinJumpListCategory>
  #include <QWinJumpListItem>
  
  class TestWinJumpList : public QObject
  {
      Q_OBJECT
  public:
      explicit TestWinJumpList(QObject *parent = nullptr);
      ~TestWinJumpList();
      void showJumpList();
  private:
      QWinJumpListItem *jumpItem_m{(Q_NULLPTR)};
      QWinJumpList *jumpList_m{(Q_NULLPTR)};
  };
  ```

- `TestWinJumpList.cpp`

- ```c++
  #include "TestWinJumpList.h"
  
  TestWinJumpList::TestWinJumpList(QObject *parent)
      : QObject{parent}
  {
      jumpItem_m = new QWinJumpListItem(QWinJumpListItem::Link);
      jumpList_m = new QWinJumpList();
  
      jumpItem_m->setArguments(QStringList(QString("as")));
      jumpItem_m->setDescription("打开资源管理");
      jumpItem_m->setTitle("Open Explorer");
  
      jumpList_m->tasks()->setTitle("Title");
      jumpList_m->tasks()->addItem(jumpItem_m);
  }
  
  TestWinJumpList::~TestWinJumpList()
  {
      // the parent manage Class, so don't delete Qt's member
      // delete jumpItem_m;
      // delete jumpList_m;
  }
  
  void TestWinJumpList::showJumpList()
  {
      jumpList_m->tasks()->setVisible(true);
  }
  ```

- `main.cpp`

- ```c++
  QApplication app_(argc, argv);
  QWidget w;
  w.show();
  TestWinJumpList jumpList(&w);
  jumpList.showJumpList();
  return app_.exec();
  ```



参考链接：

> - [Using JumpList to store files opened in the application when using Qt (evileg.com)](https://evileg.com/en/post/276/)
> - [How to use a QWinJumpList? | Qt Forum](https://forum.qt.io/topic/76619/how-to-use-a-qwinjumplist/2)
> - [QWinJumpList Class | Qt Windows Extras 5.15.16](https://doc.qt.io/qt-5/qwinjumplist.html)
> - https://doc.qt.io/qt-5/qwinjumplistcategory.html

### QML方案

- `main.qml`

- ```js
  import QtQuick.Window 2.15
  import QtQuick 2.15
  
  import "qrc:/CustomQmlModels/TestQMLModels"
  
  Window {
      id: root
      visible: true;
      width: 1280
      height: 720
  
      TestCustomJumpList {
          id: customJumpList_ID
          Component.onCompleted: {
              console.log("custom items:" + customJumpList_ID.categories.length);
              console.log("recent items:" + customJumpList_ID.recent.items);
              console.log("frequent items:" +customJumpList_ID.frequent.items);
          }
      }
  
      Component.onCompleted: {
          console.log("Hello World!");
      }
  }
  ```

- `TestCustomJumpList.qml`

- ```javascript
  import QtQuick 2.15
  import QtWinExtras 1.15
  
  JumpList {
      id: jumpList_ID
      recent.visible: true
      frequent.visible: true
      tasks: JumpListCategory {
          xxxxxxx
      }
      
      JumpListCategory {
          xxxxxxx
      }
  }
  ```



------

## Qt6

- Qt6移除了包括`QWinJumpList`、`QWinJumpListCategory`、`QWinJumpItem`这些类。
- 参考链接：
  - [Changes to Qt Extras Modules | Qt 6.2](https://doc.qt.io/qt-6.2/extras-changes-qt6.html)
- 因为这些相关类只能在Windows上使用，不能够跨平台。
- 之前在使用这些类的时候需要加上windows的模组`QT += winextras`，但是像像`winextras`、`x11extras`、`macextras`和`androidextras`这样的模块只适用于特定的操作系统。例如，在Linux上，qmake在创建使用`winextras`的项目时会出现错误。
- 参考链接：
  - [[#QTBUG-89564\] Clean up QtWinExtras for Qt 6 - Qt Bug Tracker](https://bugreports.qt.io/plugins/servlet/mobile#issue/QTBUG-89564)
  - [[QTBUG-94007\] Add API to set application-wide menu for use in Dock/task bar - Qt Bug Tracker](https://bugreports.qt.io/browse/QTBUG-94007)
- 那么如果确实需要跨平台该怎么办呢？下面是一个参考：
  - [[SOLVED\] How to use QtWinExtras in cross-platform application | Qt Forum](https://forum.qt.io/topic/52782/solved-how-to-use-qtwinextras-in-cross-platform-application?lang=zh-CN)
- 那如何在Qt6的开发项目中使用类似任务栏右键的跳转列表呢？
  - 如果是macOS平台，可以使用`QMenu::setAsDockMenu()`；
  - Windows平台暂时还没找到解决方案，或许等Qt6.7以后？
  - *Should be exposed as cross platform API, e.g. QGuiApplication::setMenu().**
  - **We should find a cross platform API for this. e.g. QGuiApplication::setMenu()*
  - 后续可能会做一个这样能跨平台的接口。
- 关于这个问题链接：[How do I get QtWinExtras [winextras\] module for Qt 6.3.1 if I build it manually? | Qt Forum](https://forum.qt.io/topic/137717/how-do-i-get-qtwinextras-winextras-module-for-qt-6-3-1-if-i-build-it-manually)

[^代码都在Github个人仓库]: 

