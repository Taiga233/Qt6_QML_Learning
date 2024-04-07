import QtQuick 2.15
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.15

GroupBox {
    property alias contentBG: bgRectangle_ID.color
    property alias titleColor: title_ID.color
    property alias titleFont: title_ID.font

    property real radiusVal_r: 3                        // 圆角值
    property int borderWidth_i: 1                       // 边框宽度
    property string borderColor_s: "#FFD5AF"            // 边框颜色
    property string titleColor_s: "#2359B7"             // 标题颜色
    property string titleLeftBkColor_s: "#344648"       // 标题最左侧背景色
    property string titleRightBkColor_s: "#7D8E95"      // 标题最右侧颜色
    property int titleTopPadding_i: 3                   // 标题的顶部内边距
    property string contentBkColor_s: "#77F0F6FF"       // 内容背景色
    property int titleFont_i: 16                        //标题字体大小

    id: groupBox_ID
    title: qsTr("GroupBox")

    background: Rectangle {
        id: bgRectangle_ID
        anchors.fill: groupBox_ID
        radius: radiusVal_r
        border.color: borderColor_s
        border.width: 1
        color: contentBkColor_s
        clip: true
        height: parent.height

        Item {
            x: borderWidth_i
            y: borderWidth_i
            width: parent.width - borderWidth_i * 2
            height: groupBox_ID.topPadding - groupBox_ID.bottomPadding - borderWidth_i * 2 + titleTopPadding_i * 2
            clip: true

            //设置标题的背景色
            Rectangle {
                anchors.fill: parent

                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(parent.width, 0)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: titleLeftBkColor_s
                        }
                        GradientStop {
                            position: 1.0
                            color: titleRightBkColor_s
                        }
                    }
                }
            }
        }
    }

    //设置title的属性
    label: Label {
        id: title_ID
        y:  titleTopPadding_i + 3
        x: groupBox_ID.leftPadding
        width: groupBox_ID.availableWidth
        text: groupBox_ID.title
        color: titleColor_s
        elide: Text.ElideRight
        font.family: "Microsoft Yahei"
        font.pointSize: titleFont_i
    }
}
