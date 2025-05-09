import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/modules/home/controllers/home_controller.dart';
import '../../app/routes/app_pages.dart';

class MainNavigationScaffold extends StatelessWidget {
  final Widget body;
  const MainNavigationScaffold({Key? key, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saka Digital'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  'Saka Digital',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            _drawerItem(Icons.home, 'Home', 0, controller),
            _drawerItem(Icons.school, 'Pembelajaran', 1, controller),
            _drawerItem(Icons.article, 'Berita', 2, controller),
            _drawerItem(Icons.person, 'Profil', 3, controller),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Simulate logout
                Get.find<HomeController>().logout();
              },
            ),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), label: 'Pembelajaran'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.article), label: 'Berita'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profil'),
            ],
          )),
    );
  }

  Widget _drawerItem(
      IconData icon, String title, int tabIndex, HomeController controller) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        controller.changeTab(tabIndex);
        Get.back(); // Close the drawer
      },
    );
  }
}
