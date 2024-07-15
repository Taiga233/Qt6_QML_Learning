#include "TestWinJumpList.h"

TestWinJumpList::TestWinJumpList(QObject *parent)
    : QObject{parent}
{
    jumpItem_m = new QWinJumpListItem(QWinJumpListItem::Link);
    jumpList_m = new QWinJumpList();

    jumpItem_m->setArguments(QStringList(QString("as")));
    jumpItem_m->setDescription("打开资源管理");
    jumpItem_m->setTitle("Open Explorer");

    jumpList_m->tasks()->setTitle("Title");
    jumpList_m->tasks()->addItem(jumpItem_m);
}

TestWinJumpList::~TestWinJumpList()
{
    // the parent manage Class, so don't delete Qt's member
    // delete jumpItem_m;
    // delete jumpList_m;
}

void TestWinJumpList::showJumpList()
{
    jumpList_m->tasks()->setVisible(true);
}
