#include "TestQStringCapacity.h"

#include <QDebug>
#include <QChar>
#include <QString>

TestQStringCapacity::TestQStringCapacity(QObject *parent)
    : QObject{parent}
{}

void TestQStringCapacity::test_m()
{
    QString testStr_t = "";
    qint64 recordCapacity_t = testStr_t.capacity();
    qDebug() << "Start!\tCapacity:" << testStr_t.capacity() << "Size:" << testStr_t.size();
    for (int i = 0; i < 10000; ++i) {
        testStr_t.append("a");
        if (Q_UNLIKELY(!!(testStr_t.capacity() - recordCapacity_t))) {
            qDebug() << "test Str has been expanded!" << QString("Capacity:%1 Size:%2 At %3 Cycle.").arg(testStr_t.capacity()).arg(testStr_t.size()).arg(i);
            recordCapacity_t = testStr_t.capacity();
        }
    }
    qDebug() << "End!\tCapacity:" << testStr_t.capacity() << "Size:" << testStr_t.size();
}
