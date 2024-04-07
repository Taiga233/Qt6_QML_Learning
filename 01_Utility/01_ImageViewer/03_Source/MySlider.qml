import QtQuick 2.15
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.15
Slider {
    id: slider_ID
    value: 0.5

    background: Rectangle {
        x: slider_ID.leftPadding
        y: slider_ID.topPadding + slider_ID.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 7
        width: slider_ID.availableWidth
        height: implicitHeight
        radius: height / 2
        color: "#bacec1"      // 设置滑动条颜色
        border.color: "#2a403d"
        border.width: 1
        Rectangle {
            width: slider_ID.visualPosition * parent.width
            height: parent.height
            color: "#1d3124"
            border.color: "#2a403d"
            border.width: 1
            radius: parent.height / 2
        }
    }

    handle: Rectangle {   // 设置滑块
        x: slider_ID.leftPadding + slider_ID.visualPosition * (slider_ID.availableWidth - width)
        y: slider_ID.topPadding + slider_ID.availableHeight / 2 - height / 2
        implicitWidth: 13
        implicitHeight: 13
        radius: 6
        color: slider_ID.hovered ? "#E2E2E2" : "#787878"
        border.color: "#2a403d"
        border.width: 1
    }
}
