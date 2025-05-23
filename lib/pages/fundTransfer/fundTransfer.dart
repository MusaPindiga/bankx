// ignore_for_file: file_names

import 'package:bankx/pages/screens.dart';

class FundTransfer extends StatelessWidget {
  const FundTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: const Text(
          'Fund Trasfer',
          style: black18BoldTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: const OneTimeTransfer(),
              ),
            ),
            child: transferAndBeneficiaries(title: 'One Time Transfer'),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: const Beneficiaries(),
              ),
            ),
            child: transferAndBeneficiaries(title: 'Beneficiaries'),
          ),
        ],
      ),
    );
  }

  transferAndBeneficiaries({title}) {
    return Container(
      margin: const EdgeInsets.only(
        left: fixPadding * 2.0,
        right: fixPadding * 2.0,
        top: fixPadding * 2.0,
      ),
      padding: const EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.20),
              shape: BoxShape.circle,
              border: Border.all(color: primaryColor),
            ),
            child: const Icon(
              Icons.compare_arrows,
              color: primaryColor,
            ),
          ),
          widthSpace,
          Text(
            title,
            style: black14BoldTextStyle,
          ),
        ],
      ),
    );
  }
}
