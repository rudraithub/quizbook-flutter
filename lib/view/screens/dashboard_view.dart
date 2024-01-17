// ignore_for_file: curly_braces_in_flow_control_structures, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/utils/constans.dart';
import 'package:rudra_it_hub/view/screens/history_view.dart';

import 'package:rudra_it_hub/view/screens/signup_view.dart';
import 'package:rudra_it_hub/view/screens/std_screen.dart';

import '../../controller/dashboard_controller.dart';

class AppbarBottomBarScreen extends StatelessWidget {
  final AppbarBottombarController _controller =
      Get.put(AppbarBottombarController());

  AppbarBottomBarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: const Size.fromHeight(60.0),
      //     child: Obx(
      //           () => _controller.currentIndex.value == 2
      //           ? const SizedBox.shrink()
      //           : CommonAppBarScreen(
      //         title: _controller.getPageName(),
      //         backgroundColor: whiteColor,
      //         automaticallyImplyLeading:
      //         _controller.currentIndex.value == 2,
      //         isBackArrow: _controller.currentIndex.value == 2,
      //       ),
      //     )),
      body: PageView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller.pageController,
          onPageChanged: (index) {
            _controller.onTabTapped(index);
          },
          itemBuilder: (_, index) {
            if (index == 0) {
              return const StudyScreen();
            } else if (index == 1) {
              return const History();
            } else
              return SignUpScreen(
                firstName: 'Prashant',
                isProfile: true,
                lastName: 'Makwana',
                email: 'mp959183@gmail.com',
                mobileNo: '9484779764',
                gender: 'Male',
                desi: "student",
                date: "15-02-2004",
              );
          }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue[800],
          showSelectedLabels: true,
          iconSize: getScreenHeight(context) * 0.050,
          currentIndex: _controller.currentIndex.value,
          onTap: _controller.onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                // color: Colors.grey,
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.watch_later_outlined,
                // color: Colors.grey,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                // color: Colors.grey,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
