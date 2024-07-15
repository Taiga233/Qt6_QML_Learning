import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    property int switchWidth_i: 200
    property int switchState_i: 1 //night:0 day > 0
    property int animationDuration_i: 500 //动画持续的时间

    id: rootItem_ID
    width: switchWidth_i
    //某些子元素属性会依赖height
    height: ((3 - Math.sqrt(5)) / 2) * switchWidth_i // h / ((√5 - 1) / 2) + h = width
    // height: switchWidth * 0.618 / 1.618
    clip: true

    //整个开关
    Rectangle {
        //缩放因子
        property real scaleFactor: (switchWidth_i + lightRect_ID.radius) / 8

        id: switchRect_ID
        anchors.fill: parent
        color: "gray"
        radius: height / 2
        border.color: Qt.rgba(68, 74, 78, 0.08)
        border.width: (switchWidth_i / 100) > 0 ? (switchWidth_i / 100) : 1
        clip: true //设置切割范围
        //设置了radius、border后clip的边界问题:
        //但是设置了这个又会导致中间出现一条横线，以及该开关的内外阴影出现问题
        //需要自己去写着色器，这里没写
        layer.enabled: true
        layer.effect: OpacityMask {
                maskSource: Rectangle {
                width: switchRect_ID.width
                height: switchRect_ID.height
                radius: switchRect_ID.radius
                border.width: switchRect_ID.border.width
                border.color: switchRect_ID.border.color
            }
        }
        //白天黑夜两种状态，可以继续增加状态
        states: [
            State {
                name: "nightState"
                when: (0 === switchState_i)

                PropertyChanges {
                    target: switchRect_ID
                    color: "#1f2233"
                }
            },
            State {
                name: "dayState"
                when: (1 === switchState_i)

                PropertyChanges {
                    target: switchRect_ID
                    color: "#3885b7"
                }
            }
        ]
        transitions: [
            Transition {
                ColorAnimation {
                    duration: animationDuration_i
                }
            }
        ]

        //宇航员
        Text {
            id: astronaut_ID
            text: "宇\n航\n员"
            font.family: "黑体"
            font.pointSize: switchWidth_i / 20
            color: "mintcream"
            x: -astronaut_ID.width
            y: rootItem_ID.height + astronaut_ID.height
            z: 102
        }

        //飞机
        Text {
            id: plane_ID
            text: "飞机"
            font.family: "黑体"
            font.pointSize: switchWidth_i / 16
            rotation: 20
            color: "mediumseagreen"
            x: switchWidth_i / 3 * 2
            y: rootItem_ID.height + plane_ID.height
            z: 102
        }

        //晚上的背景星星
        Item {
            id: starsItem_ID
            x: 0
            y: -switchRect_ID.height
            z: 100
            width: switchRect_ID.width
            height: switchRect_ID.height

            Rectangle {
                id: star1_ID
                x: switchRect_ID.scaleFactor * 1.13
                y: switchRect_ID.scaleFactor * 0.27
                width: switchRect_ID.scaleFactor * 0.82
                height: star1_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star1_ID.width / 2
                    y: -star1_ID.height / 2
                    width: star1_ID.width
                    height: star1_ID.height
                    radius: star1_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star1_ID.width / 2
                    y: -star1_ID.height / 2
                    width: star1_ID.width
                    height: star1_ID.height
                    radius: star1_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star1_ID.width / 2
                    y: star1_ID.height / 2
                    width: star1_ID.width
                    height: star1_ID.height
                    radius: star1_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star1_ID.width / 2
                    y: star1_ID.height / 2
                    width: star1_ID.width
                    height: star1_ID.height
                    radius: star1_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star2_ID
                x: switchRect_ID.scaleFactor * 0.61
                y: switchRect_ID.scaleFactor * 0.73
                width: switchRect_ID.scaleFactor * 0.30
                height: star2_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star2_ID.width / 2
                    y: -star2_ID.height / 2
                    width: star2_ID.width
                    height: star2_ID.height
                    radius: star2_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star2_ID.width / 2
                    y: -star2_ID.height / 2
                    width: star2_ID.width
                    height: star2_ID.height
                    radius: star2_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star2_ID.width / 2
                    y: star2_ID.height / 2
                    width: star2_ID.width
                    height: star2_ID.height
                    radius: star2_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star2_ID.width / 2
                    y: star2_ID.height / 2
                    width: star2_ID.width
                    height: star2_ID.height
                    radius: star2_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star3_ID
                x: switchRect_ID.scaleFactor * 0.50
                y: switchRect_ID.scaleFactor * 2.02
                width: switchRect_ID.scaleFactor * 0.20
                height: star3_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star3_ID.width / 2
                    y: -star3_ID.height / 2
                    width: star3_ID.width
                    height: star3_ID.height
                    radius: star3_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star3_ID.width / 2
                    y: -star3_ID.height / 2
                    width: star3_ID.width
                    height: star3_ID.height
                    radius: star3_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star3_ID.width / 2
                    y: star3_ID.height / 2
                    width: star3_ID.width
                    height: star3_ID.height
                    radius: star3_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star3_ID.width / 2
                    y: star3_ID.height / 2
                    width: star3_ID.width
                    height: star3_ID.height
                    radius: star3_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star4_ID
                x: switchRect_ID.scaleFactor * 0.87
                y: switchRect_ID.scaleFactor * 1.87
                width: switchRect_ID.scaleFactor * 0.46
                height: star4_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star4_ID.width / 2
                    y: -star4_ID.height / 2
                    width: star4_ID.width
                    height: star4_ID.height
                    radius: star4_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star4_ID.width / 2
                    y: -star4_ID.height / 2
                    width: star4_ID.width
                    height: star4_ID.height
                    radius: star4_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star4_ID.width / 2
                    y: star4_ID.height / 2
                    width: star4_ID.width
                    height: star4_ID.height
                    radius: star4_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star4_ID.width / 2
                    y: star4_ID.height / 2
                    width: star4_ID.width
                    height: star4_ID.height
                    radius: star4_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star5_ID
                x: switchRect_ID.scaleFactor * 2.03
                y: switchRect_ID.scaleFactor * 2.00
                width: switchRect_ID.scaleFactor * 0.36
                height: star5_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star5_ID.width / 2
                    y: -star5_ID.height / 2
                    width: star5_ID.width
                    height: star5_ID.height
                    radius: star5_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star5_ID.width / 2
                    y: -star5_ID.height / 2
                    width: star5_ID.width
                    height: star5_ID.height
                    radius: star5_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star5_ID.width / 2
                    y: star5_ID.height / 2
                    width: star5_ID.width
                    height: star5_ID.height
                    radius: star5_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star5_ID.width / 2
                    y: star5_ID.height / 2
                    width: star5_ID.width
                    height: star5_ID.height
                    radius: star5_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star6_ID
                x: switchRect_ID.scaleFactor * 2.23
                y: switchRect_ID.scaleFactor * 1.00
                width: switchRect_ID.scaleFactor * 0.26
                height: star6_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star6_ID.width / 2
                    y: -star6_ID.height / 2
                    width: star6_ID.width
                    height: star6_ID.height
                    radius: star6_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star6_ID.width / 2
                    y: -star6_ID.height / 2
                    width: star6_ID.width
                    height: star6_ID.height
                    radius: star6_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star6_ID.width / 2
                    y: star6_ID.height / 2
                    width: star6_ID.width
                    height: star6_ID.height
                    radius: star6_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star6_ID.width / 2
                    y: star6_ID.height / 2
                    width: star6_ID.width
                    height: star6_ID.height
                    radius: star6_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star7_ID
                x: switchRect_ID.scaleFactor * 2.86
                y: switchRect_ID.scaleFactor * 1.80
                width: switchRect_ID.scaleFactor * 0.16
                height: star7_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star7_ID.width / 2
                    y: -star7_ID.height / 2
                    width: star7_ID.width
                    height: star7_ID.height
                    radius: star7_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star7_ID.width / 2
                    y: -star7_ID.height / 2
                    width: star7_ID.width
                    height: star7_ID.height
                    radius: star7_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star7_ID.width / 2
                    y: star7_ID.height / 2
                    width: star7_ID.width
                    height: star7_ID.height
                    radius: star7_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star7_ID.width / 2
                    y: star7_ID.height / 2
                    width: star7_ID.width
                    height: star7_ID.height
                    radius: star7_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star8_ID
                x: switchRect_ID.scaleFactor * 3.23
                y: switchRect_ID.scaleFactor * 1.50
                width: switchRect_ID.scaleFactor * 0.12
                height: star8_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star8_ID.width / 2
                    y: -star8_ID.height / 2
                    width: star8_ID.width
                    height: star8_ID.height
                    radius: star8_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star8_ID.width / 2
                    y: -star8_ID.height / 2
                    width: star8_ID.width
                    height: star8_ID.height
                    radius: star8_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star8_ID.width / 2
                    y: star8_ID.height / 2
                    width: star8_ID.width
                    height: star8_ID.height
                    radius: star8_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star8_ID.width / 2
                    y: star8_ID.height / 2
                    width: star8_ID.width
                    height: star8_ID.height
                    radius: star8_ID.width / 2
                    color: switchRect_ID.color
                }
            }

            Rectangle {
                id: star9_ID
                x: switchRect_ID.scaleFactor * 3.37
                y: switchRect_ID.scaleFactor * 0.61
                width: switchRect_ID.scaleFactor * 0.98
                height: star9_ID.width
                clip: true
                color: "white"
                Rectangle {
                    x: -star9_ID.width / 2
                    y: -star9_ID.height / 2
                    width: star9_ID.width
                    height: star9_ID.height
                    radius: star9_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star9_ID.width / 2
                    y: -star9_ID.height / 2
                    width: star9_ID.width
                    height: star9_ID.height
                    radius: star9_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: -star9_ID.width / 2
                    y: star9_ID.height / 2
                    width: star9_ID.width
                    height: star9_ID.height
                    radius: star9_ID.width / 2
                    color: switchRect_ID.color
                }
                Rectangle {
                    x: star9_ID.width / 2
                    y: star9_ID.height / 2
                    width: star9_ID.width
                    height: star9_ID.height
                    radius: star9_ID.width / 2
                    color: switchRect_ID.color
                }
            }
        }

        //远处的云层
        Item {
            id: distantCloudsItem_ID
            property real fixY: switchRect_ID.scaleFactor * (0.2 + 0.7)
            width: switchRect_ID.scaleFactor * 8
            height: switchRect_ID.scaleFactor * (4.2 + 0.7)
            clip: true
            x: 0
            y: -(switchRect_ID.scaleFactor * 0.7)
            z: 100

            Rectangle {
                id: distantCloud1_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 2.38
                height: distantCloud1_ID.width
                radius: distantCloud1_ID.width / 2
                x: distantCloudsItem_ID.width - distantCloud1_ID.width
                y: -(switchRect_ID.scaleFactor * 0.7) + distantCloudsItem_ID.fixY
            }
            Rectangle {
                id: distantCloud2_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 2.04
                height: distantCloud2_ID.width
                radius: distantCloud2_ID.width / 2
                x: switchRect_ID.scaleFactor * 4.54
                y: switchRect_ID.scaleFactor * 0.54 + distantCloudsItem_ID.fixY
            }
            Rectangle {
                id: distantCloud3_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 2.20
                height: distantCloud3_ID.width
                radius: distantCloud3_ID.width / 2
                x: switchRect_ID.scaleFactor * 3.76
                y: switchRect_ID.scaleFactor * 0.73 + distantCloudsItem_ID.fixY
            }
            Rectangle {
                id: distantCloud4_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 1.40
                height: distantCloud4_ID.width
                radius: distantCloud4_ID.width / 2
                x: switchRect_ID.scaleFactor * 3.22
                y: switchRect_ID.scaleFactor * 1.25 + distantCloudsItem_ID.fixY
            }
            Rectangle {
                id: distantCloud5_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 2.01
                height: distantCloud5_ID.width
                radius: distantCloud5_ID.width / 2
                x: switchRect_ID.scaleFactor * 2.12
                y: switchRect_ID.scaleFactor * 1.15 + distantCloudsItem_ID.fixY
            }
            Rectangle {
                id: distantCloud6_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 1.75
                height: distantCloud6_ID.width
                radius: distantCloud6_ID.width / 2
                x: switchRect_ID.scaleFactor * 1.11
                y: switchRect_ID.scaleFactor * 1.54 + distantCloudsItem_ID.fixY
            }
            Rectangle {
                id: distantCloud7_ID
                color: "#9cc2db"
                width: switchRect_ID.scaleFactor * 1.67
                height: distantCloud7_ID.width
                radius: distantCloud7_ID.width / 2
                x: switchRect_ID.scaleFactor * 0.23
                y: switchRect_ID.scaleFactor * 1.70 + distantCloudsItem_ID.fixY
            }
        }

        //光源背景光晕
        Item {
            id: lightBackgroundItem_ID
            anchors.centerIn: lightRect_ID
            z: 101

            Rectangle {
                id: haloRect3_ID
                anchors.centerIn: parent
                color: "#abcce1"
                opacity: 0.15
                width: lightRect_ID.width * 4.5
                height: haloRect3_ID.width
                radius: haloRect3_ID.width / 2
            }
            Rectangle {
                id: haloRect2_ID
                anchors.centerIn: parent
                // color: "#abcce1"
                color: Qt.rgba(171, 204, 225, 0.3)
                // opacity: 0.25
                width: lightRect_ID.width * 3.5
                height: haloRect2_ID.width
                radius: haloRect2_ID.width / 2
            }
            Rectangle {
                id: haloRect1_ID
                anchors.centerIn: parent
                color: "#abcce1"
                opacity: 0.35
                width: lightRect_ID.width * 2.5
                height: haloRect1_ID.width
                radius: haloRect1_ID.width / 2
            }
        }

        //云朵
        Item {
            id: cloudsItem_ID
            width: switchRect_ID.scaleFactor * 8
            height: switchRect_ID.scaleFactor * 4.2
            clip: true
            x: 0
            y: switchRect_ID.scaleFactor * 0.2
            z: 102

            Rectangle {
                id: cloud1_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 2.04
                height: cloud1_ID.width
                radius: cloud1_ID.width / 2
                x: cloudsItem_ID.width - cloud1_ID.width - cloud1_ID.width * 0.1
                y: 0
            }
            Rectangle {
                id: cloud2_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 2.67
                height: cloud2_ID.width
                radius: cloud2_ID.width / 2
                x: cloudsItem_ID.width - cloud2_ID.width
                y: switchRect_ID.scaleFactor * 0.7
            }
            Rectangle {
                id: cloud3_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 2.12
                height: cloud3_ID.width
                radius: cloud3_ID.width / 2
                x: switchRect_ID.scaleFactor * 4.0
                y: switchRect_ID.scaleFactor * 1.6
            }
            Rectangle {
                id: cloud4_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 2.02
                height: cloud4_ID.width
                radius: cloud4_ID.width / 2
                x: switchRect_ID.scaleFactor * 3.13
                y: switchRect_ID.scaleFactor * 1.9
            }
            Rectangle {
                id: cloud5_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 2.06
                height: cloud5_ID.width
                radius: cloud5_ID.width / 2
                x: switchRect_ID.scaleFactor * 2.11
                y: switchRect_ID.scaleFactor * 1.7
            }
            Rectangle {
                id: cloud6_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 1.75
                height: cloud6_ID.width
                radius: cloud6_ID.width / 2
                x: switchRect_ID.scaleFactor * 1.28
                y: switchRect_ID.scaleFactor * 1.96
            }
            Rectangle {
                id: cloud7_ID
                color: "#f1f1f1"
                width: switchRect_ID.scaleFactor * 2.04
                height: cloud6_ID.width
                radius: cloud6_ID.width / 2
                x: 0
                y: switchRect_ID.scaleFactor * 2.05
            }
        }

        //光源
        Rectangle {
            id: lightRect_ID
            property real controlFactor : 1.2 //控制光源的大小
            anchors.verticalCenter: parent.verticalCenter
            width: lightRect_ID.height
            //某些属性会依赖height
            height: (rootItem_ID.height - (rootItem_ID.height / 3 * 0.618 * 2)) * controlFactor
            color: "#f5cb32"
            x: (rootItem_ID.height / 3 * 0.618) / controlFactor
            y: lightRect_ID.x
            z: 103
            radius: lightRect_ID.height / 2
            clip: true

            //月亮
            Rectangle {
                id: moonRect_ID
                x: lightRect_ID.width + dropShadow_light_ID.radius * 2 //需要加阴影半径
                y: 0
                z: 104
                width: lightRect_ID.width
                height: moonRect_ID.width
                radius: moonRect_ID.height / 2
                color: "#b7c0c9"

                Rectangle {
                    id: craterRect1_ID
                    x: moonRect_ID.width / 2.17 * 0.36
                    y: moonRect_ID.width / 2.17 * 0.87
                    z: 105
                    width: moonRect_ID.width / 2.17 * 0.76
                    height: craterRect1_ID.width
                    radius: craterRect1_ID.width / 2
                    color: "#8d97aa"
                    layer.enabled: true
                    layer.effect: InnerShadow {
                        z: 106
                        anchors.fill: craterRect1_ID
                        source: craterRect1_ID
                        radius: craterRect1_ID.width / 10
                        samples: 32
                        color: "#797f89"
                        verticalOffset: craterRect1_ID.width / 10
                        horizontalOffset: craterRect1_ID.width / 10
                        spread: 0.01
                    }
                }
                Rectangle {
                    id: craterRect2_ID
                    x: moonRect_ID.width / 2.17 * 0.86
                    y: moonRect_ID.width / 2.17 * 0.35
                    z: 107
                    width: moonRect_ID.width / 2.17 * 0.41
                    height: craterRect2_ID.width
                    radius: craterRect2_ID.width / 2
                    color: "#8d97aa"
                    layer.enabled: true
                    layer.effect: InnerShadow {
                        z: 108
                        anchors.fill: craterRect2_ID
                        source: craterRect2_ID
                        radius: craterRect2_ID.width / 10
                        samples: 32
                        color: "#797f89"
                        verticalOffset: craterRect2_ID.width / 10
                        horizontalOffset: craterRect2_ID.width / 10
                        spread: 0.01
                    }
                }
                Rectangle {
                    id: craterRect3_ID
                    x: moonRect_ID.width / 2.17 * 1.41
                    y: moonRect_ID.width / 2.17 * 1.25
                    z: 107
                    width: moonRect_ID.width / 2.17 * 0.50
                    height: craterRect3_ID.width
                    radius: craterRect3_ID.width / 2
                    color: "#8d97aa"
                    layer.enabled: true
                    layer.effect: InnerShadow {
                        z: 108
                        anchors.fill: craterRect3_ID
                        source: craterRect3_ID
                        radius: craterRect3_ID.width / 10
                        samples: 32
                        color: "#797f89"
                        verticalOffset: craterRect3_ID.width / 10
                        horizontalOffset: craterRect3_ID.width / 10
                        spread: 0.01
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (cloudsAndSunMove_ID.running) {
                        //nothing will happend
                        // cloudsAndSunMove_ID.complete();
                    } else {
                        //这种需要自己手动控制且频率高的动画最好不要用Animator，不然会出错
                        if (planeAnimation_ID.running) {
                            planeAnimation_ID.complete();
                        }
                        if (starsShiningAnimation_ID.running) {
                            starsShiningAnimation_ID.complete();
                        }
                        if (astronautAnimation_ID.running) {
                            astronautAnimation_ID.complete();
                        }
                        switchState_i = switchState_i ^ 1; //改变状态，注意原子操作
                        cloudsAndSunMove_ID.restart();
                    }
                }
            }
        }

        //外阴影
        DropShadow {
            z: 998
            id: dropShadow_light_ID
            anchors.fill: lightRect_ID
            source: lightRect_ID
            radius: lightRect_ID.width / 4
            samples: dropShadow_light_ID.radius * 2 + 1
            color: "#5e6366"
            transparentBorder: true
            verticalOffset: lightRect_ID.width / 32
            horizontalOffset: dropShadow_light_ID.verticalOffset
            spread: 0.001
        }

        //内阴影
        InnerShadow {
            z: 999
            id: innerShadow_light_ID
            anchors.fill: lightRect_ID
            source: lightRect_ID
            radius: lightRect_ID.width / 4
            samples: 32
            color: "#fbfcfd"
            verticalOffset: lightRect_ID.width / 16
            horizontalOffset: innerShadow_light_ID.verticalOffset
            spread: 0.2
        }

        //切换动画
        ParallelAnimation {
            id: cloudsAndSunMove_ID
            alwaysRunToEnd: true
            loops: 1
            running: false

            NumberAnimation {
                target: lightRect_ID //太阳和光晕移动
                property: "x"
                to: switchWidth_i - lightRect_ID.x - lightRect_ID.width
                duration: animationDuration_i
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: moonRect_ID //月亮移动
                property: "x"
                to: lightRect_ID.width + dropShadow_light_ID.radius * 2 - moonRect_ID.x
                duration: animationDuration_i
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: distantCloudsItem_ID //远处云层下移
                property: "y"
                to: rootItem_ID.height - distantCloudsItem_ID.y
                duration: animationDuration_i
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: cloudsItem_ID //云层下移
                property: "y"
                to: rootItem_ID.height - cloudsItem_ID.y
                duration: animationDuration_i
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: starsItem_ID //星星下移
                property: "y"
                to: -starsItem_ID.y - rootItem_ID.height
                duration: animationDuration_i
                easing.type: Easing.InOutCubic
            }
        }

        //星星动画
        SequentialAnimation {
            id: starsShiningAnimation_ID
            loops: Animation.Infinite
            running: (0 === switchState_i)

            PropertyAnimation {
                target: star9_ID
                property: "scale"
                from: 0.1
                to: 1
                duration: 400
            }
            PropertyAnimation {
                target: star6_ID
                property: "scale"
                from: 0.1
                to: 1
                duration: 400
            }
            PropertyAnimation {
                target: star5_ID
                property: "scale"
                from: 0.1
                to: 1
                duration: 400
            }
            PropertyAnimation {
                target: star2_ID
                property: "scale"
                from: 0.1
                to: 1
                duration: 400
            }
            PauseAnimation {
                duration: 4000
            }
        }

        //宇航员动画
        SequentialAnimation {
            id: astronautAnimation_ID
            loops: Animation.Infinite
            running: (0 === switchState_i)

            PauseAnimation {
                duration: 2000
            }
            ParallelAnimation {
                NumberAnimation {
                    target: astronaut_ID
                    property: "x"
                    duration: animationDuration_i * 8
                    from: -astronaut_ID.width
                    to: switchWidth_i / 5 * 3
                    easing.type: Easing.OutInBack
                }
                NumberAnimation {
                    target: astronaut_ID
                    property: "y"
                    duration: animationDuration_i * 16
                    from: rootItem_ID.height + astronaut_ID.height
                    to: -astronaut_ID.height
                    easing.type: Easing.OutInBack
                }
                RotationAnimation {
                    target: astronaut_ID
                    from: 0
                    to: 360
                    duration: animationDuration_i * 16
                }
            }
            PauseAnimation {
                duration: 4000
            }
        }

        //飞机动画
        SequentialAnimation {
            id: planeAnimation_ID
            loops: Animation.Infinite
            running: (1 === switchState_i)

            PauseAnimation {
                duration: 2000
            }
            ParallelAnimation {
                //注意如果使用Animator，改变动画状态running为false后再调用complete()不生效
                NumberAnimation {
                    target: plane_ID
                    property: "x"
                    duration: animationDuration_i * 8
                    from: switchWidth_i
                    to: -plane_ID.width
                    easing.type: Easing.InOutCubic
                }
                NumberAnimation {
                    target: plane_ID
                    property: "y"
                    duration: animationDuration_i * 8
                    from: rootItem_ID.height / 3 * 2
                    to: 0
                    easing.type: Easing.InOutCubic
                }
            }
            PauseAnimation {
                duration: 3000
            }
        }
    }

    //内外阴影都会使得里面的光晕出现边界问题，需要写着色器自己实现阴影
    // DropShadow {
    //     id: dropShadow_switch_ID
    //     anchors.fill: switchRect_ID
    //     source: switchRect_ID
    //     radius: width / 40
    //     samples: dropShadow_switch_ID.radius * 2 + 1 //Ideally, this value should be twice as large as the highest required radius value plus one.
    //     color: "#fbfcfd"
    //     transparentBorder: true
    //     verticalOffset: width / 80
    //     horizontalOffset: 0
    //     spread: 0.1
    //     clip: true
    // }

    // InnerShadow {
    //     id: innerShadow_switch_ID
    //     anchors.fill: switchRect_ID
    //     source: switchRect_ID
    //     radius: width / 40
    //     samples: 32
    //     color: "#444a4e"
    //     verticalOffset: width / 80
    //     horizontalOffset: 0
    //     spread: 0.1
    //     clip: true
    // }
}
