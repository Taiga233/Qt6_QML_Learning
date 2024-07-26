import QtQuick 2.15
import QtQuick.Controls 1.5
import QtQml.Models 2.15

import TestClasses.QC1.OfficialExample.CustomFileSystemModel 1.0

Item {
    width: 640
    height: 480

    MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Row {
        id: row_ID
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.horizontalCenter: parent.horizontalCenter

        ExclusiveGroup {
            id: eg
        }

        Repeater {
            model: [ "None", "Single", "Extended", "Multi", "Contig."]
            Button {
                //If the model is a string list or object list, the delegate is also exposed to a read-only modelData property that holds the string or object data.
                text: modelData
                exclusiveGroup: eg
                checkable: true
                checked: index === 1
                // SelectionMode.NoSelection - Items cannot be selected.
                // SelectionMode.SingleSelection - When the user selects an item, any already-selected item becomes unselected, and the user cannot unselect the selected item. (Default)
                // SelectionMode.MultiSelection - When the user selects an item in the usual way, the selection status of that item is toggled and the other items are left alone.
                // SelectionMode.ExtendedSelection - When the user selects an item in the usual way, the selection is cleared and the new item selected. However, if the user presses the Ctrl key when clicking on an item, the clicked item gets toggled and all other items are left untouched. If the user presses the Shift key while clicking on an item, all items between the current item and the clicked item are selected or unselected, depending on the state of the clicked item. Multiple items can be selected by dragging the mouse over them.
                // SelectionMode.ContiguousSelection - When the user selects an item in the usual way, the selection is cleared and the new item selected. However, if the user presses the Shift key while clicking on an item, all items between the current item and the clicked item are selected.
                onClicked: view.selectionMode = index
            }
        }
    }

    ItemSelectionModel {
        id: sel
        model: customFSysModel
    }

    TreeView {
        id: view
        anchors.fill: parent
        anchors.margins: 2 * 12 + row_ID.height
        model: customFSysModel
        rootIndex: rootPathIndex
        selection: sel

        TableViewColumn {
            title: "Name"
            role: "fileName"
            resizable: true
        }

        TableViewColumn {
            title: "Size"
            role: "byteSize"
            resizable: true
            horizontalAlignment : Text.AlignRight
            width: 70
        }

        TableViewColumn {
            title: "Permissions"
            role: "customFilePermissions"
            resizable: true
            width: 100
        }

        TableViewColumn {
            title: "Date Modified"
            role: "lastModified"
            resizable: true
        }

        onActivated: {
            var url = customFSysModel.data(index, CustomFSysModel.UrlStringRole)
            //使用系统的文件资源管理器打开该文件的链接
            Qt.openUrlExternally(url)
        }
    }
}
