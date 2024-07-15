import QtQuick 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

CircularGauge {
    value: accelerating ? maximumValue : 0

    property bool accelerating: false

    Keys.onSpacePressed: {
        accelerating = true //表示加速状态
    }

    Keys.onReleased: (event)=> {
        if (event.key === Qt.Key_Space) {
            accelerating = false;
            event.accepted = true; //以防止事件沿项目层次结构向上传播
        }
    }

    Component.onCompleted: forceActiveFocus()

    Behavior on value {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.Linear
        }
    }

    style: CircularGaugeStyle {
        id: style

        function degreesToRadians(degrees) {
            return degrees * (Math.PI / 180);
        }

        //自己绘制刻度样式
        background: Canvas {
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();

                ctx.beginPath();
                ctx.strokeStyle = "yellow";
                ctx.lineWidth = outerRadius * 0.02;

                ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                        degreesToRadians(valueToAngle(80) - 90), degreesToRadians(valueToAngle(100) - 90));
                ctx.stroke();
            }
        }

        //大刻度
        tickmark: Rectangle {
            visible: styleData.value < 80 || styleData.value % 10 == 0
            implicitWidth: outerRadius * 0.02
            antialiasing: true
            implicitHeight: outerRadius * 0.06
            color: styleData.value >= 80 ? "#e34c22" : "cadetblue"
        }

        //小刻度
        minorTickmark: Rectangle {
            visible: styleData.value < 80
            implicitWidth: outerRadius * 0.01
            antialiasing: true
            implicitHeight: outerRadius * 0.03
            color: "cadetblue"
        }

        //刻度下的文字
        tickmarkLabel:  Text {
            font.pixelSize: Math.max(6, outerRadius * 0.1)
            text: styleData.value
            color: styleData.value >= 80 ? "#e34c22" : "cadetblue"
            antialiasing: true
        }

        //指针
        needle: Rectangle {
            y: outerRadius * 0.15
            implicitWidth: outerRadius * 0.03
            implicitHeight: outerRadius * 0.9
            antialiasing: true
            color: "cadetblue"
        }

        //中心的圆心组件
        foreground: Item {
            Rectangle {
                width: outerRadius * 0.2
                height: width
                radius: width / 2
                color: "darkslategray"
                anchors.centerIn: parent
            }
        }
    }
}
