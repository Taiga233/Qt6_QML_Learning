import QtQuick.Window 2.15
import QtQuick 2.15

import "qrc:/CustomQmlModels/"

Window {
    id: root
    visible: true;
    width: 1280
    height: 720

    ItemTestAll {
        anchors.fill: parent
    }

    Component.onCompleted: {
        console.log("Hello World!");
    }
}
