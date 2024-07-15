#ifndef TESTQSTRINGCAPACITY_H
#define TESTQSTRINGCAPACITY_H

#include <QObject>

class TestQStringCapacity : public QObject
{
    Q_OBJECT
public:
    explicit TestQStringCapacity(QObject *parent = nullptr);

    void test_m();

signals:
};

#endif // TESTQSTRINGCAPACITY_H
