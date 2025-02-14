import 'package:flutter/material.dart';

class CollectedRouteSubmitBottomSheet extends StatelessWidget {
  final String heading;
  final Function onYesPressed;
  final Function onNoPressed;

  const CollectedRouteSubmitBottomSheet({
    Key? key,
    required this.heading,
    required this.onYesPressed,
    required this.onNoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Text(
            heading,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30), // Spacing before buttons

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Yes Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    onYesPressed();
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFB0B0B0), // Grey border color
                      width: 1, // Border width
                    ),
                    backgroundColor: Color(0xFF0B66C3), // White background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // No Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    onNoPressed();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFB0B0B0), // Grey border color
                      width: 1, // Border width
                    ),
                    backgroundColor: Colors.white, // White background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.black, // Text color
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Spacing before buttons
        ],
      ),
    );
  }
}