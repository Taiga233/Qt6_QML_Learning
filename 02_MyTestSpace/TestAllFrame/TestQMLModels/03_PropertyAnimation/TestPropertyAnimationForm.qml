import QtQuick 2.15

import "qrc:/CustomQmlModels/TestQMLModels/03_PropertyAnimation/PropertyAnimation/"

Rectangle {
    width: 640
    height: 320

    property alias mouseArea_alias: mouseArea_ID
    property alias textEdit_alias: textEdit_ID
    property alias rect4_alias: rect4_ID

    MouseArea {
        id: mouseArea_ID
        anchors.fill: parent
    }

    TextEdit {
        id: textEdit_ID
        visible: false
    }

    Column {
        x: 0
        y: 0
        spacing: 5

        Rect1 {}
        Rect2 {}
        Rect3 {}
        Rect4 {
            id: rect4_ID
        }
    }
}
