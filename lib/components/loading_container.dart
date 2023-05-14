import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool? loading;
  final bool? cover;
  final Widget child;

  const LoadingContainer(
      {super.key, this.loading, this.cover, required this.child});

  @override
  Widget build(BuildContext context) {
    if (cover == true) {
      return loading == true ? _loadingView : child;
    } else {
      return Stack(
        children: [child, loading == true ? _loadingView : Container()],
      );
    }
  }

  Widget get _loadingView {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
