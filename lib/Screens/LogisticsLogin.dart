import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import '../Controllers/AuthenticationAPIController.dart';
import '../Controllers/LogisticLoginController.dart';
import '../Widgets/LogisticsBottomNavigation.dart';
import '../Widgets/ResponsiveBodyFontWidget.dart';
import '../Widgets/SnackBarMSG.dart';

class LogisticsLogin extends StatefulWidget {
  const LogisticsLogin({super.key});

  @override
  State<LogisticsLogin> createState() => _LogisticsLoginState();
}

class _LogisticsLoginState extends State<LogisticsLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Debounced API Call
  void _onUsernameChanged() async {
    final username = _usernameController.text;
    if (username.isNotEmpty) {
      try {
        // Call the Authentication API
        await AuthenticationAPIController.fetchAuthenticationAPIs(
            username, context);
        print("Authentication successful for username: $username");

        // // After successful authentication, fetch location dropdown
        // await _fetchLocations(username);
      } catch (error) {
        print("Error during authentication: $error");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Authentication failed: $error")),
        // );
      }
    }
  }

  // Future<void> handleLogisticLogin(BuildContext context) async {
  //   final username = _usernameController.text;
  //   final password = _passwordController.text;
  //
  //   // Validate inputs
  //   if (username.isEmpty || password.isEmpty) {
  //     showSnackBarMessage(
  //       context,
  //       "All fields are required!",
  //       Color(0xFFEB3F3F),
  //     );
  //     return;
  //   }
  //
  //   try {
  //     // Call login API
  //     final loginResponse = await LogisticLoginController.fetchLogisticLogin(
  //       username,
  //       password,
  //       context,
  //     );
  //
  //     // Save the login response using the AuthProvider
  //     final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //     await authProvider.saveLoginResponse(loginResponse);
  //
  //     // Navigate to the next screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const NavigationScreen()),
  //     );
  //   } catch (error) {
  //     // Handle login failure
  //     showSnackBarMessage(
  //       context,
  //       "Login failed due to mismatch of the credential",
  //       Color(0xFFEB3F3F),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = ResponsiveUtils(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height, // Full screen height
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: size.height * 0.42, // 45% of screen height
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B66C3),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: responsive.getDefaultPadding(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.11),
                            Container(
                              width: size.width * 0.3, // Adjust image size
                              height: size.height * 0.1,
                              child: Image.asset("assets/icons/truck_icon.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      top: size.height * 0.26,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Unable to login ",
                                style: TextStyle(
                                  color: const Color(0xFF676767),
                                  fontSize: responsive.getNormalRangeFontSize(),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: " Contact Support?",
                                style: TextStyle(
                                  color: const Color(0xFF0B66C3),
                                  fontSize: responsive.getNormalRangeFontSize(),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    left: 0,
                    top: size.height * 0.21,
                    right: 0,
                    //bottom: 0,
                    child: Padding(
                      padding: responsive.getDefaultPadding(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.screenWidth * 0.08,
                          vertical: responsive.screenHeight * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.14),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('User Name', responsive),
                            _buildTextField(
                              controller: _usernameController,
                              hintText: 'Enter your User Name',
                              keyboardType: TextInputType.name,
                              responsive: responsive,
                              onChanged: (_) => _onUsernameChanged(),
                            ),
                            _buildLabel('Password', responsive),
                            _buildTextField(
                              controller: _passwordController,
                              hintText: 'Enter your password',
                              keyboardType: TextInputType.name,
                              obscureText: !_isPasswordVisible,
                              responsive: responsive,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF0B66C3),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            _buildLoginButton(context, responsive, "Next"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, ResponsiveUtils responsive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF171717),
          fontSize: responsive.getTitleFontSize(),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required ResponsiveUtils responsive,
    bool obscureText = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: ShapeDecoration(
          color: Colors.black.withOpacity(0.01),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xFF676767),
              fontSize: responsive.getBodyFontSize(),
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: suffixIcon,
          ),
          keyboardType: keyboardType,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLoginButton(
      BuildContext context, ResponsiveUtils responsive, String buttonText) {
    return GestureDetector(
      onTap: () async {
        final username = _usernameController.text;
        final password = _passwordController.text;

        // Validate inputs
        if (username.isEmpty || password.isEmpty) {
          showSnackBarMessage(
            context,
            "All fields are required!",
            Color(0xFFEB3F3F),
          );
          return;
        }

        try {
          // Call login API
          final loginResponse =
              await LogisticLoginController.fetchLogisticLogin(
            username,
            password,
            context,
          );

          // Save the login response using the AuthProvider
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          await authProvider.saveLoginResponse(loginResponse);

          // Navigate to the next screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationScreen()),
          );
        } catch (error) {
          // Handle login failure
          showSnackBarMessage(
            context,
            "Login failed due to mismatch of the credential",
            Color(0xFFEB3F3F),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: responsive.screenHeight * 0.02),
        decoration: ShapeDecoration(
          color: const Color(0xFF0B66C3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: responsive.getTitleFontSize(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
