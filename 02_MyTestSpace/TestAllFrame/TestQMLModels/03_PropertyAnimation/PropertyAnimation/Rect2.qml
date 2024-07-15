import QtQuick 2.15

Rectangle {
    id: rect2_ID
    width: 80
    height: 80
    color: "lightgreen"
    radius: 10

    Text {
        anchors.centerIn: parent
        font.pointSize: 14
        text: "02信号处理"
    }

    MouseArea {
        anchors.fill: parent
        //可以在一个信号处理器中创建一个动画，并在接收到信号时触发这个动画
        //当MouseArea被单击时触发，在3000毫秒内使用动画将rect2_ID的y坐标属性由30改为300，并往复运动3次
        //因为该动画没有绑定到一个特定的对象或属性，所以必须指定target和property（properties）
        onClicked: PropertyAnimation {
            target: rect2_ID                //动画应用的目标（目标对象）
            property: "y"                   //y轴方向的动画
            from: 30                        //动画的起点
            to: 300                         //动画的终点
            duration: 3000                  //运动时间为3秒
            loops: 3                        //运动3个周期
            easing.type: Easing.Linear      //匀速线性运动
        }
    }
}
