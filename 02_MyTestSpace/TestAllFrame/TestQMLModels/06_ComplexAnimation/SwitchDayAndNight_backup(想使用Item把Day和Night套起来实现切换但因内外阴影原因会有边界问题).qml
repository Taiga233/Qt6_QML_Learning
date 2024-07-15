import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: rootItem_ID
    property int switchWidth_i: 600
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
        color: "#3885b7"
        radius: height / 2
        border.color: Qt.rgba(68, 74, 78, 0.08)
        border.width: (switchWidth_i / 100) > 0 ? (switchWidth_i / 100) : 1
        clip: true //设置切割范围
        //设置了radius、border后clip的边界问题:
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
            anchors.centerIn: lightItem_ID
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
                color: "#abcce1"
                opacity: 0.3
                width: lightRect_ID.width * 3.5
                height: haloRect2_ID.width
                radius: haloRect2_ID.width / 2
            }
            Rectangle {
                id: haloRect1_ID
                anchors.centerIn: parent
                color: "#abcce1"
                opacity: 0.5
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
        Item {
            property real controlFactor : 1.2 //控制光源的大小
            id: lightItem_ID
            anchors.verticalCenter: parent.verticalCenter
            width: lightItem_ID.height
            height: (rootItem_ID.height - (rootItem_ID.height / 3 * 0.618 * 2)) * controlFactor
            x: (rootItem_ID.height / 3 * 0.618) / controlFactor
            y: lightItem_ID.y
            z: 103
            // clip: true

            Rectangle {
                id: lightRect_ID
                anchors.verticalCenter: parent.verticalCenter
                width: lightItem_ID.width
                //某些属性会依赖height
                height: lightItem_ID.height
                color: "#f5cb32"
                x: 0
                y: lightRect_ID.x
                z: 104
                radius: lightRect_ID.height / 2

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("clicked, runing state:" + cloudsAndSunMove_ID.running)
                        if (cloudsAndSunMove_ID.running) {
                            //nothing will happend
                            // cloudsAndSunMove_ID.complete();
                        } else {
                            cloudsAndSunMove_ID.restart();
                        }
                    }
                }
            }

            //外阴影
            DropShadow {
                id: dropShadow_light_ID
                anchors.fill: lightRect_ID
                source: lightRect_ID
                radius: lightRect_ID.width / 4
                samples: dropShadow_light_ID.radius * 2 + 1
                color: "#444a4e"
                transparentBorder: true
                verticalOffset: lightRect_ID.width / 32
                horizontalOffset: dropShadow_light_ID.verticalOffset
                spread: 0.001
            }

            //内阴影
            InnerShadow {
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
        }

        ParallelAnimation {
            id: cloudsAndSunMove_ID
            alwaysRunToEnd: true
            loops: 1
            running: false

            NumberAnimation {
                target: lightRect_ID //太阳移动
                property: "x"
                to: switchWidth_i - lightRect_ID.x - lightRect_ID.width
                duration: 500
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: distantCloudsItem_ID //远处云层下移
                property: "y"
                to: rootItem_ID.width - distantCloudsItem_ID.y
                duration: 500
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                target: cloudsItem_ID //云层下移
                property: "y"
                to: rootItem_ID.width - cloudsItem_ID.y
                duration: 500
                easing.type: Easing.InOutCubic
            }
        }
    }

    //内外阴影都会使得里面的光晕出现边界问题
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
