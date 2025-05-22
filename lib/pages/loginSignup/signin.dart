// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:bankx/pages/loginSignup/openAccount.dart';
import 'package:bankx/pages/screens.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not authorized';
  bool tooManyAttempt = false;
  bool _isFingerPrintBiometricAvailable = false;
  bool? progress;
  bool? cancelTapOnFingerprintDialog;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  fingerPrintAuth() async {
    await _checkBiometrics();
    if (!_canCheckBiometrics!) {
      setState(() {
        _authorized = 'Fingerprint Sensor Not Available';
      });
    }

    if (_canCheckBiometrics!) {
      await _getAvailableBiometrics();
      for (int i = 0; i < _availableBiometrics!.length; i++) {
        if (_availableBiometrics![i] == BiometricType.strong) {
          _isFingerPrintBiometricAvailable = true;
        }
      }

      if (!_isFingerPrintBiometricAvailable) {
        setState(() {
          _authorized = 'Fingerprint Sensor Available but Fingerprint Not Set.';
        });
      }

      if (_isFingerPrintBiometricAvailable) {
        await _authenticate();
      }
    }
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      // ignore: avoid_print
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      // ignore: avoid_print
      print(availableBiometrics);
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      // ignore: avoid_print
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    String? exceptionMsg;
    try {
      setState(() {
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
      exceptionMsg = e.message!;
    }
    if (!mounted) return;

    final String message = authenticated
        ? 'Fingerprint Authentication Successful.'
        : (exceptionMsg!.isNotEmpty)
            ? exceptionMsg
            : 'Not authorize';
    if (authenticated) {
      tooManyAttempt = false;
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: const Register(),
        ),
      );
    }
    setState(() {
      _authorized = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool key, t) {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                bankXWithImage(),
                height20Space,
                const Text(
                  'Log In',
                  style: black14MediumTextStyle,
                ),
                height20Space,
                customerIdTextField(),
                height20Space,
                mPinTextField(),
                height20Space,
                countinueButton(),
                height20Space,
                height20Space,
                height20Space,
                const Text(
                  'Or scan your thumb to continue',
                  style: black14MediumTextStyle,
                ),
                height20Space,
                InkWell(
                  onTap: () => fingerPrintAuth(),
                  child: const Icon(
                    Icons.fingerprint,
                    size: 66.0,
                    color: primaryColor,
                  ),
                ),
                height20Space,
                Text(
                  _authorized,
                  style: red14MediumTextStyle,
                ),
                height20Space,
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      duration: const Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: const Register(),
                    ),
                  ),
                  child: const Text(
                    'I want to register',
                    style: black16MediumTextStyle,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => Navigator.push(context,
                    PageTransition(
                      duration: const Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: const Openaccount(),
                    ),
                  ),
                  child: const Text(
                    'I want to open an account',
                    style: black16MediumTextStyle,
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  bankXWithImage() {
    return Container(
      height: 200.0,
      decoration: const BoxDecoration(
        color: blackColor,
        image: DecorationImage(
          image: AssetImage('assets/banking.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: blackColor.withOpacity(0.46),
        alignment: Alignment.center,
        child: const Text(
          'BankX',
          style: white36BoldTextStyle,
        ),
      ),
    );
  }

  countinueButton() {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: const Home(),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        padding: const EdgeInsets.symmetric(
          vertical: fixPadding + 4.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          'Login',
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  customerIdTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding + 5.0,
        vertical: fixPadding - 6.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const TextField(
        cursorColor: primaryColor,
        style: black14MediumTextStyle,
        decoration: InputDecoration(
          hintStyle: black14MediumTextStyle,
          hintText: 'User ID',
          border: InputBorder.none,
        ),
      ),
    );
  }

  mPinTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding + 5.0,
        vertical: fixPadding - 6.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const TextField(
        cursorColor: primaryColor,
        style: black14MediumTextStyle,
        decoration: InputDecoration(
          hintStyle: black14MediumTextStyle,
          hintText: 'Password',
          border: InputBorder.none,
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
