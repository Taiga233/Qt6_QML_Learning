import QtQuick 2.15

Rectangle {
    id: rect4_ID
    width: 80
    height: 80
    color: "lightblue"
    radius: 10

    Text {
        anchors.centerIn: parent
        font.pointSize: 14
        text: "04改变行为"
    }

    //定义x属性上的行为动画
    //经常在一个特定的属性值改变时要应用一个动画，在这种情况下，可以使用一个Behavior为一个属性改变指定一个默认动画
    //这里当x改变时（例如鼠标点击位置设置为矩形的位置），使Rectangle使用该动画效果移动到新的位置（鼠标点击的位置）上
    //行为动画时在每次响应一个属性值的变化时触发的，对这些属性的任何改变都会触发他们的动画
    //注意，这里PropertyAnimation的from/to是不需要指定的
    Behavior on x {
        PropertyAnimation {
            duration: 1000              //运动时间为1秒
            easing.type: Easing.InQuart //加速运动
        }
    }

    Behavior on y {
        PropertyAnimation {
            duration: 1000
            easing.type: Easing.InQuart
        }
    }
}
