import QtQuick 2.15
import QtQuick.Controls 2.4

/*
    方便通用的菜单
    -------Properties-------
    subMenu[read-only](Menu):如果有子菜单则右边会有小箭头
    highlighted(bool):对比色设置
    enabled(bool):是否可显示
    checkable(bool):是否有多选框
    checked(bool):有多选框后是否选中
*/
Menu {
    id: menu_ID
    readonly property int menuWidth: 240
    readonly property int menuHeight: 40

    delegate: MenuItem {
        id: menuItem_ID
        implicitWidth: menuWidth
        implicitHeight: 40

        arrow: Canvas {
            x: parent.width - width
            implicitWidth: menuHeight
            implicitHeight: menuHeight
            visible: menuItem_ID.subMenu //通过是否有子菜单来显示箭头
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = menuItem_ID.highlighted ? "#7D8E95" : "#FFD5AF"
                ctx.moveTo(15, 15)
                ctx.lineTo(width - 15, height / 2)
                ctx.lineTo(15, height - 15)
                ctx.closePath()
                ctx.fill()
            }
        }

        indicator: Item {
            implicitWidth: menuHeight
            implicitHeight: menuHeight
            Rectangle {
                width: parent.width * 0.65
                height: parent.width * 0.65
                anchors.centerIn: parent
                visible: menuItem_ID.checkable
                border.color: "#FFD5AF"
                radius: 3
                Rectangle {
                    width: menuHeight * 0.35
                    height: menuHeight * 0.35
                    anchors.centerIn: parent
                    visible: menuItem_ID.checked
                    color: "#344648"
                    radius: 2
                }
            }
        }

        contentItem: Text {
            leftPadding: menuItem_ID.indicator.width
            rightPadding: menuItem_ID.arrow.width
            text: menuItem_ID.text
            font: menuItem_ID.font
            opacity: enabled ? 1.0 : 0.3
            color: menuItem_ID.highlighted ? "#b3dee5" : "#344648"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            anchors.centerIn: parent
            // implicitWidth: (menuWidth - 4) //!不能用implicit!//
            width: menuWidth - background_ID.border.width * 2
            implicitHeight: menuHeight
            radius: 5
            opacity: enabled ? 1 : 0.3
            color: menuItem_ID.highlighted ? "#344648" : enabled ? "transparent" : "gray"
        }
    }

    background: Rectangle {
        id: background_ID
        implicitWidth: menuWidth
        implicitHeight: menuHeight
        color: "#7D8E95"
        border.color: "#FFD5AF"
        border.width: 2
        radius: 5
    }
}
