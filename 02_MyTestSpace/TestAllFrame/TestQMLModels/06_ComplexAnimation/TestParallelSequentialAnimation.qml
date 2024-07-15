import QtQuick 2.15

Rectangle { //水平往返移动的矩形背景区
    id: rectangle_ID
    width: 500
    height: 600
    color: "grey"
    clip: true //使得矩形内部的元素不超过矩形边框

    Image { //图像元素显示照片
        id: image_ID
        source: "qrc:/Pictures/Used_Images/Pictures/01_QML.png"
        //照片沿垂直中线下落
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0            //初始时位于顶端
        scale: 0.1      //大小为原尺寸的1/10
        opacity: 0      //初始透明度为0（不可见）
        rotation: 45    //初始放置的角度
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            rectangleSequentialAnimation_ID.running = true  //开启水平方向（矩形往返）动画
            imageSequentialAnimation_ID.running = true      //开启垂直方向（照片掉落）动画
        }
    }

    //矩形的动画组
    SequentialAnimation on x {
        id: rectangleSequentialAnimation_ID
        running: false //初始时关闭动画
        loops: Animation.Infinite //设置动画组一直运行

        //实现往返运动
        NumberAnimation {
            from: 0
            to: parent.parent.width - rectangle_ID.width
            duration: 8000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            // from: parent.parent.width - rectangle_ID.width
            to: 0
            duration: 8000
            easing.type: Easing.InOutQuad
        }
        //在动画中间进行暂停
        PauseAnimation {
            duration: 1000
        }
    }

    //图像的动画组
    SequentialAnimation {
        id: imageSequentialAnimation_ID
        loops: Animation.Infinite //设置动画组一直运行

        ParallelAnimation {
            ScaleAnimator { //缩放动画
                target: image_ID
                to: 1
                duration: 2000
            }
            OpacityAnimator { //透明度动画
                target: image_ID
                to: 1
                duration: 3000
            }
            RotationAnimator { //旋转动画
                target: image_ID
                to: 360
                duration: 2000
            }
            NumberAnimation {
                target: image_ID
                property: "y"
                to: rectangle_ID.height - image_ID.height //运动到矩形区的底部
                easing.type: Easing.OutBounce //为造成照片落地后又“弹起”的效果
                duration: 5000
            }
        }

        PauseAnimation {
            duration: 2000
        }

        ParallelAnimation { //重回初始状态
            NumberAnimation {
                target: image_ID
                property: "y"
                to: 0
                easing.type: Easing.OutQuad
                duration: 1000
            }
            OpacityAnimator {
                target: image_ID
                to: 0
                duration: 1000
            }
        }
    }
}
