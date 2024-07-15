import QtQuick 2.15 //Animator至少需要Qt Quick 2.2及以上的版本支持

Item {
    height: 720
    width: 1280

    Rectangle {
        id: rect_ID
        width: 200
        height: 200
        color: "cadetblue"

        //XAnimator类型是元素在水平方向上移动的动画
        XAnimator on x {
            from: 10
            to: parent.width - rect_ID.width
            duration: 7000
            loops: Animator.Infinite
        }

        //同上，垂直方向的动画
        YAnimator on y {
            // target: rect_ID
            from: 10
            to: parent.height - rect_ID.height
            duration: 7000
            loops: Animator.Infinite
        }

        //ScaleAnimator改变一个元素的尺寸因子，产生使元素尺寸缩放的动画
        ScaleAnimator on scale {
            from: 0.2
            to: 1
            duration: 7000
            loops: Animator.Infinite
        }

        //旋转
        RotationAnimator on rotation {
            from: 0
            to: 360
            duration:7000
            loops: Animator.Infinite
        }

        //透明度
        OpacityAnimator on opacity {
            from: 0.2
            to: 1
            duration: 7000
            loops: Animator.Infinite
        }
    }
}
