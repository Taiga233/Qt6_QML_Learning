#ifndef IMAGEINFO_H
#define IMAGEINFO_H

#include <QObject>
#include <QColor>
#include <QImage>

class ImageInfo : public QObject
{
    Q_OBJECT
public:
    explicit ImageInfo(QObject *parent = nullptr);

    Q_INVOKABLE QString getPixelColor(const QString &imagePath, int x, int y);
};

#endif // IMAGEINFO_H
