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
