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
