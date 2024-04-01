import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:teste_app/src/constants/animations.dart";

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.show = false,
    required this.child,
  });

  final bool show;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget component = Stack(
      children: [
        child,
        if (show) _buildBackdrop(),
      ],
    );

    return component;
  }

  Widget _buildBackdrop() {
    return Container(
      decoration: const BoxDecoration(color: Colors.black54),
      child: _buildAlertLoading(),
    );
  }

  Widget _buildAlertLoading() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: GestureDetector(
              onDoubleTap: () {},
              onVerticalDragUpdate: (update) {},
              onHorizontalDragUpdate: (update) {},
              child: Lottie.asset(
                Animations.loading,
              )),
        ),
      ),
    );
  }
}
