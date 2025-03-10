import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Classes/Utils/imports/barrel_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env
  try {
    await dotenv.load(fileName: ".env");
    customLog('.env loaded successfully');
  } catch (e) {
    customLog('Failed to load .env: $e');
  }

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WelcomeScreen()));
}
