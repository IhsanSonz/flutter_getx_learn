part of '../pages.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  final MenuController _menuc = MenuController.to;

  Widget _widgetOptions(BuildContext context) {
    return Obx(() {
      switch (_menuc.mainTabIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const ProfilePage();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _menuc.scaffoldKey,
      drawer: SideMenu(),
      backgroundColor: Constants.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.kSecondaryColor,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _menuc.scaffoldKey.currentState!.openDrawer(),
        ),
        title: Text(
          'GetX Learn',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Constants.kTertiaryColor),
        ),
      ),
      body: _widgetOptions(context),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _menuc.mainTabIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (index) => _menuc.onTabTapped(index),
        ),
      ),
    );
  }
}
