/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import QtQuick.Controls 1.5
import "./VariousPlatformUIFiles/UI_LocalPlatform.js" as UI
import "./Page"

ApplicationWindow {
    visible: true
    title: "Qt Quick Controls Gallery"

    width: 640
    height: 480

    MessageDialog {
        id: aboutDialog
        icon: StandardIcon.Information
        title: "About"
        text: "Qt Quick Controls Gallery"
        informativeText: "This example demonstrates most of the available Qt Quick Controls."
    }

    Action {
        id: copyAction
        //Note that not all platforms support mnemonics.
        text: "&Copy" //绑定默认显示快捷键Alt+C
        shortcut: StandardKey.Copy //标准快捷键
        iconName: "edit-copy"
        //This attached property holds the item which currently has active focus or null if there is no item with active focus.
        //The Window attached property can be attached to any Item.
        //如果Windows有复制内容则使能
        enabled: (!!activeFocusItem && !!activeFocusItem["copy"])
        onTriggered: activeFocusItem.copy()
    }

    Action {
        id: cutAction
        text: "Cu&t"
        shortcut: StandardKey.Cut
        iconName: "edit-cut"
        enabled: (!!activeFocusItem && !!activeFocusItem["cut"])
        onTriggered: activeFocusItem.cut()
    }

    Action {
        id: pasteAction
        text: "&Paste"
        shortcut: StandardKey.Paste
        iconName: "edit-paste"
        enabled: (!!activeFocusItem && !!activeFocusItem["paste"])
        onTriggered: activeFocusItem.paste()
    }

    toolBar: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.margins: spacing //The default value is 5.
            Label {
                text: UI.label
            }
            Item { Layout.fillWidth: true }
            CheckBox {
                id: enabler
                text: "Enabled"
                checked: true
            }
        }
    }

    menuBar: MenuBar {
        Menu {
            title: "&File"
            MenuItem {
                text: "E&xit"
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: "Edit"
            visible: tabView.currentIndex == 2
            MenuItem { action: cutAction }
            MenuItem { action: copyAction }
            MenuItem { action: pasteAction }
        }
        Menu {
            title: "&Help"
            MenuItem {
                text: "About..."
                onTriggered: aboutDialog.open()
            }
        }
    }

    TabView {
        id: tabView

        anchors.fill: parent
        anchors.margins: UI.margin
        //表示tab的位置，在最上面还是在最下面
        tabPosition: UI.tabPosition ?? Qt.BottomEdge ?? Qt.TopEdge

        Layout.minimumWidth: 360
        Layout.minimumHeight: 360
        Layout.preferredWidth: 480
        Layout.preferredHeight: 640

        Tab {
            title: "Buttons"
            ButtonPage {
                enabled: enabler.checked
            }
        }
        Tab {
            title: "Progress"
            ProgressPage {
                enabled: enabler.checked
            }
        }
        Tab {
            title: "Input"
            InputPage {
                enabled: enabler.checked
            }
        }
    }
}
