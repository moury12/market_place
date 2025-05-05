import 'package:flutter/material.dart';
import 'package:market_place/core/components/custom_appbar.dart';

class SellerProfilePage extends StatelessWidget {
  static const String routeName = "/seller-profile";
  const SellerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: "Seller Profile",),
    );
  }
}
