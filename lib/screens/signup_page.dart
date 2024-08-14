import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/mobilescreen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/webscreen_layout.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/textfield_inputs.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isloading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isloading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isloading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout())));
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),

                //INSTAGRAM LOGO
                // SvgPicture(bytesLoader)
                SvgPicture.asset('ic_instagram.svg'),
                const SizedBox(
                  height: 12,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.red,
                          ),
                    Positioned(
                        bottom: -9,
                        left: 75,
                        child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo_outlined)))
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),

                //INPUT FOR EMAIL ADDRESS
                TextFieldInputs(
                    hintText: 'Email',
                    textEditingController: _emailController,
                    textInputKeyBoardType: TextInputType.emailAddress),

                const SizedBox(
                  height: 24,
                ),
                //INPUT FOR  NAME
                TextFieldInputs(
                    hintText: 'UserName',
                    textEditingController: _userNameController,
                    textInputKeyBoardType: TextInputType.emailAddress),

                const SizedBox(
                  height: 24,
                ),
                //INPUTS FOR PASSWORD
                TextFieldInputs(
                    hintText: 'Password',
                    isPass: true,
                    textEditingController: _passwordController,
                    textInputKeyBoardType: TextInputType.emailAddress),

                const SizedBox(
                  height: 24,
                ),
                TextFieldInputs(
                    hintText: 'Add bio',
                    textEditingController: _bioController,
                    textInputKeyBoardType: TextInputType.emailAddress),

                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        color: Colors.blue),
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(color: primaryColor),
                          ),
                  ),
                ),
                Flexible(flex: 2, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text("Already have an account?")),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: const Text(
                            "Log in",
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
        ),
      ),
    );
  }
}
