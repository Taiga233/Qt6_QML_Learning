import QtQuick 2.15

Rectangle {
    id: rect1_ID
    width: 80
    height: 80
    color: "orange"
    radius: 10

    Text {
        anchors.centerIn: parent
        font.pointSize: 14
        text: "01属性值源"
    }

    //这里在 Rect1的x属性上 应用了PropertyAnimation，来使它从起始值50在30000毫秒中使用动画变化到500
    //Rect1一旦加载完成就会立即开启该动画
    //loops属性设定为Animation.Infinite表明该动画是无限循环的
    //这里通过使用Easing.OutBounce创建了一个动画达到目标值时的反弹效果；
    PropertyAnimation on x {
        from: 50                        //动画的起点
        to: 500                         //动画的终点
        duration: 30000                 //运动时间为30秒
        loops: Animation.Infinite       //无限循环
        easing.type: Easing.OutBounce   //反弹
    }
}
