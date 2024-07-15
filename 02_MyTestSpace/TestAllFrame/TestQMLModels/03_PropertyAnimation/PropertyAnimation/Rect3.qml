import QtQuick 2.15

Rectangle {
    id: rect3_ID
    width: 80
    height: 80
    color: "aqua"
    radius: 10

    Text {
        anchors.centerIn: parent
        font.pointSize: 14
        text: "03独立元素"
    }

    //这是一个独立的动画元素，它不会绑定到任何对象或属性上
    //一个独立的动画元素默认是不会运行的，需使用running属性或者start()/stop()方法来明确运行状态
    //独立动画元素使用在 不是对某个单一的对象属性且需要明确控制开始和停止动画 的情况下非常有用
    PropertyAnimation {
        id: animation_ID
        target: rect3_ID                //动画应用的目标（目标对象）
        properties: "x,y"               //同时在x、y轴两个方向上运动
        duration: 5000                  //运动时间为5秒
        loops: Animation.Infinite
        easing.type: Easing.InOutBack   //运动到半程增加过冲，然后减少
    }

    MouseArea {
        anchors.fill: parent
        //鼠标点击时触发动画
        onClicked: {
            animation_ID.from = 20      //设置起点
            animation_ID.to = 200       //设置终点
            animation_ID.running = true //开启动画
        }
    }
}
