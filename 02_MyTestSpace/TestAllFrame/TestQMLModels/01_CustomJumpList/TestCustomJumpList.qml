import QtQuick 2.15
import QtWinExtras 1.15

JumpList {
    id: jumpList_ID
    recent.visible: true
    frequent.visible: true
    tasks: JumpListCategory {
        visible: true
        title: qsTr("those are task lists")
        JumpListSeparator {}
        JumpListLink {
            description: qsTr("这是一个跳转链接")
            title: qsTr("通往谷歌01")
            iconPath: ":/Icons/Used_Images/Icons/01_WinJumpList_fileIcon.png"
            executablePath: "http://google.com"
        }
        JumpListSeparator {}
        JumpListLink {
            description: qsTr("这是一个跳转链接")
            title: qsTr("通往谷歌02")
            iconPath: ":/Icons/Used_Images/Icons/01_WinJumpList_fileIcon.png"
            executablePath: "http://google.com"
        }
        JumpListSeparator {}
        //不能用下面这种格式
        //QWinJumpList: AddUserTasks() failed: 0xXXXXX
        // JumpListDestination {
        //     filePath: "qrc:/Documents/Used_Documents/testOpenFile.txt"
        // }
        JumpListDestination {
            filePath: ":/Documents/Used_Documents/testOpenFile.txt"
        }
    }
    // tasks: jumpList_ID.recent

    JumpListCategory {
        visible: true
        title: qsTr("这些是一个链接组")

        JumpListLink {
            arguments: "echo hello"
            description: qsTr("这是一个跳转链接")
            title: qsTr("通往谷歌")
            iconPath: "qrc:/Icons/Used_Images/Icons/01_WinJumpList_fileIcon.png"
            executablePath: "http://google.com"
        }
        JumpListLink {
            arguments: "echo hello"
            description: qsTr("这是一个跳转链接")
            title: qsTr("通往必应")
            iconPath: ":/Icons/Used_Images/Icons/01_WinJumpList_fileIcon.png"
            executablePath: "http://bing.com"
        }
    }

    JumpListCategory {
        visible: true
        title: qsTr("这些是查看的文件")

        //QWinJumpList: AppendCategory() failed: 0x80070057, E_INVALIDARG.
        // JumpListDestination {
        //     filePath: ":/Documents/Used_Documents/testOpenFile.txt"
        // }
        // JumpListDestination {
        //     filePath: "qrc:/Documents/Used_Documents/testOpenFile.txt"
        // }
    }
}
