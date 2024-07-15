#if defined(Q_CC_MSVC)
#pragma warning(disable:4819)
#endif

#include "TestWinRegistryQSetting.h"

#include <QWinJumpList>
#include <QWinJumpListCategory>
#include <QWinJumpListItem>
#include <QFileInfo>
#include <QSettings>
#include <QDir>
#include <QDebug>
#include <QGuiApplication>


TestWinRegistryQSetting::TestWinRegistryQSetting() {}

void TestWinRegistryQSetting::associateFileTypes(const QStringList &fileTypes)
{
    //test jump list
    QWinJumpList jumpList;
    jumpList.recent()->setVisible(true);
    jumpList.recent()->setTitle("Recent");
    // jumpList.recent()->addSeparator(); //仅在使用task（）时才能用
    qDebug() << "recent jumpList:" << jumpList.recent() << "count:" << jumpList.recent()->count() << "items:" << jumpList.recent()->items();
    jumpList.frequent()->setTitle("Frequent");
    jumpList.frequent()->setVisible(true);
    qDebug() << "frequent jumpList:" << jumpList.frequent() << "count:" << jumpList.frequent()->count() << "items:" << jumpList.frequent()->items();
    QString displayName = QGuiApplication::applicationDisplayName();
    QString filePath = QCoreApplication::applicationFilePath();
    QString fileName = QFileInfo(filePath).fileName();
    qDebug() << "displayName:" << displayName << "filePath:" << filePath << "fileName" << fileName;
    //读取本地注册表的配置文件，使用最适合平台的存储格式存储设置
    QSettings settings("HKEY_CURRENT_USER\\Software\\Classes\\Applications\\" + fileName, QSettings::NativeFormat);
    settings.setValue("FriendlyAppName", displayName);
    //默认情况下，未设置组。组对避免一遍又一遍地键入相同设置路径很有用。
    settings.beginGroup("SupportedTypes");
    foreach (const QString& fileType, fileTypes) {
        settings.setValue(fileType, QString());
    }
    settings.endGroup();
    //层层向内设置组
    settings.beginGroup("shell");
    settings.beginGroup("open");
    //设置open组里的内容key:value
    settings.setValue("FriendlyAppName", displayName);
    settings.beginGroup("Command");
    //点代表默认名称（key）
    settings.setValue(".", QChar('"') + QDir::toNativeSeparators(filePath) + QString("\" \"%1\"").arg("xxx"));
}
