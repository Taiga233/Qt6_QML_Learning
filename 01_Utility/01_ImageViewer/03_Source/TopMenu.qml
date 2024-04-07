import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15

ColumnLayout {
    spacing: 0
    id: surface_ID
    signal openFileSig();
    signal exitSig();
    signal prePicSig();
    signal nextPicSig();
    signal sliderMovingSig(int index, real value);

    RowLayout {
        spacing: 0
        Layout.alignment: Qt.AlignTop
        Layout.preferredWidth: parent.width
        Layout.fillHeight: true
        Layout.fillWidth: true

        MenuBar {
            id: topMenuBar_ID
            font.pointSize: 14
            font.bold: true
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: 400
            Layout.fillHeight: true
            Layout.fillWidth: false

            MyMenu {
                id: fileMenu_ID
                title: qsTr("File");
                topPadding: 2
                bottomPadding: 2
                font: parent.font

                Action {
                    id: openFilesAct_ID
                    text: qsTr("Open Files >>")
                    shortcut: "Ctrl+O"
                    onTriggered: {
                        console.log("openFilesAct Triggered")
                        surface_ID.openFileSig();
                    }
                }

                MenuSeparator {
                    contentItem: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 1
                        color: "#647295"
                    }
                }

                Action {
                    id: exitAct_ID
                    text: qsTr("Exit")
                    shortcut: "Ctrl+W"
                    onTriggered: {
                        console.log("exitAct Triggered")
                        surface_ID.exitSig();
                    }
                }

                MyMenu {title: qsTr("test subMenu")}                                    //just for test
                Action {text: qsTr("test enabled"); enabled: false}                     //just for test
                Action {text: qsTr("test checkable"); checkable: true}                  //just for test
                Action {text: qsTr("test checked"); checkable: true; checked: true}     //just for test
            }

            MyMenu {
                id: imageMenu_ID
                title: qsTr("Image");
                topPadding: 2
                bottomPadding: 2
                font: parent.font

                Action {
                    id: previousPictureAct_ID
                    text: qsTr("Previous Picture");
                    shortcut: StandardKey.MoveToPreviousChar    //Left Key
                    onTriggered: {
                        console.log("previousPictureAct Triggered")
                        surface_ID.prePicSig();
                    }
                }

                Action {
                    id: nextPictureAct_ID
                    text: qsTr("Next Picture");
                    shortcut: StandardKey.MoveToNextChar        //Right Key
                    onTriggered: {
                        console.log("nextPictureAct Triggered")
                        surface_ID.nextPicSig();
                    }
                }
            }

            //---------设置样式
            delegate: MenuBarItem {
                id: myMenu_ID

                contentItem: Text {
                    text: myMenu_ID.text
                    font: myMenu_ID.font
                    opacity: enabled ? 1.0 : 0.3
                    color: myMenu_ID.highlighted ? "#b3dee5" : "#344648"
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    width: parent.width
                    height: parent.height - horizontalSplitter_ID.height
                    opacity: enabled ? 1 : 0.3
                    color: myMenu_ID.highlighted ? "#344648" : "transparent"
                    radius: 5
                }
            }

            //背景
            background: Rectangle {
                color: "#7D8E95"
            }
        }

        //两个slider
        Repeater {
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: (80 + 200 + 50) * 2
            Layout.fillHeight: true
            Layout.fillWidth: false
            model : 2

            RowLayout {
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: false
                Layout.preferredWidth: 80 + 200 + 50
                width: parent.width
                spacing: 0

                Text {
                    color: contentColor_s
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth : 80
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    text: ctrlSliderList_l[index][0]
                    // horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    font: topMenuBar_ID.font
                }

                MySlider {
                    id: ctrlSlider_ID
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth : 200
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    from: ctrlSliderList_l[index][1]
                    value: ctrlSliderList_l[index][3]
                    to: ctrlSliderList_l[index][2]
                    stepSize: 1
                    onMoved: surface_ID.sliderMovingSig(index, value);
                }

                Text {
                    color: contentColor_s
                    font: topMenuBar_ID.font
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth : 50
                    // horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: parseInt(ctrlSliderList_l[index][3].toString()) + ctrlSliderList_l[index][4]
                }
            }
        }

    }

    //分割线
    Rectangle {
        id: horizontalSplitter_ID
        color: "#344648"
        height: 2
        Layout.alignment: Qt.AlignBottom
        Layout.preferredWidth: parent.width
        Layout.fillWidth: true
    }
}
