import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AuthProvider.dart';
import 'Screens/LogisticsLogin.dart';
import 'Widgets/LogisticsBottomNavigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
  String? loginResponse = prefs.getString('loginResponse');
  runApp(
      LogisticsSLIMS(isAuthenticate: isAuthenticated && loginResponse != null));
}

class LogisticsSLIMS extends StatelessWidget {
  final bool isAuthenticate;
  LogisticsSLIMS({Key? key, required this.isAuthenticate}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xFF0B66C3),
              colorScheme: ColorScheme.fromSwatch(
                accentColor: const Color(0xFF0B66C3),
              ),
            ),
            home: Builder(builder: (context) {
              Provider.of<AuthProvider>(context, listen: false).loadResponses();
              return isAuthenticate ? NavigationScreen() : SplashScreen();
            })));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds, then navigate to the next page
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const LogisticsLogin()), // Navigate to NextPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.45, -0.90),
          end: Alignment(-0.45, 0.9),
          colors: [
            Color.fromARGB(255, 47, 135, 225),
            Color(0xFF0B66C3),
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'Logistics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
