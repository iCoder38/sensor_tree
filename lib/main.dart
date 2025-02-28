import 'Classes/Utils/imports/barrel_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WelcomeScreen()));
}
