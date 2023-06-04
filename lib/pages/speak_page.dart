import 'package:flutter/material.dart';

class SpeakPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SpeakPage();
  }
}

class _SpeakPage extends State<SpeakPage> with SingleTickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    // 初始化动画
    animationController = AnimationController(
        vsync: this,
        duration: Duration(
            // 1s
            milliseconds: 1000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画完成
        // 反向运动，从而实现循环运动
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 动画取消
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('语音搜索')),
      body: Center(
        child: GestureDetector(
          onTapDown: (e) {
            // 开始动画
            animationController.forward();
          },
          onTapUp: (e) {
            // 结束动画
            animationController.reset();
            animationController.stop();
          },
          onTapCancel: () {
            // 结束动画
            animationController.reset();
            animationController.stop();
          },
          child: Container(
            // 占坑，避免动画执行过程中导致父布局大小变得
            width: MIC_SIZE,
            height: MIC_SIZE,
            child: Center(
              child: _AnimatedMic(
                animation: animation,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//控件尺寸
const double MIC_SIZE = 80;

//动画
class _AnimatedMic extends AnimatedWidget {
//  透明度变化
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);

//  大小变化
  static final _sizeTween = Tween(begin: MIC_SIZE, end: MIC_SIZE - 20);

  Animation<double> animation;

  _AnimatedMic({required this.animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(MIC_SIZE / 2)),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
