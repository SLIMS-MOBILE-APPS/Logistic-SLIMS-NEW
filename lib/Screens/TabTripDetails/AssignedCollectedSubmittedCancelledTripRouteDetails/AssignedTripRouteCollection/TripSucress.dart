import 'package:flutter/material.dart';
import '../../../../Widgets/LogisticsBottomNavigation.dart';
import 'ContinueAssignTripProcess.dart';

class SuccessUploadTRF extends StatelessWidget {
  const SuccessUploadTRF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NavigationScreen()),
          );
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/icons/successTRIP.png',
                      width: screenWidth * 0.24,
                      height: screenWidth * 0.24,
                      // fit: BoxFit.contain,
                    ),
                    Positioned(
                      right: -2,
                      bottom: 10,
                      child: Container(
                        width: screenWidth * 0.09,
                        height: screenWidth * 0.09,
                        child: Image.asset(
                          'assets/icons/checkcircle.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 110),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: const Text(
                    'Prescription Uploaded Successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF359073),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: const Text(
                    'Our representative will get in touch with you soon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF676767),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
