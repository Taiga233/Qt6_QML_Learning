import QtQuick 2.15

Rectangle {
    //!!!只有根级目录的属性才能够被其它文件的组件访问
    property alias rectMouseArea: mouseArea_ID
    property alias rectTopRectangle: topRectangle_ID

    width: 360
    height: 360
    MouseArea {
        id: mouseArea_ID
        anchors.fill: parent
    }

    /* 添加定义两个Rectangle对象 */
    Rectangle {
        rotation: 45 							//旋转45°
        x: 40									//x方向的坐标
        y: 60									//y方向的坐标
        width: 100								//矩形宽度
        height: 100								//矩形高度
        color: "red"							//以纯色（红色）填充
    }
    Rectangle {
        id: topRectangle_ID						//id标识符
        opacity: 0.6    						//设置透明度为60%
        scale: 0.8 								//缩小为原尺寸的80%
        x: 135
        y: 60
        width: 100
        height: 100
        radius: 8 								//绘制圆角矩形
        gradient: Gradient {
            GradientStop { position: 0.0; color: "aqua" }
            GradientStop { position: 1.0; color: "teal" }
        }
        border { width: 3; color: "blue" }
        //为矩形添加一个3像素宽的蓝色边框
    }
}
