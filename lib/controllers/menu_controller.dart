part of 'controllers.dart';

class MenuController extends GetxController {
  final _scaffoldKey = GlobalKey<ScaffoldState>().obs;
  static MenuController to = Get.find();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey.value;

  final _overlayState = false.obs;

  final _mainTabIndex = 0.obs;

  void show() {
    _overlayState.value = true;
  }

  void hide() {
    _overlayState.value = false;
  }

  int get mainTabIndex => _mainTabIndex.value;

  void onTabTapped(int index) {
    _mainTabIndex.value = index;
  }

  bool get overlayState => _overlayState.value;
}
