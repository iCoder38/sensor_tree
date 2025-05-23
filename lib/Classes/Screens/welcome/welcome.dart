import 'package:flutter/foundation.dart';
import 'package:sensor_tree/Classes/Screens/home/home.dart';
import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<String> storeImages = [];
  bool screenLoader = true;
  // slogan text
  String sloganText = '';
  @override
  void initState() {
    super.initState();

    // remember me
    checkStatus(context);
  }

  void checkStatus(context) async {
    Map<String, dynamic> response = await getBoolWithResponse(
      AppText().kRememberMeKey,
    );

    if (response['success']) {
      if (kDebugMode) {
        print('✅ Success: ${response['message']}, Value: ${response['value']}');
      } // slider api
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  LoginScreen(images: storeImages, sloganText: sloganText),
        ),
      );*/
    } else {
      if (kDebugMode) {
        print('❌ Error: ${response['message']}');
      } // slider api
      callSliderWB(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: screenLoader ? SizedBox() : _UIKit(context));
  }

  Column _UIKit(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Image.asset('assets/images/welcome.png', fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Center(
                      child: Image.asset(
                        'assets/images/Group 451.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Center(
                    child: customText(
                      "Welcome to ${AppText().appName}",
                      22,
                      context,
                      lightModeColor: AppColor().kAppWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => LoginScreen(
                                  images: storeImages,
                                  sloganText: sloganText,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor().kAppPrimaryColor,
                              child: Center(
                                child: customText(
                                  'Sign In',
                                  16.0,
                                  context,
                                  lightModeColor: AppColor().kAppWhiteColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => RegistrationScreen(
                                          images: storeImages,
                                          sloganText: sloganText,
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor().kAppPrimaryColor,
                                child: Center(
                                  child: customText(
                                    'Sign Up',
                                    16.0,
                                    context,
                                    lightModeColor: AppColor().kAppWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BluetoothScannerScreen(),
                      ),
                    );
                  },
                  child: customText("Bluetooth files", 16.0, context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ====================== API ================================================
  // ==================== SLIDER
  Future<void> callSliderWB(context) async {
    Map<String, dynamic> response = await ApiService().getRequestWithoutParams(
      ApiEndPoint().kEndPointSlider,
    );
    if (response['status'] == true) {
      // customLog("Slider successfull");
      storeImages = List<String>.from(response['images']);
      sloganText = response['slogan']['value'].toString();

      setState(() {
        screenLoader = false;
      });
    } else {
      customLog("Failed to Slider: ${response['error']}");
      customLog("Slider failed");
    }
  }
}
