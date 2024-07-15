#ifndef TESTWINREGISTRYQSETTING_H
#define TESTWINREGISTRYQSETTING_H

#include <QObject>

class TestWinRegistryQSetting
{
public:
    TestWinRegistryQSetting();

    static void associateFileTypes(const QStringList &fileTypes);
};

#endif // TESTWINREGISTRYQSETTING_H
