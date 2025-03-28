import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import '../Widgets/AppBarWidget.dart';

class helpAndSuppport extends StatefulWidget {
  const helpAndSuppport({Key? key}) : super(key: key);

  @override
  State<helpAndSuppport> createState() => _helpAndSuppportState();
}

class _helpAndSuppportState extends State<helpAndSuppport> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _InitializeLogin();
  }

  String SupportMobile = '999999999';
  String SupportEmail = 'abc@gmail.com';

  void _InitializeLogin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.loadResponses();

    final logINResponse = authProvider.loginResponse;

    if (logINResponse != null) {
      setState(() {
        // SupportEmail = "${logINResponse?.supportEmailId ?? ''}";
        // SupportMobile = "${logINResponse?.supportMobileNo ?? ''}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderBar(
            height: 120.0, // Custom height
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded, // Arrow back icon
                      color: Colors.white, // White color for the icon
                      size: 24.0, // Icon size
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 253.33,
                    padding: const EdgeInsets.all(8.0), // Adjusted padding
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20.0), // Added border radius
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A192F54),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset("assets/icons/helpblue.png"),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We are here to help!\nGet in touch with us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF171717),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A192F54),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _isLoading
                        //     ? const CircularProgressIndicator()  // Show loading while fetching
                        //     :
                        ContactInfoItem(
                          iconAsset: "assets/icons/phonewhite.png",
                          title: 'Phone number',
                          subtitle: SupportMobile.isNotEmpty
                              ? SupportMobile
                              : 'Not available', //_phoneNumber.isNotEmpty ? _phoneNumber : 'Not available',
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        // _isLoading
                        //     ? const CircularProgressIndicator()  // Show loading while fetching
                        //     :
                        ContactInfoItem(
                          iconAsset: "assets/icons/mailwhite.png",
                          title: 'E-mail address',
                          subtitle: SupportEmail.isNotEmpty
                              ? SupportEmail
                              : 'Not available', //_emailAddress.isNotEmpty ? _emailAddress : 'Not available',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoItem extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String subtitle;

  const ContactInfoItem({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 9, 102, 194),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            iconAsset,
            width: 24,
            height: 24,
            color: Colors.white, // Example: Apply color if needed
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF171717),
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
      ],
    );
  }
}
