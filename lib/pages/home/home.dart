import 'dart:async';
import 'package:animated/animated.dart';
import 'package:bankx/pages/screens.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart'; // Added for ScaffoldMessenger and SnackBar

class QuickActionsGrid extends StatelessWidget {
  final List<Map<String, String>> quickActions;

  const QuickActionsGrid({
    super.key,
    required this.quickActions,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 1),
            blurRadius: 1.41,
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: (screenWidth / 4 - 20) / 90,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: quickActions.length,
        itemBuilder: (context, index) {
          final action = quickActions[index];
          return GestureDetector(
            onTap: () {
              print('Tapped on ${action['name']}');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  action['icon']!,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 5),
                Text(
                  action['name']!,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF333333)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool scaled = false;
  bool _showBalance = false; // Correctly placed as a state variable

  final List<Map<String, String>> cardList = [
    {
      'accountType': 'Savings',
      'accountNumber': '1234567890',
      'balance': '5,000.00',
      'status': 'Active',
    },
    {
      'accountType': 'Checking',
      'accountNumber': '9876543215',
      'balance': '2,300.50',
      'status': 'Active',
    },
  ];

  final List<Map<String, String>> quickActions = [
    {'name': 'Transfer', 'icon': '💸'},
    {'name': 'Airtime', 'icon': '📱'},
    {'name': 'Data', 'icon': '📶'},
    {'name': 'Bills', 'icon': '💡'},
    {'name': 'Card', 'icon': '💳'},
    {'name': 'Savings', 'icon': '💰'},
    {'name': 'Loans', 'icon': '🏦'},
    {'name': 'More', 'icon': '➕'},
  ];

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 80),
      () => setState(() {
        scaled = true;
      }),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        centerTitle: true,
        title: const Text(
          'BankX',
          style: black18BoldTextStyle,
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          cards(),
          QuickActionsGrid(quickActions: quickActions),
          height20Space,
          businessLoan(),
          height20Space,
          height20Space,
        ],
      ),
    );
  }

  businessLoan() {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: const BusinessLoan(),
        ),
      ),
      child: Container(
        height: 170,
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/business-loan.jpg'),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 4.0,
              color: greyColor.withOpacity(0.5),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  bankServices({title, image}) {
    return Container(
      margin: const EdgeInsets.only(
        left: fixPadding * 2.0,
        right: fixPadding * 2.0,
        top: fixPadding * 2.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding,
        vertical: fixPadding,
      ),
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
            height: 45.0,
            width: 45.0,
            padding: const EdgeInsets.all(fixPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.0,
                  blurRadius: 4.0,
                  color: greyColor.withOpacity(0.5),
                ),
              ],
            ),
            child: Image.asset(image),
          ),
          widthSpace,
          Text(
            title,
            style: black16BoldTextStyle,
          ),
        ],
      ),
    );
  }

  transactionsAndFundtransfer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: const Transactions(),
                ),
              ),
              child: transactionsOrTransfer(title: 'Transactions'),
            ),
          ),
          widthSpace,
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: const FundTransfer(),
                ),
              ),
              child: transactionsOrTransfer(title: 'Fund Transfer'),
            ),
          ),
        ],
      ),
    );
  }

  transactionsOrTransfer({title}) {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 2.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: black14MediumTextStyle,
          ),
          heightSpace,
          Container(
            height: 20.0,
            width: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.0,
                  blurRadius: 3.0,
                  color: greyColor.withOpacity(0.5),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_forward,
              size: 15.0,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }

  cards() {
    final card = cardList.isNotEmpty ? cardList[0] : null;

    if (card == null) {
      return const SizedBox.shrink();
    }

    final String accountNumber = card['accountNumber'] ?? '';
    final String balance = card['balance'] ?? '';
    final String accountType = card['accountType'] ?? '';
    final String status = card['status'] ?? '';

    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 1.5),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(fixPadding),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: greenColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(fixPadding),
        ),
        padding: const EdgeInsets.all(fixPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Balance',
                  style: white14MediumTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _showBalance ? '₦$balance' : '₦ *****',
                      style: white18BoldTextStyle,
                    ),
                    IconButton(
                      icon: Icon(
                        _showBalance ? Icons.visibility : Icons.visibility_off,
                        color: whiteColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _showBalance = !_showBalance;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Number',
                  style: white14MediumTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      accountNumber
                          .replaceAllMapped(
                            RegExp(r'.{4}'),
                            (match) => '${match.group(0)} ',
                          )
                          .trim(),
                      style: white16BoldTextStyle,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: whiteColor,
                        size: 20,
                      ),
                      onPressed: () {
                        _copyToClipboard(accountNumber);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Type',
                      style: white14MediumTextStyle,
                    ),
                    Text(
                      accountType,
                      style: white16BoldTextStyle,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Status',
                      style: white14MediumTextStyle,
                    ),
                    Text(
                      status,
                      style: white16BoldTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



          // InkWell(
          //   onTap: () => Navigator.push(
          //     context,
          //     PageTransition(
          //       duration: const Duration(milliseconds: 500),
          //       type: PageTransitionType.rightToLeft,
          //       child: const Loans(),
          //     ),
          //   ),
          //   child: bankServices(title: 'Loans', image: 'assets/loan.png'),
          // ),
          // InkWell(
          //   onTap: () => Navigator.push(
          //     context,
          //     PageTransition(
          //       duration: const Duration(milliseconds: 500),
          //       type: PageTransitionType.rightToLeft,
          //       child: const Deposits(),
          //     ),
          //   ),
          //   child:
          //       bankServices(title: 'Deposits', image: 'assets/deposite.png'),
          // ),
          // InkWell(
          //   onTap: () => Navigator.push(
          //     context,
          //     PageTransition(
          //       duration: const Duration(milliseconds: 500),
          //       type: PageTransitionType.rightToLeft,
          //       child:
          //           const Cards(), // Note: This 'Cards' might refer to a different screen
          //     ),
          //   ),
          //   child: bankServices(title: 'Cards', image: 'assets/cards.png'),
          // ),
          // bankServices(title: 'All Services', image: 'assets/more.png'),
