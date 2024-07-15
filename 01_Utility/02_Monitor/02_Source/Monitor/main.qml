import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore

import MyQuickUsbCamera 1.0

Window {
    width: 1080
    height: 720
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    title: qsTr("Monitor")

    property var cameraNames_strL: ["摄像头1", "摄像头2", "摄像头3", "摄像头4"]
    property var usbDevicesID_strL: []
    //当前tag在占用哪个摄像头，-1表示为没有占用，0表示占用摄像头1，1表示占用摄像头2
    property var tagUsedCamera: [-1, -1, -1, -1] //tag0, tag1, tag2, tag3
    //当前图像标志位
    property int flagWhichCapture_i: -1
    property string savePathCache_str: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
    property int captureTimes_i: 0

    ListModel {
        id: comboBoxModel
        ListElement {name: "无"}
        ListElement {name: "摄像头1"}
        ListElement {name: "摄像头2"}
        ListElement {name: "摄像头3"}
        ListElement {name: "摄像头4"}
    }

    Window {
        id: imagePreview_ID
        width: 640
        height: 480
        title: qsTr("Captrue Image Preview")
        visible: false
        color: "darkgrey"

        Column {
            anchors.fill: parent
            spacing: 0
            Button {
                id: saveBtn_ID
                text: qsTr("将图像另存为...");
                font.pointSize: 20
                width: 200
                height: 40
                onClicked: fileDialog_ID.open()
            }
            Flickable {
                width: imagePreview_ID.width
                height: imagePreview_ID.height - saveBtn_ID.height
                contentWidth: previewImage_ID.width; contentHeight: previewImage_ID.height
                clip: true
                Image {
                    id: previewImage_ID
                    fillMode: Image.Pad
                    smooth: true        //表示缩放或转换时图像是抗锯齿的
                    mipmap: true        //打开图像多级渐远纹理，视觉效果好但是性能成本开销大
                    antialiasing: true  //抗锯齿
                    asynchronous: true  //设置为同步加载图片
                    cache: false        //缓存图像
                    source: ""
                }
            }
        }

        FileDialog {
            id: fileDialog_ID
            title: qsTr("将图像文件另存为...")
            currentFolder: savePathCache_str
            fileMode: FileDialog.SaveFile //The dialog is used to select any file. The file does not have to exist.
            // currentFile: Qt.formatDateTime(new Date(),"yyyy年MM月dd日HH-mm-ss-zzz") + ".jpg"
            currentFile: "captured_" + captureTimes_i + ".jpg"
            nameFilters: ["capture (*.jpg)", "PNG (*.png)"]
            defaultSuffix: "jpg"
            onAccepted: {
                console.log("accepted currentFolder:" + currentFolder);
                console.log("accepted currentFile:" + currentFile);
                console.log("accepted selectedFile:" + selectedFile);
                savePathCache_str = currentFolder;
                switch (flagWhichCapture_i) {
                case 0:
                    capture0_ID.saveToFile(currentFile);
                    break;
                case 1:
                    capture1_ID.saveToFile(currentFile);
                    break;
                case 2:
                    capture2_ID.saveToFile(currentFile);
                    break;
                case 3:
                    capture3_ID.saveToFile(currentFile);
                    break;
                default :
                    console.log("当前捕捉源未知");
                    break;
                }
                captureTimes_i++;
            }
        }
    }

    Timer {
        id: delayTimer_ID
        repeat: false
        interval: 300
        onTriggered: {
            let second_id_t = -1;
            let tempSavedImage_str = Qt.application.arguments;

            switch (flagWhichCapture_i) {
            case 0:
                second_id_t = capture0_ID.capture();
                console.log("second preview(capture URL):" + capture0_ID.preview + "  capture id:" + second_id_t);
                capture0_ID.saveToFile("file:./temp_current.jpg");
                // console.log("arguments:" + Qt.application.arguments);
                // previewImage_ID.source = capture0_ID.preview;
                break;
            case 1:
                second_id_t = capture1_ID.capture();
                console.log("second preview(capture URL):" + capture1_ID.preview + "  capture id:" + second_id_t);
                capture1_ID.saveToFile("file:./temp_current.jpg");
                break;
            case 2:
                second_id_t = capture2_ID.capture();
                console.log("second preview(capture URL):" + capture2_ID.preview + "  capture id:" + second_id_t);
                capture2_ID.saveToFile("file:./temp_current.jpg");
                break;
            case 3:
                second_id_t = capture3_ID.capture();
                console.log("second preview(capture URL):" + capture3_ID.preview + "  capture id:" + second_id_t);
                capture3_ID.saveToFile("file:./temp_current.jpg");
                break;
            default:
                console.log("flagWhichCapture_i error:" + flagWhichCapture_i);
                imagePreview_ID.visible = false;
                imagePreview_ID.hide();
                return;
            }
            previewImage_ID.source = ""; //清空一下图片缓存
            previewImage_ID.source = "file:./temp_current.jpg";
            imagePreview_ID.visible = true;
            imagePreview_ID.show();
        }
    }

    GridLayout {
        id: gridLayout_ID
        anchors.fill: parent
        columns: 2
        flow: GridLayout.LeftToRight    //排列方向
        layoutDirection: Qt.LeftToRight //布局方向，如果设置为Qt.RightToLeft则会镜像
        columnSpacing: 4
        rowSpacing: 4

        MediaDevices {
            id: mediaDevices_ID
            onVideoInputsChanged: {
                console.log("onVideoInputsChanged");
                console.log("当前视频输入设备：" + videoInputs.length);
            }
            Component.onCompleted: {
                console.log("输入设备数量：" + videoInputs.length);
                for (let i = 0; i < videoInputs.length; i++) {
                    // console.log("\ncorrectionAngle:" + videoInputs[i].correctionAngle)
                    // console.log("description:" + videoInputs[i].description)
                    console.log("id:" + videoInputs[i].id)
                    // console.log("isDefault:" + videoInputs[i].isDefault)
                    // console.log("position:" + videoInputs[i].position)
                    // console.log("videoFormats:" + videoInputs[i].videoFormats)
                }
            }
        }

        Rectangle {
            id: rectangle0_ID
            color: "darkgrey"
            Layout.alignment: Qt.AlignCenter
            // Layout.preferredWidth: 320
            // Layout.preferredHeight: 240
            Layout.fillWidth: true
            Layout.fillHeight: true
            border.color: "burlywood"
            border.width: 1

            Column {
                width: parent.width
                height: parent.height
                spacing: 0

                Row {
                    spacing: 20
                    ComboBox {
                        id: comboBox0_ID
                        implicitWidth: 200
                        implicitHeight: 30
                        font.pointSize: 16
                        model: comboBoxModel
                        // model: {
                        //     return ["无"].concat(cameraNames_strL);
                        // }
                        onCurrentIndexChanged: selectChanged_func(0, currentIndex);
                    }
                    Button {
                        text: qsTr("截图")
                        font.pointSize: comboBox0_ID.font.pointSize
                        height: comboBox0_ID.height + 2
                        onClicked: {
                            console.log("Capture0");
                            if (camera0_ID.active && (Camera.NoError === camera0_ID.error) && capture0_ID.readyForCapture) {
                                let first_id_t = capture0_ID.capture();
                                console.log("first preview(capture URL):" + capture0_ID.preview + "  capture id:" + first_id_t);
                                flagWhichCapture_i = 0;
                                //加个延时
                                delay_func();
                            } else {
                                console.log("Camera0 capture error");
                            }
                        }
                    }
                }

                VideoOutput {
                    id: videoOutput0_ID
                    width: parent.width
                    height: parent.height - comboBox0_ID.height
                    fillMode: VideoOutput.PreserveAspectFit //视频均匀缩放以适应而不裁剪
                }
            }

            CaptureSession {
                imageCapture: ImageCapture {
                    id: capture0_ID

                    onImageCaptured: function(requestId, preview){
                        //console.log("onImageCaptured requestId:" + requestId);
                        //console.log("onImageCaptured preview:" + preview);
                        // console.log("on captured0");
                        // previewImage_ID.source = preview.xxxxx; //这里也要改资源路径！
                        // imagePreview_ID.visible = true;
                        // imagePreview_ID.show();
                    }
                }
                camera: Camera {
                    id: camera0_ID
                    cameraDevice: mediaDevices_ID.videoInputs[0]
                }
                videoOutput: videoOutput0_ID
            }
        }

        Rectangle {
            id: rectangle1_ID
            color: "darkgrey"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            border.color: "burlywood"
            border.width: 1

            Column {
                width: parent.width
                height: parent.height
                spacing: 0

                Row {
                    spacing: 20
                    ComboBox {
                        id: comboBox1_ID
                        implicitWidth: 200
                        implicitHeight: 30
                        font.pointSize: 16
                        model: comboBoxModel
                        onCurrentIndexChanged: selectChanged_func(1, currentIndex);
                    }
                    Button {
                        text: qsTr("截图")
                        font.pointSize: comboBox1_ID.font.pointSize
                        height: comboBox1_ID.height + 2
                        onClicked: {
                            console.log("Capture1");
                            if (camera1_ID.active && (Camera.NoError === camera1_ID.error) && capture1_ID.readyForCapture) {
                                let first_id_t = capture1_ID.capture();
                                console.log("first preview(capture URL):" + capture1_ID.preview + "  capture id:" + first_id_t);
                                flagWhichCapture_i = 1;
                                //加个延时
                                delay_func();
                            } else {
                                console.log("Camera1 capture error");
                            }
                        }
                    }
                }

                VideoOutput {
                    id: videoOutput1_ID
                    width: parent.width
                    height: parent.height - comboBox1_ID.height
                    fillMode: VideoOutput.PreserveAspectFit
                }
            }

            CaptureSession {
                imageCapture: ImageCapture {
                    id: capture1_ID
                }
                camera: Camera {
                    id: camera1_ID
                    cameraDevice: mediaDevices_ID.videoInputs[1]
                }
                videoOutput: videoOutput1_ID
            }
        }

        Rectangle {
            id: rectangle2_ID
            color: "darkgrey"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            border.color: "burlywood"
            border.width: 1

            Column {
                width: parent.width
                height: parent.height
                spacing: 0

                Row {
                    spacing: 20
                    ComboBox {
                        id: comboBox2_ID
                        implicitWidth: 200
                        implicitHeight: 30
                        font.pointSize: 16
                        model: comboBoxModel
                        onCurrentIndexChanged: selectChanged_func(2, currentIndex);
                    }
                    Button {
                        text: qsTr("截图")
                        font.pointSize: comboBox2_ID.font.pointSize
                        height: comboBox2_ID.height + 2
                        onClicked: {
                            console.log("Capture2");
                            if (camera2_ID.active && (Camera.NoError === camera2_ID.error) && capture2_ID.readyForCapture) {
                                let first_id_t = capture2_ID.capture();
                                console.log("first preview(capture URL):" + capture2_ID.preview + "  capture id:" + first_id_t);
                                flagWhichCapture_i = 2;
                                //加个延时
                                delay_func();
                            } else {
                                console.log("Camera2 capture error");
                            }
                        }
                    }
                }

                VideoOutput {
                    id: videoOutput2_ID
                    width: parent.width
                    height: parent.height - comboBox2_ID.height
                    fillMode: VideoOutput.PreserveAspectFit
                }
            }

            CaptureSession {
                imageCapture: ImageCapture {
                    id: capture2_ID
                }
                camera: Camera {
                    id: camera2_ID
                    cameraDevice: mediaDevices_ID.videoInputs[2]
                }
                videoOutput: videoOutput2_ID
            }
        }

        Rectangle {
            id: rectangle3_ID
            color: "darkgrey"
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            border.color: "burlywood"
            border.width: 1

            Column {
                width: parent.width
                height: parent.height
                spacing: 0

                Row {
                    spacing: 20
                    ComboBox {
                        id: comboBox3_ID
                        implicitWidth: 200
                        implicitHeight: 30
                        font.pointSize: 16
                        model: comboBoxModel
                        onCurrentIndexChanged: selectChanged_func(3, currentIndex);
                    }
                    Button {
                        text: qsTr("截图")
                        font.pointSize: comboBox3_ID.font.pointSize
                        height: comboBox3_ID.height + 2
                        onClicked: {
                            console.log("Capture3");
                            if (camera3_ID.active && (Camera.NoError === camera3_ID.error) && capture3_ID.readyForCapture) {
                                let first_id_t = capture3_ID.capture();
                                console.log("first preview(capture URL):" + capture3_ID.preview + "  capture id:" + first_id_t);
                                flagWhichCapture_i = 3;
                                //加个延时
                                delay_func();
                            } else {
                                console.log("Camera3 capture error");
                            }
                        }
                    }
                }

                VideoOutput {
                    id: videoOutput3_ID
                    width: parent.width
                    height: parent.height - comboBox3_ID.height
                    fillMode: VideoOutput.PreserveAspectFit
                }
            }

            CaptureSession {
                imageCapture: ImageCapture {
                    id: capture3_ID
                }
                camera: Camera {
                    id: camera3_ID
                    cameraDevice: mediaDevices_ID.videoInputs[3]
                }
                videoOutput: videoOutput3_ID
            }
        }
    }

    ///////////////////functions
    function selectChanged_func(tag, selectIndex) {
        console.log("tag:" + tag + " selectIndex:" + selectIndex);
        console.log("tagUsedCamera previous:" + tagUsedCamera);
        //关闭摄像头
        if (0 === selectIndex) {
            //更新combobox可选
            if (-1 !== tagUsedCamera[tag]) {
                comboBoxModel.set(tagUsedCamera[tag] + 1, {name: ("摄像头" + (tagUsedCamera[tag] + 1))});
            }
            //解除占用摄像头
            tagUsedCamera[tag] = -1;
            switch (tag) {
            case 0:
                camera0_ID.stop();
                videoOutput0_ID.visible = false;
                break;
            case 1:
                camera1_ID.stop();
                videoOutput1_ID.visible = false;
                break;
            case 2:
                camera2_ID.stop();
                videoOutput2_ID.visible = false;
                break;
            case 3:
                camera3_ID.stop();
                videoOutput3_ID.visible = false;
                break;
            }
            return;
        }

        //设置选择不同的摄像头
        switch (tag) {
        case 0:
            if (-1 === tagUsedCamera.indexOf((selectIndex - 1))) {
                camera0_ID.cameraDevice = mediaDevices_ID.videoInputs[selectIndex - 1];
                videoOutput0_ID.visible = true;
                camera0_ID.start();
                //设置占用的摄像头
                tagUsedCamera[tag] = (selectIndex - 1);
                comboBoxModel.set(selectIndex, {name: ("摄像头" + selectIndex + "已被占用")})
            } else {
                console.log("该摄像头" + selectIndex + "已经被占用");
            }
            break;
        case 1:
            if (-1 === tagUsedCamera.indexOf((selectIndex - 1))) {
                camera1_ID.cameraDevice = mediaDevices_ID.videoInputs[selectIndex - 1];
                videoOutput1_ID.visible = true;
                camera1_ID.start();
                //设置占用的摄像头
                tagUsedCamera[tag] = (selectIndex - 1);
                comboBoxModel.set(selectIndex, {name: ("摄像头" + selectIndex + "已被占用")})
            } else {
                console.log("该摄像头" + selectIndex + "已经被占用");
            }
            break;
        case 2:
            if (-1 === tagUsedCamera.indexOf((selectIndex - 1))) {
                camera2_ID.cameraDevice = mediaDevices_ID.videoInputs[selectIndex - 1];
                videoOutput2_ID.visible = true;
                camera2_ID.start();
                //设置占用的摄像头
                tagUsedCamera[tag] = (selectIndex - 1);
                comboBoxModel.set(selectIndex, {name: ("摄像头" + selectIndex + "已被占用")})
            } else {
                console.log("该摄像头" + selectIndex + "已经被占用");
            }
            break;
        case 3:
            if (-1 === tagUsedCamera.indexOf((selectIndex - 1))) {
                camera3_ID.cameraDevice = mediaDevices_ID.videoInputs[selectIndex - 1];
                videoOutput3_ID.visible = true;
                camera3_ID.start();
                //设置占用的摄像头
                tagUsedCamera[tag] = (selectIndex - 1);
                comboBoxModel.set(selectIndex, {name: ("摄像头" + selectIndex + "已被占用")})
            } else {
                console.log("该摄像头" + selectIndex + "已经被占用");
            }
            break;
        }
        console.log("tagUsedCamera after:" + tagUsedCamera);
    }

    //延时功能
    function delay_func(delayTime) {
        if (undefined !== delayTime) {
            delayTimer_ID.interval = delayTime;
        }
        delayTimer_ID.repeat = false;
        delayTimer_ID.restart();
    }


    /*
    //结合C++的方式实现
    Rectangle {
        id: usbCamera1_ID
        width: 320
        height: 240
        anchors.left: parent.left
        anchors.top: parent.top
        color: "burlywood"

        UsbCamera {
            id: camera1_ID
            videoOutput: videoOutput1_ID
        }

        VideoOutput {
            id: videoOutput1_ID
            anchors.fill: parent
        }

        Text {
            anchors.centerIn: parent
            text: "USB Camera is unavailable"
            color: "steelblue"
            font.pointSize: 32
            width: parent.width
            wrapMode: Text.WordWrap
            visible: {
                !(camera1_ID.isCameraAvailable)
            }
        }
    }
    */

    /*
    //下面是纯QML方式实现的
    Rectangle {
        id: usbCamera2_ID
        width: 320
        height: 240
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "aqua"

        MediaDevices {
            id: mediaDevices_ID
        }
        CaptureSession {
            camera: Camera {
                id: camera2_ID
                // cameraDevice: mediaDevices_ID.videoInputs[0]

                cameraDevice: {
                    if (0 !== mediaDevices_ID.videoInputs.length) {
                        for (var i = 0; i < mediaDevices_ID.videoInputs.length; i++) {
                            console.log("id:" + mediaDevices_ID.videoInputs[0].id.toString());
                            if (-1 !== mediaDevices_ID.videoInputs[i].id.toString().indexOf("usb")) {
                                console.log("find usb " + i + ", id: " + mediaDevices_ID.videoInputs[i].id.toString());
                                return mediaDevices_ID.videoInputs[i];
                            }
                        }
                    } else {
                        return mediaDevices_ID.defaultVideoInput;
                    }
                }
                onCameraDeviceChanged: {
                    console.log("camera device changed, camera2_ID.error:" + camera2_ID.error + " error Description:" + camera2_ID.errorString);
                    if (camera2_ID.error === Camera.NoError) camera2_ID.start();
                    else camera2_ID.stop();
                }
            }
            videoOutput: videoOutput2_ID
        }

        VideoOutput {
            id: videoOutput2_ID
            anchors.fill: parent
        }

        Component.onCompleted: {
            camera2_ID.start();
        }

        Text {
            anchors.centerIn: parent
            text: "USB Camera is unavailable"
            color: "steelblue"
            font.pointSize: 32
            wrapMode: Text.WordWrap
            width: parent.width
            visible: {
                camera2_ID.error === Camera.NoError ? false : true
            }
        }
    }

    ShaderEffectSource {
        id: usbCamera2_Shader1_ID
        sourceItem: usbCamera2_ID
        anchors.left: parent.left
        anchors.top: parent.top
        width: 320
        height: 240
    }

    ShaderEffectSource {
        id: usbCamera2_Shader2_ID
        sourceItem: usbCamera2_ID
        anchors.right: parent.right
        anchors.top: parent.top
        width: 320
        height: 240
    }
    */
}
