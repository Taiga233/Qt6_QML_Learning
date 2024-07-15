import QtQuick 2.15

Rectangle {
    id: rootRect_ID
    width: animatedImage_ID.width
    height: animatedImage_ID.height
    transform: Rotation {
        //设置图像原点的位置
        origin.x: animatedImage_ID.width / 2
        origin.y: animatedImage_ID.height / 2
        axis {
            x: 0
            y: 1
            z: 1
        }
        //定义Rotation元素中属性angle（角度）上的动画
        NumberAnimation on angle {
            from: 0
            to: 360
            duration: 10000
            loops: Animation.Infinite
        }
    }

    AnimatedImage {
        id: animatedImage_ID
        source: "qrc:/Pictures/Used_Images/GIF/houses_256x175.gif"
    }
}

