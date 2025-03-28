import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import '../Widgets/AppBarWidget.dart';
import '../main.dart';
import 'HelpAndSupportScreen.dart';

class LogisticsProfile extends StatefulWidget {
  const LogisticsProfile({super.key});

  @override
  State<LogisticsProfile> createState() => _LogisticsProfileState();
}

class _LogisticsProfileState extends State<LogisticsProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      const HeaderBar(
        height: 240.0, // Custom height
        child: SizedBox(),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.15), // Push the container down
            Center(
                child: Container(
                    width: size.width * 0.9,
                    padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x05192F54),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x05192F54),
                          blurRadius: 15,
                          offset: Offset(0, 15),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x02192F54),
                          blurRadius: 20,
                          offset: Offset(0, 33),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x00192F54),
                          blurRadius: 24,
                          offset: Offset(0, 59),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color(0x00192F54),
                          blurRadius: 26,
                          offset: Offset(0, 92),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // User icon, name, and mobile number
                          const SizedBox(height: 16),
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(
                              Icons.account_circle,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Balaji Swaminathan", // Replace with the actual username
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF171717),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "+91 23456 76890", // Replace with the actual mobile number
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF676767),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // buildProfileOption(
                          //   title: "Reminders",
                          //   subtitle: "Manage reminders and notification",
                          //   onTap: () {},
                          // ),
                          // const SizedBox(height: 8),
                          // const Divider(),
                          buildProfileOption(
                            title: "Help & Support",
                            subtitle: "Reach out to us for ny issues",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => helpAndSuppport()));
                            },
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()),
                              );
                            },
                            child: Container(
                              width: 296,
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 7),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFFD21416)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 14,
                                    height: 14,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child:
                                        Image.asset("assets/icons/logout.png"),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Logout",
                                    style: const TextStyle(
                                      color: Color(0xFFD21416),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]))),
          ],
        ),
      )
    ]));
  }

  Widget buildProfileOption({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF676767),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
