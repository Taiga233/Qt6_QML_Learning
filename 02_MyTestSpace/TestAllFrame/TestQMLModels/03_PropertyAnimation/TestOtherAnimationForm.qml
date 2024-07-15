import QtQuick 2.15

Rectangle {
    id: rectangle_ID
    height: 200
    border.color: "pink"
    border.width: 5

    MouseArea {
        id: mouseArea_ID
        anchors.fill: parent
    }

    Rectangle {
        id: transitionRect_ID
        x: 50
        y: 0
        width: 100
        height: 100

        //颜色值的变换
        ColorAnimation on color {
            from: "blue"
            to: "aqua"
            duration: 10000
            loops: Animation.Infinite
        }

        //旋转的变换
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 10000
            loops: Animation.Infinite
            direction: RotationAnimation.Clockwise //表示顺时针
        }

        //数值的变换
        NumberAnimation on radius {
            from: 0
            to: 50
            duration: 10000
            loops: Animation.Infinite
        }

        PropertyAnimation on x {
            from: 50
            to: (rectangle_ID.width - 100) //得设最小宽度
            duration: 10000
            loops: Animation.Infinite
            easing.type: Easing.InSine
        }
        PropertyAnimation on y {
            from: 0
            to: rectangle_ID.height - transitionRect_ID.height //得设最小宽度
            duration: 10000
            loops: Animation.Infinite
            easing.type: Easing.InSine
        }
    }
}
