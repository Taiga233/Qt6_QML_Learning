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

import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Particles 2.0

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Styles Example")

    property int columnFactor: 5

    GridLayout {
        rowSpacing: 12
        columnSpacing: 30
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 30

        //默认样式
        Button {
            text: "Button"
            implicitWidth: window.width / columnFactor
        }

        //图片边界样式
        Button {
            id: btn_ID
            text: "Button"
            style: ButtonStyle {
                background: BorderImage {
                    //BorderImage类型用于通过缩放或平铺每个图像的部分来从图像中创建边界
                    //这里的control是ButtonStyle中的属性，就是btn_ID本身。
                    source: control.pressed ? "images/button-pressed.png" : "images/button.png"
                    border.left: 4 ; border.right: 4 ; border.top: 4 ; border.bottom: 4
                }
            }
            implicitWidth: window.width / columnFactor
        }

        //自定义样式组件
        Button {
            text: "Button"
            style: buttonStyle
            implicitWidth: window.width / columnFactor
        }

        TextField {
            Layout.row: 1 //指定为第二行，后面的组件都从第二行开始
            implicitWidth: window.width / columnFactor
        }

        TextField {
            style: TextFieldStyle {
                background: BorderImage {
                    source: "images/textfield.png"
                    border.left: 4 ; border.right: 4 ; border.top: 4 ; border.bottom: 4
                }
            }
            implicitWidth: window.width / columnFactor
        }

        TextField {
            style: textFieldStyle
            implicitWidth: window.width / columnFactor
        }

        Slider {
            id: slider1
            Layout.row: 2
            value: 0.5
            implicitWidth: window.width / columnFactor
        }

        Slider {
            id: slider2
            value: 0.5
            implicitWidth: window.width / columnFactor
            style: SliderStyle {
                groove: BorderImage {
                    height: 6
                    border.top: 1
                    border.bottom: 1
                    source: "images/progress-background.png"
                    border.left: 6
                    border.right: 6
                    BorderImage {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/progress-fill.png"
                        border.left: 5 ; border.top: 1
                        border.right: 5 ; border.bottom: 1
                        width: styleData.handlePosition
                        height: parent.height
                    }
                }
                handle: Item {
                    width: 13
                    height: 13
                    Image {
                        anchors.centerIn: parent
                        source: "images/slider-handle.png"
                    }
                }
            }
        }

        Slider {
            id: slider3
            value: 0.5
            implicitWidth: window.width / columnFactor
            style: sliderStyle
        }

        ProgressBar {
            Layout.row: 3
            value: slider1.value
            implicitWidth: window.width / columnFactor
        }

        ProgressBar {
            value: slider2.value
            implicitWidth: window.width / columnFactor
            style: progressBarStyle
        }

        ProgressBar {
            value: slider3.value
            implicitWidth: window.width / columnFactor
            style: progressBarStyle2
        }

        CheckBox {
            text: "CheckBox"
            Layout.row: 4
            implicitWidth: window.width / columnFactor
        }

        RadioButton {
            text: "RadioButton"
            implicitWidth: window.width / columnFactor
        }

        ComboBox {
            model: ["Paris", "Oslo", "New York"]
            implicitWidth: window.width / columnFactor
        }

        TabView {
            Layout.row: 5
            Layout.columnSpan: 3 //指定占这一行的三列
            Layout.fillWidth: true
            implicitHeight: 30
            Tab { title: "One" ; Item {} }
            Tab { title: "Two" ; Item {} }
            Tab { title: "Three" ; Item {} }
            Tab { title: "Four" ; Item {} }
        }

        TabView {
            Layout.row: 6
            Layout.columnSpan: 3
            Layout.fillWidth: true
            implicitHeight: 100
            Tab { title: "One" ; Item {}}
            Tab { title: "Two" ; Item {}}
            Tab { title: "Three" ; Item {}}
            Tab { title: "Four" ; Item {}}
            style: tabViewStyle
        }

        //test
        ProgressBar {
            Layout.row: 7
            value: slider2.value
            implicitWidth: window.width / columnFactor * 3
            implicitHeight: (window.height - parent.columnSpacing - parent.anchors.margins) / Layout.row
            Layout.columnSpan: 3
            Layout.rowSpan: 2
            Layout.fillWidth: true
            style: progressBarTestStyle
        }
    }

    // Style delegates:

    Component {
        id: buttonStyle
        ButtonStyle {
            background: Rectangle {
                implicitHeight: 22
                implicitWidth: window.width / columnFactor
                color: control.pressed ? "darkGray" : control.activeFocus ? "#cdd" : "#ccc"
                antialiasing: true
                border.color: "gray"
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    visible: !control.pressed
                    border.color: "#aaffffff"
                    radius: height/2
                }
            }
        }
    }

    Component {
        id: textFieldStyle
        TextFieldStyle {
            background: Rectangle {
                implicitWidth: window.width / columnFactor
                color: "#f0f0f0"
                antialiasing: true
                border.color: "gray"
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    border.color: "#aaffffff"
                    radius: height/2
                }
            }
        }
    }

    Component {
        id: sliderStyle
        SliderStyle {
            handle: Rectangle {
                width: 18
                height: 18
                color: control.pressed ? "darkGray" : "lightGray"
                border.color: "gray"
                antialiasing: true
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    border.color: "#eee"
                    radius: height/2
                }
            }

            groove: Rectangle {
                height: 8
                implicitWidth: window.width / columnFactor
                implicitHeight: 22

                antialiasing: true
                color: "#ccc"
                border.color: "#777"
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    border.color: "#66ffffff"
                    radius: height/2
                }
            }
        }
    }

    Component {
        id: progressBarStyle
        ProgressBarStyle {
            background: BorderImage {
                source: "images/progress-background.png"
                border.left: 2 ; border.right: 2 ; border.top: 2 ; border.bottom: 2
            }
            progress: Item {
                clip: true

                BorderImage {
                    anchors.fill: parent
                    anchors.rightMargin: (control.value < control.maximumValue) ? -4 : 0
                    source: "images/progress-fill.png"
                    border.left: 10 ; border.right: 10
                    //progress右边的边框
                    Rectangle {
                        width: 1
                        color: "#a70"
                        opacity: 0.8
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.right: parent.right
                        visible: control.value < control.maximumValue
                        anchors.rightMargin: -parent.anchors.rightMargin
                    }
                }

                //粒子特效系统
                ParticleSystem { id: bubbles; running: visible } //根据进度条显示与否绑定

                //用于使用图像可视化逻辑粒子，基本单元（粒子）为图像，此元素将逻辑粒子渲染为图像
                ImageParticle {
                    id: fireball
                    system: bubbles
                    source: "images/bubble.png"
                    // source: "qrc:///particleresources/star.png" //默认有三种基本例子
                    opacity: 0.7
                }

                //逻辑粒子发射器
                Emitter {
                    system: bubbles
                    anchors.bottom: parent.bottom
                    anchors.margins: 4
                    anchors.bottomMargin: -4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    size: 4 //粒子开始发射时的像素尺寸
                    sizeVariation: 8 //粒子的像素尺寸的变化范围
                    //发射的粒子的起始加速度
                    acceleration: PointDirection {
                        y: -6
                        xVariation: 3
                    }
                    emitRate: 6 * control.value //每秒发射的粒子数
                    lifeSpan: 3000 //每个粒子的生命周期，可设置无限：Emitter.InfiniteLife
                }
            }
        }
    }

    Component {
        id: progressBarStyle2
        ProgressBarStyle {
            background: Rectangle {
                implicitWidth: window.width / columnFactor
                implicitHeight: 24
                color: "#f0f0f0"
                border.color: "gray"
            }
            progress: Rectangle {
                color: "#ccc"
                border.color: "gray"
                Rectangle {
                    color: "transparent"
                    border.color: "#44ffffff"
                    anchors.fill: parent
                    anchors.margins: 1
                }
            }
        }
    }

    Component {
        id: tabViewStyle
        TabViewStyle {
            //各个选项卡按钮之间的重叠量
            tabOverlap: 16
            //单个选项卡按钮和下面框架之间的重叠量，向下移动4像素使得tab和frame看起来是一体的
            frameOverlap: 4
            tabsMovable: true //选项卡可以移动
            //tab页面的框架
            frame: Rectangle {
                gradient: Gradient { //渐变
                    GradientStop { color: "#e5e5e5" ; position: 0 }
                    GradientStop { color: "#e0e0e0" ; position: 1 }
                }
                border.color: "#898989"
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    border.color: "white"
                    color: "transparent"
                }
            }
            tab: Item {
                property int totalOverlap: tabOverlap * (control.count - 1)
                //通过styleData属性访问选项卡状态
                implicitWidth: Math.min((styleData.availableWidth + totalOverlap) / control.count - 4, image.sourceSize.width)
                implicitHeight: image.sourceSize.height
                BorderImage {
                    id: image
                    anchors.fill: parent
                    source: styleData.selected ? "images/tab_selected.png" : "images/tab.png"
                    border.left: 30
                    smooth: false
                    border.right: 30
                }
                Text {
                    text: styleData.title
                    anchors.centerIn: parent
                }
            }
            //定义左侧的组件，相当于向右偏移12
            leftCorner: Item { implicitWidth: 12 }
        }
    }

    Component {
        id: progressBarTestStyle
        ProgressBarStyle {
            background: BorderImage {
                source: "images/progress-background.png"
                horizontalTileMode: BorderImage.Stretch
                verticalTileMode: BorderImage.Stretch
                border.left: 2 ; border.right: 2 ; border.top: 2 ; border.bottom: 2
            }
            progress: Item {
                clip: true

                BorderImage {
                    anchors.fill: parent
                    anchors.rightMargin: (control.value < control.maximumValue) ? -4 : 0
                    source: "images/progress-fill.png"
                    horizontalTileMode: BorderImage.Stretch
                    verticalTileMode: BorderImage.Stretch
                    border.left: 10
                    border.right: 10
                    //progress右边的边框
                    Rectangle {
                        width: 1
                        color: "#a70"
                        opacity: 0.8
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.right: parent.right
                        visible: control.value < control.maximumValue
                        anchors.rightMargin: -parent.anchors.rightMargin
                    }
                }

                //粒子特效系统
                ParticleSystem { id: stars_ID; running: visible } //根据进度条显示与否绑定

                //用于使用图像可视化逻辑粒子，基本单元（粒子）为图像，此元素将逻辑粒子渲染为图像
                ImageParticle {
                    id: shining_ID
                    system: stars_ID
                    source: "qrc:///particleresources/star.png" //默认有三种基本例子
                    opacity: 0.8
                }

                //逻辑粒子发射器
                Emitter {
                    system: stars_ID
                    anchors.bottom: parent.bottom
                    anchors.margins: 4
                    anchors.bottomMargin: -4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    size: 20 //粒子开始发射时的像素尺寸
                    sizeVariation: 30 //粒子的像素尺寸的变化范围
                    //发射的粒子的起始加速度
                    acceleration: PointDirection {
                        y: -12
                        xVariation: 3
                    }
                    emitRate: 6 * control.value //每秒发射的粒子数
                    lifeSpan: 3000 //每个粒子的生命周期，可设置无限：Emitter.InfiniteLife
                }
            }
        }
    }
}
