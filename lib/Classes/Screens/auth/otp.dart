import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.getEmail,
    required this.images,
    required this.sloganText,
  });

  final String getEmail;
  final List<String> images;
  final String sloganText;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // controller
  final _formKey = GlobalKey<FormState>();
  final LoginFormController _controller = LoginFormController();
  // eye
  bool isPasswordShow = false;
  // terms checkbox
  bool termsAccepted = false;
  // code is
  String codeIs = '';
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
                  AppText().kTextITOVerification,
                  22.0,
                  context,
                  fontWeight: FontWeight.w700,
                  lightModeColor: AppColor().kAppPrimaryColor,
                ),
                customText(
                  AppText().kTextITOVerificationMessage,
                  14.0,
                  context,
                  fontWeight: FontWeight.w400,
                  lightModeColor: AppColor().kAppBlackColor,
                ),
                SizedBox(height: 20),
                OtpTextField(
                  numberOfFields: 4,
                  fieldWidth: 50,
                  borderColor: Color.fromARGB(255, 70, 7, 216),
                  fillColor: Colors.black,
                  enabledBorderColor: Colors.black,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                    customLog("Code==> $code");
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    codeIs = verificationCode;
                    setState(() {});
                    /*showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      },
                    );*/
                  }, // end onSubmit
                ),
                SizedBox(height: 20),

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
                  text: 'Next',
                  textColor: AppColor().kAppWhiteColor,
                  textFontWidth: 16.0,
                  color: AppColor().kAppPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      customLog('All clear');
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
  // ====================== OTP
  Future<void> callForgotPasswordWB(context) async {
    showLoadingUI(context, 'Please wait...');
    // dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    Map<String, dynamic> response = await ApiService().postRequest(
      ApiEndPoint().kEndPointResetPassword,
      ApiPayloads.payloadOTP(
        codeIs.toString(),
        widget.getEmail,
        _controller.contPassword.text.toString(),
      ),
    );

    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: AppColor().kAppPrimaryColor,
        ),
      );
      // dismiss alert
      Navigator.pop(context);
      // back
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      customLog("Failed to otp: ${response['error']}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: Colors.redAccent,
        ),
      );
      // dismiss alert
      Navigator.pop(context);
    }
  }
}
