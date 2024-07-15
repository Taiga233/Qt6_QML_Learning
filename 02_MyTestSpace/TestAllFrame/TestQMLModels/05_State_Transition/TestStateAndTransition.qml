import QtQuick 2.15

Text {
    id: text_ID
    color: "grey"                       //初始文字显示为灰色
    font.family: "Source Code Pro"		//字体
    font.pointSize: 14                  //初始字号为12
    font.bold: true                     //加粗
    //该元素的所有状态列表
    states: [
        State {
            name: "highlight"
            when: mouseArea_ID.pressed

            PropertyChanges {
                target: text_ID
                color: "red"
                font.pointSize: 25
                //以艺术字呈现
                style: Text.Raised
                styleColor: "red"
            }
        },
        State {
            name: "rightClick"
            when: rightClickedFlag_b

            PropertyChanges {
                target: text_ID
                color: "blue"
                font.pointSize: 40
                //以艺术字呈现
                style: Text.Raised
                styleColor: "yellow"
            }
        }
    ]
    transitions: [
        Transition {
            PropertyAnimation {
                duration: 1000
            }
        }
    ]

    property bool rightClickedFlag_b: false

    MouseArea {
        id: mouseArea_ID
        anchors.fill: parent
        //The default value is Qt.LeftButton!!!
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            if (mouse.button == Qt.RightButton) {
                rightClickedFlag_b = !rightClickedFlag_b;
                console.log("rightClicked!");
            }
        }
    }
}
