#include "ImageInfo.h"

#include <QDebug>

ImageInfo::ImageInfo(QObject *parent) : QObject(parent)
{

}

QString ImageInfo::getPixelColor(const QString &imagePath, int x, int y)
{
    qDebug() << "image path:" << imagePath << "x:" << x << "y" << y;
    QImage image(imagePath);
    if (image.valid(x, y)) {
        QColor color = image.pixelColor(x, y);
        return QString("R:%1, G:%2, B:%3").arg(color.red()).arg(color.green()).arg(color.blue());
    } else {
        return "Invalid pixel";
    }
}
