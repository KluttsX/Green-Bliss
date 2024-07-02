import 'package:Bliss/screens/blog.dart';
import 'package:Bliss/screens/home_page.dart';
// import 'package:Bliss/screens/popup.dart';
import 'package:Bliss/screens/scan_code.dart';
import 'package:Bliss/widgets/navigation_drawer.dart';
import 'package:Bliss/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late MotionTabBarController _motionTabBarController;

  @override
  bool get wantKeepAlive => true;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3, // Cambia según la cantidad de pestañas
      vsync: this,
    );
  }

  final screens = [
    const HomePage(),
    const ScanCodePage(),
    const BlogPage(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    super.build(context);

    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          key: _key,
          drawer: DrawerMenu(onLogout: () {
            setState(() {});
            _key.currentState?.openEndDrawer();
          }),
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Iconsax.menu_1, color: Colors.grey[900]),
              onPressed: () => _key.currentState!.openDrawer(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Iconsax.search_normal_1, color: Colors.grey[900]),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
            title: const Text('Green-Bliss'),
            centerTitle: true,
          ),
          body: screens[index],
          bottomNavigationBar: MotionTabBar(
            controller: _motionTabBarController,
            initialSelectedTab: 'Mapa',
            labels: const ['Mapa', 'Scan', 'Blog'],
            icons: const [Iconsax.map, Iconsax.scan_barcode, Iconsax.bookmark],
            tabSize: 50,
            tabBarHeight: 65,
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            tabIconSize: 28.0,
            tabIconSelectedSize: 26.0,
            onTabItemSelected: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}
