import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // controller
  final _formKey = GlobalKey<FormState>();
  final RegistrationFormController _controller = RegistrationFormController();
  // eye
  bool isPasswordShow = false;
  // terms checkbox
  bool termsAccepted = false;
  final List<String> images = [
    'https://via.placeholder.com/400x240/FF5733/FFFFFF?text=Image+1',
  ];
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
                  AppText().kSignUpMessage,
                  14.0,
                  context,
                  fontWeight: FontWeight.w400,
                  lightModeColor: AppColor().kAppBlackColor,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "First name",
                        controller: _controller.contFirstName,
                        prefixIcon: Icons.person,

                        validator:
                            (v) => _controller.validateFirstName(v ?? ""),
                        onSuffixTap: () {
                          // Handle visibility toggle (you can manage state)
                        },
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: CustomTextField(
                        hintText: "Last name",
                        controller: _controller.contLastName,
                        prefixIcon: Icons.person,

                        validator: (v) => _controller.validateLastName(v ?? ""),
                        onSuffixTap: () {
                          // Handle visibility toggle (you can manage state)
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "+91",
                        controller: _controller.contPhoneNumberCode,
                        prefixIcon: Icons.code,
                        keyboardType: TextInputType.number,

                        validator:
                            (v) => _controller.validatePhoneNumberCode(v ?? ""),
                        onSuffixTap: () {
                          // Handle visibility toggle (you can manage state)
                        },
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        hintText: "Phone",
                        controller: _controller.contPhoneNumber,
                        prefixIcon: Icons.phone,

                        validator:
                            (v) => _controller.validatePhoneNumber(v ?? ""),
                        onSuffixTap: () {
                          // Handle visibility toggle (you can manage state)
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Email",
                  controller: _controller.contEmail,
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
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
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Confirm password",
                  controller: _controller.contConfirmPassword,
                  obscureText: isPasswordShow ? false : true,
                  prefixIcon: Icons.lock,
                  suffixIcon:
                      isPasswordShow ? Icons.visibility_off : Icons.visibility,
                  validator:
                      (v) => _controller.validateConfirmPassword(v ?? ""),
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
                  text: 'Create Account',
                  textColor: AppColor().kAppWhiteColor,
                  textFontWidth: 16.0,
                  color: AppColor().kAppPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      customLog('All clear');
                    }
                  },
                ),

                Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText('Already have an account?', 14.0, context),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: customText(
                              'Sign In',
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
    setState(() {
      termsAccepted = newValue;
    });
  }
}
