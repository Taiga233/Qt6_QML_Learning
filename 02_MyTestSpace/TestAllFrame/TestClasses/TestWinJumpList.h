#ifndef TESTWINJUMPLIST_H
#define TESTWINJUMPLIST_H

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

#endif // TESTWINJUMPLIST_H
