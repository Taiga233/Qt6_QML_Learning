import QtQuick 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

import "qrc:/CustomQmlModels/TestQMLModels/01_CustomJumpList/"
import "qrc:/CustomQmlModels/TestQMLModels/02_ReactanglePropertyAlias/"
import "qrc:/CustomQmlModels/TestQMLModels/03_PropertyAnimation/"
import "qrc:/CustomQmlModels/TestQMLModels/04_Animator/"
import "qrc:/CustomQmlModels/TestQMLModels/05_State_Transition/"
import "qrc:/CustomQmlModels/TestQMLModels/06_ComplexAnimation/"
import "qrc:/CustomQmlModels/TestQMLModels/07_3D_Rotation/"
import "qrc:/CustomQmlModels/TestQMLModels/08_GraphEffects/"
import "qrc:/CustomQmlModels/TestQMLModels/09_CicularGauge/"
import "qrc:/CustomQmlModels/TestQMLModels/10_Dashboard-Official/"
import "qrc:/CustomQmlModels/TestQMLModels/11_Gallery-Official/"

import "./TestQMLModels/12_Controls1Calendar-Official/"
import "./TestQMLModels/13_Controls1CustomFileSystemBrowser-Official/"
import "./TestQMLModels/14_Controls1VariousPlatformGallery-Official"

Item {
    MouseArea {
        id: mouseArea_ID
        anchors.fill: parent
    }

    /*
    //01 测试windows平台的任务栏右键快捷跳转列表
    TestCustomJumpList {
        id: customJumpList_ID
        Component.onCompleted: {
            console.log("custom items:" + customJumpList_ID.categories.length);
            console.log("recent items:" + customJumpList_ID.recent.items);
            console.log("frequent items:" +customJumpList_ID.frequent.items);
        }
    }
    */

    /*
    //02 测试矩形中的alias属性是否在其他组件中可用
    TestRectanglePropertyAlias {
        id: xxx
        anchors.fill: parent
        rectMouseArea.onClicked: {
            //控制矩形对象的可见性
            rectTopRectangle.visible = !rectTopRectangle.visible
        }
    }
    */

    /*
    //03 测试属性动画特效
    TestPropertyAnimationForm {
        anchors.fill: parent
        mouseArea_alias.onClicked: {
            //将鼠标单击的位置设置为矩形4的新坐标
            rect4_alias.x = mouseArea_alias.mouseX
            rect4_alias.y = mouseArea_alias.mouseY
        }
    }
    */

    /*
    //03 测试其他动画特效
    Column {
        spacing: 10
        Repeater {
            model: 3
            TestOtherAnimationForm {
                width: root.width
            }
        }
    }
    */

    /*
    //04 测试Animator
    TestAnimatorForm {}
    */

    /*
    //05 测试继承自Item元素的状态和切换
    Column {
        anchors.fill: parent
        spacing: 10

        TestStateAndTransition {text: "test State and Transition"}
        TestStateAndTransition {text: "Hello QML"}
    }
    */

    /*
    //06 测试组合复杂动画
    // TestParallelSequentialAnimation {}
    //网红的白天黑夜切换开关
    Rectangle {
        color: "#abcce1"
        anchors.fill: parent
        Column {
            anchors.centerIn: parent

            SwitchDayAndNight {
                switchWidth_i: 200 //根据宽度自动设定开关样式
                animationDuration_i: 500
            }
            SwitchDayAndNight {
                switchWidth_i: 600 //根据宽度自动设定开关样式
                animationDuration_i: 1000
            }
            SwitchDayAndNight {
                switchWidth_i: 800 //根据宽度自动设定开关样式
                animationDuration_i: 2000
            }
        }
    }
    */

    /*
    //07 测试图像的3D旋转效果
    TestGraph3DRotation {anchors.centerIn: parent}
    */

    /*
    //08 测试图形特效GraphEffects
    TestGraphEffects {anchors.centerIn: parent}
    */

    /*
    //09 测试Quick.Extras 1.4 圆形仪表盘控件
    Row {
        anchors.centerIn: parent
        spacing: 10

        TestCircularGauge { width: 400; height: 400;}
        TestCircularGauge { width: 400; height: 400; style: CircularGaugeStyle {} }
    }
    */

    /* 测试 Quick.Extras 1.4 官方的例子
    //10 测试dashboard汽车仪表盘例子
    TestExtrasDashboard { anchors.centerIn: parent }
    //11 测试gallery各种控件的交互式展示
    TestAllExtraGallery { anchors.centerIn: parent }
    */

    // 测试Quick Controls 1 官方的例子
    //12 Calendar日历数据库备忘录
    // TestQC1Calendar { anchors.centerIn: parent }
    //13 CustomFileSystemBrowser 自定义的文件系统查看器，继承自QFileSystemModel
    // TestCustomFileSystemBrowser { anchors.centerIn: parent; anchors.fill: parent }
    //14 VariousPlatformGallery ios/android/osx不同平台的各种控件（OpenGL版本大于3.2）
    VariousPlatformGallery { Component.onCompleted: show() }
}
