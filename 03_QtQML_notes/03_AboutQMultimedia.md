# ReadyForQMultimedia

- Qt6.2及以上新加入的`QMediaCaptureSession `用来捕获和录制音视频。
- *The capturing and recording functionality has undergone the largest API changes in Qt 6.*
- 需要注意的是，Repeater控件只能用于展示静态的数据，它并不适合用于实时动态更新的情况。如果你需要动态更新控件的数据，可以考虑使用其他控件，例如ListView或GridView。



> 链接：
>
> - [Qt Multimedia in Qt 6](https://www.qt.io/blog/qt-multimedia-in-qt-6)



# Point

## I-派生类防止浅拷贝

`Q_DISABLE_COPY`，`Q_DISABLE_MOVE`，`Q_DISABLE_COPY_MOVE`。（这几个宏是Qt5.13后才有的，Qt6.7里不能用`Q_DISABLE_MOVE`这个宏了）

- `Q_DISABLE_COPY`：**拷贝构造函数**被删除，**拷贝赋值**函数被删除。

- `Q_DISABLE_MOVE`：**移动构造**函数被删除，**移动赋值**函数被删除。

- `Q_DISABLE_COPY_MOVE`：拷贝构造函数、拷贝赋值函数、移动构造函数、移动赋值函数都被删除。

- ```c++
  MyClass(const MyClass &) = delete; //拷贝构造函数被删除
  MyClass(MyClass &&) = delete; //移动构造函数被删除,注意没有const
  MyClass &operator=(const MyClass &) = delete; //拷贝赋值函数被删除
  MyClass& operator=(MyClass&&); //移动赋值函数被删除,注意没有const
  ```

## II-属性绑定

关于`NOTIFY`

- 在用C++写的类属性绑定中，在`Q_PROPERTY()`中添加了一个`NOTIFY`功能，每当属性的值发出改变时，就会发送该信号，从而使得绑定的目标属性自动更新其值。
- 注意，在调用`WRITE`功能的函数（例如`setXxxx()`）时，必须判断设置的值是否与当前属性的值相等，这样**确保信号不会不必要的发出**，从而导致可能死循环的事情发生。

## III- QML/C++打开摄像头

结合C++和QML方式实现打开摄像头（Qt6.2及以上）

- 代码如下：

- `main.qml`：

  ```js
  import MyQuickUsbCamera 1.0
  //省略了外面的window
  Rectangle {
      id: usbCamera1_ID
      width: 320
      height: 240
      anchors.left: parent.left
      anchors.top: parent.top
      color: "burlywood"
  
      UsbCamera {
          //这里是自己实现的Type，在main.cpp中注册
          //qmlRegisterType<QuickUsbCamera>("MyQuickUsbCamera", 1, 0, "UsbCamera");
          id: camera1_ID
          videoOutput: videoOutput1_ID
      }
  
      VideoOutput {
          id: videoOutput1_ID
          anchors.fill: parent
      }
  
      Text {
          anchors.centerIn: parent
          text: "USB Camera is unavailable"
          color: "steelblue"
          font.pointSize: 32
          wrapMode: Text.WordWrap
          visible: {
              !(camera1_ID.isCameraAvailable)
          }
      }
  }
  ```

- `QuickUsbCamera.cpp`

- ```c++
  #include "QuickUsbCamera.h"
  
  #include <QVideoFrame>
  #include <QVideoSink>
  #include <QDebug>
  
  QuickUsbCamera::QuickUsbCamera(QObject *parent)
      : QObject{parent}, m_camera(new QCamera()), m_captureSession(new QMediaCaptureSession()), m_mediaDevices(new QMediaDevices())
  {
      //输入端口更改则重新初始化Camera
      QObject::connect(m_mediaDevices, &QMediaDevices::videoInputsChanged, this, &QuickUsbCamera::initCamera);
      QObject::connect(m_camera, SIGNAL(errorOccurred(QCamera::Error,QString)), this, SLOT(printErrorToConsole(QCamera::Error,QString)));
      this->initCamera();
  }
  
  QuickUsbCamera::~QuickUsbCamera()
  {
      delete m_mediaDevices;
      delete m_captureSession;
  }
  
  QObject *QuickUsbCamera::getVideoOutput()
  {
      return m_captureSession->videoOutput();
  }
  
  bool QuickUsbCamera::getIsCameraAvailable()
  {
      return m_isCameraAvailable;
  }
  
  bool QuickUsbCamera::setVideoOutput(QObject *videoOutput)
  {
      //必须判断设置的值是否与当前属性的值相等，这样确保信号不会不必要的发出，从而导致可能死循环的事情发生。
      qDebug() << "setVideoOutput:" << videoOutput->objectName();
      if (videoOutput != m_captureSession->videoOutput()) {
          qDebug() << "not equal";
          m_captureSession->setVideoOutput(videoOutput);
          emit videoOutputChanged(videoOutput);
          return true;
      } else {
          return false;
      }
  }
  
  void QuickUsbCamera::printErrorToConsole(QCamera::Error error, const QString &message)
  {
      qDebug() << "Camera open error:" << error;
      qDebug() << "error message:" << message;
  }
  
  void QuickUsbCamera::initCamera()
  {
      // if (nullptr != m_captureSession->videoOutput()) {
      //     qDebug() << "videoOutput isn't null";
      //     // auto videoSink = m_captureSession->videoOutput()->property("videoSink").value<QVideoSink *>();
      //     auto videoSink = m_captureSession->videoSink();
      //     if (nullptr != videoSink) {
      //         qDebug() << "videoSink isn't null";
      //         videoSink->setVideoFrame(QVideoFrame());
      //     }
      // }
  
      auto videoInputs = m_mediaDevices->videoInputs();
      qDebug() << "videoInputs size:" << videoInputs.size();
      m_isCameraAvailable = false; //重置一下
  
      for (const auto &it : videoInputs) {
          qDebug() << "id:" << it.id();
          qDebug() << "description:" << it.description();
          qDebug() << "isDefault:" << it.isDefault() << "isNull:" << it.isNull();
          qDebug() << "photoResolutions:" << it.photoResolutions();
          qDebug() << "position:" << it.position() << "\n";
      }
  
      for (const auto &it : videoInputs) {
          if (it.id().contains("usb")) {
              m_camera = new QCamera(it);
              m_captureSession->setCamera(m_camera);
              m_camera->setActive(true);
              // m_camera->start(); //Same as setActive(true).
              m_isCameraAvailable = true;
              break;
          }
      }
      emit this->isCameraAvailableChanged(m_isCameraAvailable);
  }
  ```

- `QuickUsbCamera.h`

- ```c++
  #ifndef QUICKUSBCAMERA_H
  #define QUICKUSBCAMERA_H
  
  #include <QObject>
  #include <QCamera>
  #include <QMediaCaptureSession>
  #include <QMediaDevices>
  #include <qqml.h>
  
  class QuickUsbCamera : public QObject
  {
      Q_OBJECT
  
      Q_DISABLE_COPY(QuickUsbCamera);
      Q_PROPERTY(QObject *videoOutput READ getVideoOutput WRITE setVideoOutput NOTIFY videoOutputChanged);
      //是否可用，注意避免信号无意义的emit，导致无限递归
      Q_PROPERTY(bool isCameraAvailable READ getIsCameraAvailable NOTIFY isCameraAvailableChanged);
      QML_ELEMENT
  
  public:
      explicit QuickUsbCamera(QObject *parent = nullptr);
      ~QuickUsbCamera();
  
  public slots:
      QObject *getVideoOutput();
      bool getIsCameraAvailable();
  
      bool setVideoOutput(QObject *videoOutput);
  
      void printErrorToConsole(QCamera::Error error, const QString &message);
  
  private slots:
      void initCamera();
  
  signals:
      void videoOutputChanged(QObject *);
      void isCameraAvailableChanged(bool);
  
  private:
      QCamera *m_camera{nullptr};
      QMediaCaptureSession *m_captureSession{nullptr}; //capture、record
      QMediaDevices *m_mediaDevices{nullptr};
      bool m_isCameraAvailable{false};
  };
  
  #endif // QUICKUSBCAMERA_H
  ```

- `pro文件`中：

- ```bash
  QT += quick multimedia multimediawidgets
  ```

## IV-纯QML打开摄像头

- 研究了下Qt6的官方文档，根据例子发现直接用纯QML方式可实现打开摄像头等功能。

- ```js
  //下面是官方给的例子
  MediaDevices {
      id: mediaDevices
  }
  CaptureSession {
      camera: Camera {
          cameraDevice: mediaDevices.defaultVideoInput
      }
      videoOutput: videoOutput_ID
  }
  VideoOutput {
      id: videoOutput_ID
      anchors.fill: parent
  }
  ```

- 当然pro文件里面还是要把该用的模块加上去的：`QT += quick multimedia multimediawidgets`。

- `main.qml`源码(省略了外层)：

- ```js
  import QtMultimedia
  
  MediaDevices {
      id: mediaDevices_ID
  }
  CaptureSession {
      camera: Camera {
          id: camera2_ID
          // cameraDevice: mediaDevices_ID.videoInputs[0]
  
          cameraDevice: {
              for (var i = 0; i < mediaDevices_ID.videoInputs.length; i++) {
                  console.log("id:" + mediaDevices_ID.videoInputs[0].id.toString());
                  if (mediaDevices_ID.videoInputs[i].id.toString().indexOf("usb") !== -1) {
                      console.log("find usb " + i + ", id: " + mediaDevices_ID.videoInputs[i].id.toString());
                      return mediaDevices_ID.videoInputs[i];
                  }
              }
          }
      }
      videoOutput: videoOutput2_ID
  }
  
  VideoOutput {
      id: videoOutput2_ID
      anchors.fill: parent
  }
  
  Component.onCompleted: {
      camera2_ID.start();
  }
  
  Text {
      anchors.centerIn: parent
      text: "USB Camera is unavailable"
      color: "steelblue"
      font.pointSize: 32
      wrapMode: Text.WordWrap
      visible: {
          camera2_ID.error === Camera.NoError ? false : true
      }
  }
  ```

## V-one source, two camera

- one input camera source, two video output;

- 突发奇想能不能做个下拉框，同时选择相同的就可以显示两个相同的画面了。

- 实践了下，确实可以。结合上个点的源码：

- ```js
  ShaderEffectSource {
          id: usbCamera2_Shader_ID
          sourceItem: usbCamera2_ID
          anchors.left: parent.left
          anchors.top: parent.top
          width: 320
          height: 240
      }
  ```

- 参考链接：[One source, two video output in QML - Stack Overflow](https://stackoverflow.com/questions/66183441/one-source-two-video-output-in-qml)

## VI-关于Qt6使用带参数信号处理问题

原文报错是：

```
Parameter "xxxxxxx" is not declared. Injection of parameters into signal handlers is deprecated. Use JavaScript functions with formal parameters instead.
```

原因是因为：

- 自**Qt6**开始，QML中使用信号**处理函数参数**时，需要**显式捕获参数**，写法如下：

- ```javascript
  onPositionChanged: function(xxxxxxx){
   ...
  }
  ```

- There are no warning messages in QT5.

## VII-QML中延时的功能

- 因为两次拍照时间间隔问题，导致不能直接拍完照后立马`capture()`

- 所以设计一个延时功能：

- ```javascript
  Timer {
      id: delayTimer_ID
  }
  
  //延时功能
  function delay_func(delayTime, cb) {
      delayTimer_ID.interval = delayTime;
      delayTimer_ID.repeat = false;
      delayTimer_ID.triggered.connect(cb);
      delayTimer_ID.start();
  }
  
  //具体使用
  Button {
      onClicked: delay(5000, function() { xxxx.visible = true;} );
  }
  ```
  
- **注意**：这里函数直接作为响应连接的地方会有问题，建议不这么用(2024年4月16日11点21分)

> 拓展：qml中有个延时按钮，其中不同信号发射的时机是不一样的，可以活用一下。

- ```javascript
  DelayButton {
      delay: 1000
      onClicked: console.log("clicked");
      onActivated: console.log("activated");
      onPressed: console.log("pressed");
      onReleased: console.log("released");
  }
  ```

## VIII-关于Image设置source后更改图像内容不同步

```js
Image {
    id: image_ID
    cache: false //首先这里要设置不缓存
    source: ""
}

function xxxx() {
    image_ID.source = ""; //这里作用是清空一下缓存
    image_ID.source = "xxxxxxx"; //然后再设置一次资源
}
```

## IX-关于打包QML做的程序

- 先把`Release`版的程序单独拷贝到一个目录里。
- 然后使用qt自带的打包工具（类似命令行），注意**区分***32bit/64bit*。

- ```bash
  cd xxxxxxx #到程序所在位置
  ```

- ```bash
  windeployqt  xxx.exe  --qmldir=xxxxxxx
  #注意，这里的目录是你工程目录里面的那些qml文件所在位置，一般跟main.qml同级
  ```

- 这样就可以了，如果打包完成后打不开程序那就直接把所有的dll都拷贝进去然后一个个试吧。

