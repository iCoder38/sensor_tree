import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controller
  final _formKey = GlobalKey<FormState>();
  final LoginFormController _controller = LoginFormController();
  // eye
  bool isPasswordShow = false;
  // terms checkbox
  bool termsAccepted = false;
  final List<String> images = [
    'https://via.placeholder.com/400x240/FF5733/FFFFFF?text=Image+1',
  ];

  @override
  void initState() {
    super.initState();
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
                  AppText().kTextWelcome,
                  22.0,
                  context,
                  fontWeight: FontWeight.w700,
                  lightModeColor: AppColor().kAppPrimaryColor,
                ),
                customText(
                  AppText().kSignInMessage,
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
                CustomTextField(
                  hintText: "Password",
                  controller: _controller.contPassword,
                  obscureText: isPasswordShow ? false : true,
                  prefixIcon: Icons.lock,
                  suffixIcon:
                      isPasswordShow ? Icons.visibility_off : Icons.visibility,
                  validator: (v) => _controller.validatePassword(v ?? ""),
                  onSuffixTap: () {
                    if (isPasswordShow == true) {
                      isPasswordShow = false;
                    } else {
                      isPasswordShow = true;
                    }
                    setState(() {});
                  },
                ),
                CustomButton(
                  text: 'Login',
                  textColor: AppColor().kAppWhiteColor,
                  textFontWidth: 16.0,
                  color: AppColor().kAppPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      customLog('All clear');
                      callLoginWB(context);
                    }
                  },
                ),
                Row(
                  children: [
                    CustomCheckBox(
                      label: "Remember me",
                      initialValue: termsAccepted,
                      onChanged: _handleCheckBoxChanged,
                      activeColor: Colors.green, // Custom color
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: customText(
                        'Forgot password',
                        14.0,
                        context,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText('Need an account?', 14.0, context),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationScreen(),
                                ),
                              );
                            },
                            child: customText(
                              'Sign Up',
                              14.0,
                              context,
                              fontWeight: FontWeight.w600,
                              lightModeColor: AppColor().kAppPrimaryColor,
                            ),
                          ),
                        ],
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

  void _handleCheckBoxChanged(bool newValue) {
    customLog(newValue);
    setState(() async {
      termsAccepted = newValue;
      if (newValue) {
        await deleteBool(AppText().kRememberMeKey);
      } else {
        await storeBool(AppText().kRememberMeKey, true);
      }
    });
  }

  // ====================== API ================================================
  // ====================== LOGIN
  Future<void> callLoginWB(context) async {
    Map<String, dynamic> response = await ApiService().postRequest(
      ApiEndPoint().kEndPointLogin,
      ApiPayloads.payloadLogin(
        _controller.contEmail.text.toString(),
        _controller.contPassword.text.toString(),
      ),
    );

    if (response['status'] == true) {
      customLog("Login successfull");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: AppColor().kAppPrimaryColor,
        ),
      );
    } else {
      customLog("Failed to view stories: ${response['error']}");
      customLog("Login failed");
    }
  }
}
