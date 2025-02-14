import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String tabName;
  //final VoidCallback? callBack;

  const NoDataFoundWidget({
    Key? key,
    required this.tabName,
    //this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Image(
          image: AssetImage('assets/icons/No-Data.png'),
          width: 40,
        ),
        const SizedBox(height: 8),
        Text(
          tabName,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          "There is no data to show you right now.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        //const SizedBox(height: 20),
        // if (callBack != null)
        //   ElevatedButton(
        //     onPressed: callBack!,
        //     child: const Text('Reload'),
        //   ),
      ],
    );
  }
}
