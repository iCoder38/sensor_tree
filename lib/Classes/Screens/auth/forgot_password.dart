import 'package:sensor_tree/Classes/Screens/auth/otp.dart';
import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, required this.images});

  final List<String> images;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // controller
  final _formKey = GlobalKey<FormState>();
  final LoginFormController _controller = LoginFormController();
  // eye
  bool isPasswordShow = false;
  // terms checkbox
  bool termsAccepted = false;
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    // init
    images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _UIKit(context));
  }

  Widget _UIKit(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [ImageCarousel(images: images), _wBottomUIKit(context)],
      ),
    );
  }

  Widget _wBottomUIKit(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 235, 230, 230),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Group 327.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                customText(
                  AppText().kTextForgotPassword,
                  22.0,
                  context,
                  fontWeight: FontWeight.w700,
                  lightModeColor: AppColor().kAppPrimaryColor,
                ),
                customText(
                  AppText().kTextForgotPasswordMessage,
                  14.0,
                  context,
                  fontWeight: FontWeight.w400,
                  lightModeColor: AppColor().kAppBlackColor,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Email",
                  controller: _controller.contEmail,
                  prefixIcon: Icons.email,

                  validator: (v) => _controller.validateEmail(v ?? ""),
                  onSuffixTap: () {
                    // Handle visibility toggle (you can manage state)
                  },
                ),
                SizedBox(height: 20),

                CustomButton(
                  text: 'Next',
                  textColor: AppColor().kAppWhiteColor,
                  textFontWidth: 16.0,
                  color: AppColor().kAppPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      customLog('All clear');
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      callForgotPasswordWB(context);
                    }
                  },
                ),

                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: customText(
                        'Back',
                        14.0,
                        context,
                        fontWeight: FontWeight.w600,
                        lightModeColor: AppColor().kAppBlackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ====================== API ================================================
  // ====================== FORGOT PASSWORD
  Future<void> callForgotPasswordWB(context) async {
    showLoadingUI(context, 'Please wait...');
    Map<String, dynamic> response = await ApiService().postRequest(
      ApiEndPoint().kEndPointForgotPassword,
      ApiPayloads.payloadForgotPassword(_controller.contEmail.text.toString()),
    );
    customLog(response);
    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: AppColor().kAppPrimaryColor,
        ),
      );
      // dismiss alert
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => OTPScreen(
                getEmail: _controller.contEmail.text.toString(),
                images: images,
              ),
        ),
      );
    } else {
      customLog("Status is false");
      // dismiss alert
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: AppColor().kAppRedAColor,
        ),
      );
    }
  }
}
