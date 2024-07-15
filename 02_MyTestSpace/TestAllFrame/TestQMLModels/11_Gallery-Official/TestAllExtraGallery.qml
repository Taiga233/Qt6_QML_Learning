import QtQuick 2.2
// import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
// import QtQuick.Dialogs 1.0
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.15

import "./Viewer/"
import "./Customizer/"
import "./Style/"

Rectangle {
    id: root
    width: 480
    height: 600
    color: "#161616"
    clip: true

    function toPixels(percentage) {
        return percentage * Math.min(root.width, root.height);
    }

    property bool isScreenPortrait: height > width
    property color lightFontColor: "#222"                   //亮色模式字体统一颜色
    property color darkFontColor: "#e7e7e7"                 //暗色模式字体颜色
    readonly property color lightBackgroundColor: "#cccccc" //亮色背景颜色
    readonly property color darkBackgroundColor: "#161616"  //暗色背景颜色
    property real customizerPropertySpacing: 10             //设置中自定义控制组件的间隔
    property real colorPickerRowSpacing: 8


    //01 CircularGauge仪表盘组件，由CircularGaugeView单独管理
    property Component circularGauge: CircularGaugeView {}

    //02 DelayButton延迟按钮组件，由ControlView统一管理
    property Component delayButton: ControlView {
        darkBackground: false

        //中间延迟按钮区域组件，无自定组件区域
        control: ColumnLayout { //加个布局方便随主界面大小变化而变化
            // width: parent.width
            // height: (delayButtonColumn.height - delayButtonColumn.spacing) / 2
            // spacing: height * 0.025
            width: controlBounds.width
            height: controlBounds.height - spacing
            spacing: root.toPixels(0.05)

            DelayButton {
                id: delayButton
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "Alarm"
                //Quick Contral 1 通过这种方式更改按钮中字体的大小：
                style: DelayButtonStyle {
                    label: Text {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 20
                        font.bold: true
                        font.family: "Source Code Pro"
                        color: "blue"
                        text: delayButton.text
                    }
                }
            }
        }
    }

    //03 Dial旋钮组件，由ControlView统一管理
    property Component dial: ControlView {
        darkBackground: false

        //中间控制旋钮区域
        control: Column {
            id: dialColumn
            width: controlBounds.width
            height: controlBounds.height - spacing
            spacing: root.toPixels(0.05)

            //第一个旋钮
            ColumnLayout {
                id: volumeColumn
                width: parent.width
                height: (dialColumn.height - dialColumn.spacing) / 2
                spacing: height * 0.025

                //上面的旋钮
                Dial {
                    id: volumeDial
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    onPressedChanged: console.log("current value:" + value);

                    /*!
                        Determines whether the dial animates its rotation to the new value when
                        a single click or touch is received on the dial.
                    */
                    //当animate按钮打开时，单击Dial会使用属性动画，而按住拖拉则不会
                    property bool animate: customizerItem.animate

                    Behavior on value {
                        enabled: volumeDial.animate && !volumeDial.pressed
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutSine
                        }
                    }
                }

                //旋钮文字
                ControlLabel {
                    id: volumeText
                    text: "Volume"
                    Layout.alignment: Qt.AlignCenter
                }
            }

            //第二个旋钮
            ColumnLayout {
                id: trebleColumn
                width: parent.width
                height: (dialColumn.height - dialColumn.spacing) / 2
                spacing: height * 0.025

                Dial {
                    id: dial2
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    //设置显示外面的刻度
                    stepSize: 1
                    maximumValue: 10

                    style: DialStyle {
                        //以像素为单位的从表盘(外半径)外部到值标记文本中心的距离。
                        labelInset: outerRadius * 0
                    }
                }

                ControlLabel {
                    id: trebleText
                    text: "Treble"
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }

        //设置中的自定义控制区
        customizer: Column {
            spacing: customizerPropertySpacing

            property alias animate: animateCheckBox.checked

            CustomizerLabel {
                text: "Animate" + (animateCheckBox.checked ? " On" : " Off")
            }

            CustomizerSwitch {
                id: animateCheckBox
            }
        }
    }

    //04 Gauge刻度计组件，由ControlView统一管理
    property Component gauge: ControlView {
        //刻度计没有使用Style，所以默认暗色背景显示
        // darkBackground: false

        //中间刻度计区域
        control: Gauge {
            id: gauge
            //根据设置的方向判断长和宽
            width: orientation === Qt.Vertical ? implicitWidth : controlBounds.width
            height: orientation === Qt.Vertical ? controlBounds.height : implicitHeight
            anchors.centerIn: parent

            minimumValue: 0
            value: customizerItem.value
            maximumValue: 100
            //根据 设置中的自定义控制区中 手动设定的方向 来控制 中间刻度计区域的方向
            orientation: customizerItem.orientationFlag ? Qt.Vertical : Qt.Horizontal
            tickmarkAlignment: orientation === Qt.Vertical
                               ? (customizerItem.alignFlag ? Qt.AlignLeft : Qt.AlignRight)
                               : (customizerItem.alignFlag ? Qt.AlignTop : Qt.AlignBottom)
        }

        //设置中的自定义控制区
        customizer: Column {
            spacing: customizerPropertySpacing

            //方便ControlView的其他组件使用
            property alias value: valueSlider.value
            property alias orientationFlag: orientationCheckBox.checked
            property alias alignFlag: alignCheckBox.checked

            CustomizerLabel {
                text: "Value"
            }

            CustomizerSlider {
                id: valueSlider
                minimumValue: 0
                value: 50
                maximumValue: 100
            }

            CustomizerLabel {
                text: "Vertical orientation"
            }

            CustomizerSwitch {
                id: orientationCheckBox
                checked: true
            }

            CustomizerLabel {
                text: controlItem.orientation === Qt.Vertical ? "Left align" : "Top align"
            }

            CustomizerSwitch {
                id: alignCheckBox
                checked: true
            }
        }
    }

    //05 PieMenu圆盘形菜单组件，由PieMenuControlView单独管理
    property Component pieMenu: PieMenuControlView {}

    //06 StatusIndicator状态指示灯组件，由ControlView统一管理
    property Component statusIndicator: ControlView {
        id: statusIndicatorView
        darkBackground: false

        //中间指示灯区域组件，无自定组件区域
        control: ColumnLayout { //使得两个状态指示灯能随主窗口拉伸而拉伸
            id: indicatorLayout
            width: statusIndicatorView.controlBounds.width * 0.25
            height: statusIndicatorView.controlBounds.height * 0.75
            anchors.centerIn: parent

            //闪烁间隔时间
            Timer {
                id: recordingFlashTimer
                running: true
                repeat: true
                interval: 1000
            }

            Repeater {
                model: ListModel {
                    id: indicatorModel
                    ListElement {
                        name: "Power"
                        indicatorColor: "#35e02f"
                    }
                    ListElement {
                        name: "Recording"
                        indicatorColor: "red"
                    }
                }

                ColumnLayout {
                    //设置单个指示灯宽度，可随拉伸而拉伸
                    Layout.preferredWidth: indicatorLayout.width
                    spacing: 0

                    StatusIndicator {
                        id: indicator
                        color: indicatorColor
                        Layout.preferredWidth: statusIndicatorView.controlBounds.width * 0.07
                        Layout.preferredHeight: Layout.preferredWidth
                        Layout.alignment: Qt.AlignHCenter
                        on: true

                        //当定时器出发时改变状态
                        Connections {
                            target: recordingFlashTimer
                            function onTriggered() {
                                if (name == "Recording")
                                    indicator.active = !indicator.active
                            }
                        }
                    }
                    ControlLabel {
                        id: indicatorLabel
                        text: name
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: parent.width
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }

    //07 ToggleButton状态按钮组件，由ControlView统一管理
    property Component toggleButton: ControlView {
        id: toggleButtonView
        darkBackground: false

        //中间控制区域，无自定组件区域
        control: ColumnLayout {
            id: toggleButtonLayout
            width: controlBounds.width
            height: controlBounds.height - spacing
            spacing: root.toPixels(0.05)

            ToggleButton {
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: checked ? "On" : "Off"
            }
        }
    }

    //08 Tumbler滚动选择器组件，由ControlView统一管理
    property Component tumbler: ControlView {
        id: tumblerView
        darkBackground: false

        //中间控制区域，无自定组件区域
        control: Tumbler { //注意，这里是Extra1.4的Tumbler，不是QuickControls2的Tumbler
            id: tumbler
            anchors.centerIn: parent

            // TODO: Use FontMetrics with 5.4
            //需要有这个字符度规（衡量标准）不然会ReferenceError: characterMetrics is not defined
            Label {
                id: characterMetrics
                font.bold: true
                font.pixelSize: textSingleton.font.pixelSize * 1.25
                font.family: openSans.name
                visible: false
                text: "D"
            }

            readonly property real delegateTextMargins: characterMetrics.width * 1.5
            readonly property var days: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            //日期的滚筒选择器
            TumblerColumn {
                id: tumblerDayColumn
                // model: ListModel {}

                function updateModel() {
                    console.log("tumblerDayColumn-->updateModel()");
                    var previousIndex = tumblerDayColumn.currentIndex;
                    var newDays = tumbler.days[monthColumn.currentIndex];

                    //模型不存在则增加
                    if (!model) {
                        var array = [];
                        for (var i = 0; i < newDays; ++i) {
                            array.push(i + 1);
                        }
                        model = array;
                    } else {
                        // If we've already got days in the model, just add or remove
                        // the minimum amount necessary to make spinning the month column fast.
                        var difference = model.length - newDays;
                        if (model.length > newDays) {
                            //有bug，删除数组这里的初始坐标应该加上difference，原例子没加
                            console.log("diff:" + difference);
                            var deleteArr = model.splice(model.length - difference, difference);
                            console.log("deleteArr：" + deleteArr + " new:" + model);
                        } else {
                            var lastDay = model[model.length - 1];
                            //这里difference是负的，所以是减difference，原例子是+，有bug
                            for (i = lastDay; i < lastDay - difference; ++i) {
                                model.push(i + 1);
                            }
                        }
                        //同步一下
                        tumblerDayColumn.model = model;
                    }
                    //月份改变时，如果之前的日期比当前月份大，则设为当前月份的最后一天
                    //curentIndex是只读属性
                    // tumblerDayColumn.currentIndex = Math.min(newDays - 1, previousIndex);
                    tumbler.setCurrentIndexAt(0, Math.min(newDays - 1, previousIndex));
                }
            }
            //月份的滚筒选择器
            TumblerColumn {
                id: monthColumn
                width: characterMetrics.width * 3 + tumbler.delegateTextMargins
                model: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                //月份的值改变时，更新日期滚筒选择器
                onCurrentIndexChanged: {
                    console.log("monthTumblerColumn: onCurrentIndexChanged(): currentIndex:" + currentIndex + " role:" + role + " value:" + model[currentIndex]);
                    tumblerDayColumn.updateModel();
                }
            }
            //年份的滚筒选择器
            TumblerColumn {
                width: characterMetrics.width * 4 + tumbler.delegateTextMargins
                model: ListModel {
                    //等ListModel创建出来再添加
                    Component.onCompleted: {
                        for (var i = 2000; i < 2100; ++i) {
                            append({value: i.toString()});
                        }
                    }
                }
            }
        }
    }

    //组件集合
    property var componentMap: {
        "CircularGauge": circularGauge,
        "DelayButton": delayButton,
        "Dial": dial,
        "Gauge": gauge,
        "PieMenu": pieMenu,
        "StatusIndicator": statusIndicator,
        "ToggleButton": toggleButton,
        "Tumbler": tumbler
    }


    Text {
        id: textSingleton
    }

    //字体加载器
    FontLoader {
        id: openSans
        source: "qrc:/Others/Used_Others/01_11used_OpenSans-Regular.ttf"
    }

    //所有组件列表
    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: ListView {
            model: ListModel {
                ListElement {
                    title: "CircularGauge"
                }
                ListElement {
                    title: "DelayButton"
                }
                ListElement {
                    title: "Dial"
                }
                ListElement {
                    title: "Gauge"
                }
                ListElement {
                    title: "PieMenu"
                }
                ListElement {
                    title: "StatusIndicator"
                }
                ListElement {
                    title: "ToggleButton"
                }
                ListElement {
                    title: "Tumbler"
                }
            }

            delegate: Button {
                width: stackView.width
                height: root.height * 0.125
                text: title

                style: BlackButtonStyle {
                    fontColor: root.darkFontColor
                    rightAlignedIconSource: "qrc:/Icons/Used_Images/Icons/09_11used_PieMenuControlView_go.png"
                }

                onClicked: {
                    if (stackView.depth == 1) {
                        // Only push the control view if we haven't already pushed it...
                        stackView.push({item: componentMap[title]});
                        stackView.currentItem.forceActiveFocus();
                    }
                }
            }
        }
    }
}
