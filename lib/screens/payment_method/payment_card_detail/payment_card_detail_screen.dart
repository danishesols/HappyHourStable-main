import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/screens/payment_method/payment_card_detail/payment_card_detail_screen_controller.dart';

import '../../../core/colors.dart';
import '../../../global_widgets/main_button.dart';
import '../../../routes/app_routes.dart';

class PaymentCardDetailScreen
    extends GetView<PaymentCardDetailScreenController> {
  const PaymentCardDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text("Payment Method"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                ),
                child: Text(
                  "Please add your card details",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              CreditCardWidget(
                  cardHolderName: 'Lorem Ipsum',
                  cardNumber: "4242 4242 4242 4242",
                  expiryDate: '12/22',
                  cvvCode: "123",
                  showBackView: false,
                  obscureCardNumber: false,
                  obscureCardCvv: false,
                  isHolderNameVisible: true,
                  cardBgColor: primary,
                  isChipVisible: false,
                  isSwipeGestureEnabled: false,
                  onCreditCardWidgetChange: (creditCardBrand) {},
                  customCardTypeIcons: const []),
              SizedBox(
                height: H * 0.01,
              ),
              Column(
                children: [
                  CreditCardForm(
                    cvvValidationMessage: "Please input a valid CVV",
                    numberValidationMessage: "Please input a valid number",
                    dateValidationMessage: "Please input a valid date",
                    formKey: controller.formKey,
                    obscureCvv: false,
                    obscureNumber: false,
                    cardNumber: "",
                    cvvCode: "123",
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: "",
                    expiryDate: '12/22',
                    themeColor: primary,
                    textColor: Colors.black,
                    cardHolderDecoration: const InputDecoration(
                        fillColor: whiteColor,
                        filled: true,
                        contentPadding: EdgeInsets.all(24),
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        hintText: "Card holder name"),
                    cardNumberDecoration: const InputDecoration(
                      fillColor: whiteColor,
                      filled: true,
                      contentPadding: EdgeInsets.all(24),
                      hintText: 'Card number',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                    ),
                    expiryDateDecoration: const InputDecoration(
                      fillColor: whiteColor,
                      filled: true,
                      contentPadding: EdgeInsets.all(24),
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                      hintText: 'Expiry',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      fillColor: whiteColor,
                      filled: true,
                      contentPadding: EdgeInsets.all(24),
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                      hintText: 'CCV',
                    ),
                    onCreditCardModelChange: (creditCardModel) {},
                  )
                ],
              ),
              SizedBox(
                height: H * 0.05,
              ),
              SizedBox(
                height: H * 0.09,
                width: W,
                child: CustomElevatedButtonWidget(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.toNamed(Routes.paymentMethodrequestCompletedScreen);
                    }
                  },
                  text: "Proceed",
                  textColor: blackColor,
                  fontSize: 24,
                  verticalPadding: 0,
                  borderRadius: 45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
