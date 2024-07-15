import QtQuick 2.15
import QtGraphicalEffects 1.15

Rectangle {
    width: animatedImage1_ID.width + animatedImage2_ID.width
    height: Math.max(animatedImage1_ID.height, animatedImage2_ID.height)

    Row {
        Item {
            width: animatedImage1_ID.width
            height: animatedImage1_ID.height
            AnimatedImage {
                id: animatedImage1_ID
                source: "qrc:/Pictures/Used_Images/GIF/countryside_512x512.gif"
            }
            LevelAdjust {
                id: rgbaLevelAdjust_ID
                anchors.fill: animatedImage1_ID
                source: animatedImage1_ID
            }
        }

        Item {
            width: animatedImage2_ID.width
            height: animatedImage2_ID.height
            AnimatedImage {
                id: animatedImage2_ID
                source: "qrc:/Pictures/Used_Images/GIF/countryside_512x512.gif"
            }
            BrightnessContrast {
                id: brightnessContrast_ID
                anchors.fill: animatedImage2_ID
                source: animatedImage2_ID
            }
        }
    }

    ParallelAnimation {
        id: animation_ID
        running: false
        loops: Animation.Infinite

        SequentialAnimation {
            NumberAnimation {
                target: brightnessContrast_ID
                property: "brightness"
                to: -0.5
                duration: 3000
            }
            NumberAnimation {
                target: brightnessContrast_ID
                property: "contrast"
                to: 0.25
                duration: 3000
            }
        }

        ParallelAnimation {
            PropertyAnimation {
                target: rgbaLevelAdjust_ID
                property: "minimumOutput"
                to: "#00ffffff"
                duration: 3000
            }
            PropertyAnimation {
                target: rgbaLevelAdjust_ID
                property: "maximumOutput"
                to: "#ff000000"
                duration: 3000
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            animation_ID.running = true;
        }
    }
}
