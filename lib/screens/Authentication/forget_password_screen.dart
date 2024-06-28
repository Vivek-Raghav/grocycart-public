import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/theme_provider.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = '/forgotPasswordScreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailText = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      // Perform forgot password action
    }
  }

  @override
  void dispose() {
    _emailText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkTheme = ref.read(themeProvider);
    // Color isDarkColors =
    //     isDarkTheme ? Color.fromARGB(255, 23, 22, 22) : Colors.white;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDarkTheme ? Colors.white : Colors.black,
            )),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDarkTheme
                  ? 'assets/icons/dark_background.png'
                  : 'assets/icons/light_background.jpeg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/app_logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const TextWidget(
              content: 'Forgot Password',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            const TextWidget(
              content: 'Enter your email to reset password',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 50,
                    width: size.width * 0.6,
                    child: TextButton(
                      onPressed: submitForm,
                      child: const TextWidget(
                        content: 'Reset Password',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
