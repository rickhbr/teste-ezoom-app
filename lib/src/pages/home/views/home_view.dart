import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/constants/mixins/screen_utils.dart';
import 'package:teste_app/src/pages/home/controllers/home_controller.dart';
import 'package:teste_app/src/pages/profile/views/profile_view.dart';
import 'package:teste_app/src/pages/tasks/views/tasks_view.dart';
import 'package:teste_app/src/routes/app_routes.dart';
import 'package:teste_app/src/services/navigation_service.dart';

class HomeView extends GetView<HomeController> with ScreenUtilityMixin {
  HomeView({super.key});

  final List<Widget> _pages = [
    TasksView(),
    ProfileView(),
  ];

  final iconList = <IconData>[
    Icons.home,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => IndexedStack(
              index: controller.tabIndex.value,
              children: _pages,
            )),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.white,
          onPressed: () async {
            var result = await NavigationService.push(PagesRoutes.createTask);

            if (result == true) {
              await controller.refreshList();
            }
          },
          child: Container(
            width: setWidth(56),
            height: setHeight(56),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
              shape: BoxShape.circle,
              color: CustomColors.terciaryColor,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(
          () => AnimatedBottomNavigationBar.builder(
            backgroundColor: CustomColors.primaryColor,
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? Colors.white : Colors.black;
              return Icon(iconList[index], color: color);
            },
            activeIndex: controller.tabIndex.value,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 12,
            rightCornerRadius: 12,
            gapLocation: GapLocation.center,
            onTap: (index) {
              controller.changeTabIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
