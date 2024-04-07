import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.1     //FileDialog
import QtQuick.Layouts 1.15     //layouts
import QtGraphicalEffects 1.15  //linear gradient
import QtQuick.Controls 2.4    //scroll view

Window {
    width: 1280
    height: 720
    minimumWidth: 1280
    minimumHeight: 720
    visible: true
    title: qsTr("Picture Viewer")
    color: "#7D8E95"

    property string pictureFolderPath_s : "";
    property var imageSuffixFilters_strL : [".jpg (*.jpg)", ".png (*.png)", "All (*.png; *.jpg; *.bmp; *.gif; *.jpeg)"];
    property var pictureList_urlL : []
    property int curPicIndex_i : 0                  //current picture index
    property int scaleMax_i : 800                   //最大放大比例
    property int scaleMin_i : 10                    //最小放大比例
    property string titleColor_s : "#647295"
    property string contentColor_s : "#344648"      //显示字体的颜色
    property var ctrlSliderList_l : [
        ["缩放比例：", scaleMin_i, scaleMax_i , centerImage_ID.scale * 100 , "%"],
        ["旋转角度：", -180, 180 , centerImage_ID.rotation, "°"],
    ]

    //文件打开对话框
    FileDialog {
        id: fileDialog_ID
        title: "请选择图片"
        fileMode: FileDialog.OpenFiles          //打开多个文件
        folder: pictureFolderPath_s             //记录的文件路径
        nameFilters: imageSuffixFilters_strL    //the suffix of image file

        onAccepted: {
            pictureList_urlL = files            //files' url
            openNewImage_func(0)
        }
        onFolderChanged: pictureFolderPath_s = folder   //save the path when folder changed.
    }

    //主界面布局
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        //菜单栏
        TopMenu {
            id: topMenu_ID
            Layout.preferredWidth: parent.width
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
        }

        //内容栏
        RowLayout {
            spacing: 0
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height - topMenu_ID.height
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom

            //缩略图区域
            Rectangle {
                id: thumbnail_ID
                //当布局的首选宽度发生变化的时触发动画
                //Behavior on Layout.preferredWidth { NumberAnimation { duration: 250 } }
                Layout.preferredWidth: 160
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignLeft

                //区域加个线性渐变
                LinearGradient {
                    anchors.fill: parent
                    //source: parent //since the gradient is a child of the source, it will render itself recursively.
                    start: Qt.point(0, parent.height)
                    end: Qt.point(parent.width, 0)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#344648"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#7D8E95"
                        }
                    }
                }

                //ScrollView
                ScrollView {
                    id: thumbnailScroll_ID
                    anchors.fill: parent
                    anchors.topMargin: 10                               //set gap
                    anchors.bottomMargin: 10
                    clip: true                                          //开启超出范围自动裁剪
                    wheelEnabled: true                                  //the ScrollView handles wheel events.
                    ScrollBar.horizontal.interactive: false             //禁止鼠标点击水平滑块
                    ScrollBar.vertical.interactive: true
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff    //不显水平滚动条
                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    //这里判断是否显示垂直滚动条，大于1.0表示装得下
                    //ScrollBar.vertical.policy: ScrollBar.vertical.size >= 1.0 ? ScrollBar.AlwaysOff : ScrollBar.AlwaysOn

                    //鼠标滚轮
                    WheelHandler {
                        //鼠标滚轮事件，滚轮向上或向右滚动返回正直，向下或向左滚动返回负值
                        onWheel: updateScrollView_func(event.angleDelta.y > 0 ? curPicIndex_i - 1 : curPicIndex_i + 1)
                    }

                    /* //设置滚动策略
                    ScrollBar.horizontal: ScrollBar {
                        policy: ScrollBar.AlwaysOff //关闭水平的滚动条
                    }
                    //自定义滚动条样式
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded
                        contentItem: Rectangle {
                            implicitWidth: 8
                            implicitHeight: 100
                            radius: width / 2
                            color: "#7D7C7C"
                            visible: thumbnail_ID.width < 100 ? false : true
                        }
                    }
                    */

                    //缩略图的内容
                    Column {
                        anchors.fill: parent
                        anchors.leftMargin: 30
                        spacing: 20
                        Repeater {
                            model: pictureList_urlL.length //all pictures
                            Button {
                                implicitWidth: 85
                                implicitHeight: 85
                                onPressed: openNewImage_func(index)
                                background: Rectangle {
                                    color: "#202020"
                                    radius: 5
                                    border.color: index === curPicIndex_i ? "#2770DF" : hovered ? "#f6f4e8" : "transparent"
                                    border.width: 3
                                }
                                Image {
                                    anchors.fill: parent
                                    anchors.margins: 6
                                    antialiasing: true                  //反锯齿开启
                                    fillMode: Image.PreserveAspectFit   //图像均匀缩放且不裁剪
                                    source: pictureList_urlL[index]
                                }
                            }
                        }
                    }
                }
            }

            //中央图片区域
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                //Layout.preferredWidth: parent.width - thumbnail_ID.width - infomationOfPic_ID.width
                color: "#7D8E95"

                //图片浏览区域
                Flickable {
                    id: centerViewer_ID
                    anchors.fill: parent
                    //如果按照下面设置了，则如果图片比区域小，那么下面的鼠标事件区域则是按照flickable区域来的，则有不能在整片区域使用鼠标事件
                    contentHeight: centerImage_ID.height
                    contentWidth: centerImage_ID.width
                    //如果是下面这样的设置又会使得拖动失效，所以要在image区域设置鼠标的拖动效果
                    // contentHeight: centerImage_ID.height < centerViewer_ID.height ? centerViewer_ID.height : centerImage_ID.height;
                    // contentWidth: centerImage_ID.width < centerViewer_ID.width ? centerViewer_ID.width : centerImage_ID.width;
                    //如果图像大于区域拖动的时候会只显示该区域大小的内容，默认为false，这里让Flickable自动裁剪内容
                    clip: true

                    /* //下面这种方法也可以只显示区域大小的内容：
                    //设置content，注意这里content不能比Flickable大，不然图片会超出范围
                    contentHeight: centerImage_ID.height > centerViewer_ID.height ? centerViewer_ID.height : centerImage_ID.height;
                    contentWidth: centerImage_ID.width > centerViewer_ID.width ? centerViewer_ID.width : centerImage_ID.width;
                    clip: false
                    //如果要设置图片不移动到区域外面，则设置下面的
                    flickableDirection: Flickable.AutoFlickIfNeeded
                    boundsMovement: Flickable.StopAtBounds
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    */

                    //主图像
                    Image {
                        id: centerImage_ID
                        fillMode: Image.Pad
                        source: (typeof pictureList_urlL[curPicIndex_i] === "undefined") ? "" : pictureList_urlL[curPicIndex_i]
                        smooth: true        //表示缩放或转换时图像是抗锯齿的
                        mipmap: true        //打开图像多级渐远纹理，视觉效果好但是性能成本开销大
                        antialiasing: true  //抗锯齿
                        asynchronous: false //设置为同步加载图片
                        cache: true         //缓存图像
                        //第一次加载完图像后设置坐标
                        Component.onCompleted: {
                            x = parent.width / 2 - width / 2
                            y = parent.height / 2 - height / 2
                            console.log("picture list count:" + pictureList_urlL.length + " image x:" + x + " image y:" + y);
                            //第一次加载清空list
                            pictureList_urlL.length = 0
                        }

                        // 拖动效果，如果不在这里设置，那需要把区域设置到Rectangle
                        // MouseArea {
                        //     anchors.fill: parent
                        //     drag.target: parent
                        //     drag.axis: Drag.XAndYAxis
                        //     drag.minimumX: 20 - centerImage_ID.width
                        //     drag.maximumX: centerViewer_ID.width - 20
                        //     drag.minimumY: 20 - centerImage_ID.height
                        //     drag.maximumY: centerViewer_ID.height - 20
                        // }


                        //forTest 为该组件提供捏拉手势处理
                        /*
                        PinchArea {
                            anchors.fill: parent
                            pinch.target: parent
                            pinch.minimumRotation: -180
                            pinch.maximumRotation: 180
                            pinch.minimumScale: 0.1
                            pinch.maximumScale: 10
                            pinch.dragAxis: Pinch.XAndYAxis
                        }
                        */

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("mouse coordinate x:" + mouseX + " y:" + mouseY);
                                textCoordinate_ID.text = qsTr("x:" + mouseX.toFixed(2) + " y:" + mouseY.toFixed(2));
                                var path_t = centerImage_ID.source;
                                //这里居然要toString一下！
                                path_t = path_t.toString().replace("file:///", "");
                                var result_t = imageInfo.getPixelColor(path_t, mouseX, mouseY);
                                console.log("result:" + result_t);

                                textPixelRGB_ID.text = qsTr(result_t);
                            }
                            onWheel: {
                                if (wheel.modifiers & Qt.ControlModifier) {
                                    //Control+滑轮放大缩小图片
                                    centerImage_ID.scale += centerImage_ID.scale * wheel.angleDelta.y / 120 / 10;
                                    if (centerImage_ID.scale > scaleMax_i / 100) {
                                        centerImage_ID.scale =  scaleMax_i / 100;
                                    } else if (centerImage_ID.scale < scaleMin_i / 100) {
                                        centerImage_ID.scale =  scaleMin_i / 100;
                                    }
                                } else if (wheel.modifiers & Qt.AltModifier) {
                                    //Alt+滑轮旋转图片
                                    console.log("rotation:" + centerImage_ID.rotation + " wheel.angleDelta:" + wheel.angleDelta)
                                    //x或者y为鼠标滚动变化，一般滚动一下是+120或者-120
                                    //The x and y cordinate of this property holds the delta in horizontal and vertical orientation.
                                    centerImage_ID.rotation += wheel.angleDelta.x / 120 * 5;
                                    if (centerImage_ID.rotation > 180) {
                                        centerImage_ID.rotation =  180;
                                    } else if (centerImage_ID.rotation < -180) {
                                        centerImage_ID.rotation =  -180;
                                    }
                                    // 如果绝对值小于4°，则摆正图片
                                    if (Math.abs(centerImage_ID.rotation) < 4.0) {
                                        centerImage_ID.rotation = 0;
                                    }
                                } else {
                                    //其他
                                }
                            }
                        }
                    }
                }
            }

            //展示信息区域
            Rectangle {
                Layout.preferredWidth: parent.width / 6
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignRight
                id: infomationOfPic_ID
                //区域加个线性渐变
                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, parent.height)
                    end: Qt.point(parent.width, 0)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#344648"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#7D8E95"
                        }
                    }
                }

                MyGroupBox {
                    id: mouseClickedInfoGroup_ID
                    anchors.top: parent.top
                    title: qsTr("像素点信息")
                    width: parent.width
                    implicitHeight: 200
                    contentBG: "#7D8E95"
                    titleColor: "#b3dee5"

                    ColumnLayout {
                        spacing: 20
                        width: parent.width

                        Label {
                            color: contentColor_s
                            font.pointSize: mouseClickedInfoGroup_ID.titleFont.pointSize - 2
                            font.bold: true
                            text: qsTr("像素点x,y值：")
                        }

                        Text {
                            id: textCoordinate_ID
                            Layout.fillWidth: true
                            color: contentColor_s
                            font.pointSize: mouseClickedInfoGroup_ID.titleFont.pointSize - 2
                            font.bold: true
                            text: qsTr("x:" + "\ty:")
                            Layout.preferredWidth: parent.width - 10
                        }

                        Label {
                            color: contentColor_s
                            font.pointSize: mouseClickedInfoGroup_ID.titleFont.pointSize - 2
                            font.bold: true
                            text: qsTr("像素点R,G,B值：")
                        }

                        Text {
                            id: textPixelRGB_ID
                            Layout.fillWidth: true
                            color: contentColor_s
                            font.pointSize: mouseClickedInfoGroup_ID.titleFont.pointSize - 2
                            font.bold: true
                            text: qsTr("R:? " + "G:? " + "B:?");
                        }
                    }
                }

                MyGroupBox {
                    id: imageInfoGroup_ID
                    anchors.bottom: parent.bottom
                    title: qsTr("图片信息")
                    width: parent.width
                    implicitHeight: 300
                    contentBG: "#7D8E95"
                    titleColor: "#b3dee5"

                    ColumnLayout {
                        spacing: 20
                        width: parent.width

                        Text {
                            color: contentColor_s
                            Layout.fillWidth: true
                            font.pointSize: imageInfoGroup_ID.titleFont.pointSize - 2
                            text: qsTr("文件名: \n" + ((typeof pictureList_urlL[curPicIndex_i] === 'undefined') ? "请打开文件..." : pictureList_urlL[curPicIndex_i].substring(pictureList_urlL[curPicIndex_i].lastIndexOf('/') + 1, pictureList_urlL[curPicIndex_i].length)))
                            Layout.preferredWidth: parent.width - 10
                            // Layout.preferredHeight: 60 //自动决定
                            wrapMode: Text.Wrap
                        }

                        Text {
                            color: contentColor_s
                            Layout.fillWidth: true
                            font.pointSize: imageInfoGroup_ID.titleFont.pointSize - 2
                            text: qsTr("图片分辨率：\n" + centerImage_ID.paintedWidth + "*" + centerImage_ID.paintedHeight)
                        }

                        Text {
                            color: contentColor_s
                            Layout.fillWidth: true
                            font.pointSize: imageInfoGroup_ID.titleFont.pointSize - 2
                            text: qsTr("文件夹路径：\n" + pictureFolderPath_s.replace("file:///", ""))
                            Layout.preferredWidth: parent.width - 10
                            wrapMode: Text.Wrap
                        }
                    }
                }
            }
        }
    }



    ///////////////////functions
    //open image
    function openNewImage_func(index) {
        console.log("openNewImage_func:" + index)
        console.log("typeof urlList:" + typeof pictureList_urlL[curPicIndex_i])
        if (index < 0 || index >= pictureList_urlL.length) return false;
        curPicIndex_i = index;
        //根据图片大小确定打开位置
        if (centerImage_ID.width > centerViewer_ID.width) {
            centerImage_ID.x = 0;
        } else {
            centerImage_ID.x = centerViewer_ID.width / 2 - centerImage_ID.width / 2
        }
        if (centerImage_ID.height > centerViewer_ID.height) {
            centerImage_ID.y = 0;
        } else {
            centerImage_ID.y = centerViewer_ID.height / 2 - centerImage_ID.height / 2
        }
        centerImage_ID.scale = 1.0
        centerImage_ID.rotation = 0
        return true;
    }

    //deal with thumbnail when wheel
    function updateScrollView_func(index) {
        console.log("updateScrollView_func:" + index)
        if (index < 0 || index >= pictureList_urlL.length) return false
        console.log("size:" + thumbnailScroll_ID.ScrollBar.horizontal.size);
        openNewImage_func(index);
    }

    ///////////////////Connections
    Connections {
        target: topMenu_ID
        //action exit
        function onExitSig() {
            close();
        }
        //action open files
        function onOpenFileSig() {
            fileDialog_ID.open();
        }
        //menu's slider moving
        function onSliderMovingSig(index, value) {
            switch (index) {
                case 0 :
                    centerImage_ID.scale = value / 100; break;
                case 1 :
                    centerImage_ID.rotation = value; break;
                default:
                    console.log("index error! index:" + index)
            }
        }
        //action previous picture
        function onPrePicSig() {
            if (!openNewImage_func(curPicIndex_i - 1)) console.log("The foremost");
        }
        //action next picture
        function onNextPicSig() {
            if (!openNewImage_func(curPicIndex_i + 1)) console.log("The backmost");
        }
    }
}
