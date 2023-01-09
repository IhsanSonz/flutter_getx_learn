part of 'components.dart';

class OverlayScreen extends StatelessWidget {
  OverlayScreen({
    Key? key,
    required this.child,
    this.delay = const Duration(milliseconds: 500),
  }) : super(key: key);

  final MenuController _menuc = MenuController.to;

  final Widget child;
  final Duration delay;

  static OverlayScreen of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<OverlayScreen>()!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Obx(
          () {
            return _menuc.overlayState
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Opacity(
                      opacity: 8,
                      child: const ModalBarrier(
                        dismissible: false,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container();
          },
        ),
        Obx(() {
          return _menuc.overlayState
              ? Center(
                  child: FutureBuilder(
                    future: Future.delayed(delay),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState == ConnectionState.done)
                          ? const CircularProgressIndicator()
                          : const SizedBox();
                    },
                  ),
                )
              : Container();
        }),
      ],
    );
  }
}
