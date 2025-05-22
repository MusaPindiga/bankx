// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';
import 'package:bankx/pages/screens.dart';

class OTPCode extends StatefulWidget {
  const OTPCode({super.key});

  @override
  _OTPCodeState createState() => _OTPCodeState();
}

class _OTPCodeState extends State<OTPCode> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController forthController = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode forthFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bankXWithImage(),
              height20Space,
              enterOTPHint(),
              height20Space,
              otpCode(),
              height20Space,
              countinueButton(),
              height20Space,
              resendText(),
            ],
          ),
        ],
      ),
    );
  }

  enterOTPHint() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Text(
        'Enter OTP sent on your registered mobile number',
        textAlign: TextAlign.center,
        style: black14MediumTextStyle,
      ),
    );
  }

  resendText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          Text(
            'Didn’t receive otp code! ',
            style: grey14MediumTextStyle,
          ),
          Text(
            'Resend',
            style: black18BoldTextStyle,
          ),
        ],
      ),
    );
  }

  otpCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          firstDigit(),
          secondDigit(),
          thirdDigit(),
          forthDigit(),
        ],
      ),
    );
  }

  firstDigit() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(fixPadding),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
      ),
      child: TextField(
        style: black16BoldTextStyle,
        maxLength: 1,
        buildCounter: (BuildContext? context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        controller: firstController,
        focusNode: firstFocusNode,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        textAlign: TextAlign.center,
        onChanged: (v) {
          String value = firstController.text;
          if (value.isNotEmpty) {
            FocusScope.of(context).requestFocus(secondFocusNode);
          }
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(fixPadding + 5.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  secondDigit() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(fixPadding),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
      ),
      child: TextField(
        style: black16BoldTextStyle,
        maxLength: 1,
        buildCounter: (BuildContext? context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        controller: secondController,
        focusNode: secondFocusNode,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        textAlign: TextAlign.center,
        onChanged: (v) {
          String value = secondController.text;
          if (value.isEmpty) {
            FocusScope.of(context).requestFocus(firstFocusNode);
            return;
          }
          FocusScope.of(context).requestFocus(thirdFocusNode);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(fixPadding + 5.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  thirdDigit() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(fixPadding),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
      ),
      child: TextField(
        style: black16BoldTextStyle,
        maxLength: 1,
        buildCounter: (BuildContext? context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        controller: thirdController,
        focusNode: thirdFocusNode,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        textAlign: TextAlign.center,
        onChanged: (v) {
          String value = thirdController.text;
          if (value.isEmpty) {
            FocusScope.of(context).requestFocus(secondFocusNode);
            return;
          }
          FocusScope.of(context).requestFocus(forthFocusNode);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(fixPadding + 5.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  forthDigit() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(fixPadding),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
      ),
      child: TextField(
        style: black16BoldTextStyle,
        maxLength: 1,
        buildCounter: (BuildContext? context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        controller: forthController,
        focusNode: forthFocusNode,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        textAlign: TextAlign.center,
        onChanged: (v) {
          String value = forthController.text;
          if (value.isEmpty) {
            FocusScope.of(context).requestFocus(thirdFocusNode);
            return;
          } else {
            showProgress();
          }
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(fixPadding + 5.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  bankXWithImage() {
    return Stack(
      children: [
        Container(
          height: 200.0,
          decoration: const BoxDecoration(
            color: blackColor,
            image: DecorationImage(
              image: AssetImage('assets/banking.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            color: blackColor.withOpacity(0.46),
            child: const Text(
              'BankX',
              style: white36BoldTextStyle,
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            iconSize: 24.0,
            color: whiteColor,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ],
    );
  }

  countinueButton() {
    return InkWell(
      onTap: () => showProgress(),
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
          'Continue',
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  showProgress() {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(fixPadding),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: fixPadding * 2.0),
            child: Wrap(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 45.0,
                        height: 45.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                          strokeWidth: 3.0,
                        ),
                      ),
                      height20Space,
                      heightSpace,
                      Text(
                        'Please wait..',
                        style: grey12MediumTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomBar(),
        ),
      ),
    );
  }
}
