import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/mobilescreen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/webscreen_layout.dart';
import 'package:instagram/screens/signup_page.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/variables/global_variables.dart';
import 'package:instagram/widgets/textfield_inputs.dart';
// import 'package:instagram/resources/auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUsers() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUsers(
        email: _emailController.text, password: _passController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout())));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Center(
            child: Container(
              padding: MediaQuery.of(context).size.width > webScreenSize
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3)
                  : const EdgeInsets.all(10.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(), //FOR BETTER ALIGNMENT OF WIDGETS
                  ),

                  //INSTAGRAM LOGO (SVG FORMAT)
                  SvgPicture.asset(
                    'ic_instagram.svg',
                    color: blackColour,
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                  //TEXTFIELD FOR USENAME INPUT
                  TextFieldInputs(
                    hintText: "Username",
                    textEditingController: _emailController,
                    textInputKeyBoardType: TextInputType.emailAddress,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  //TEXTFIELD INPUT FOR PASSWORD
                  TextFieldInputs(
                    hintText: "Password",
                    textEditingController: _passController,
                    textInputKeyBoardType: TextInputType.text,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  InkWell(
                    onTap: loginUsers,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      child: _isloading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),

                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: blackColour,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
