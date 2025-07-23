import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallPage extends StatefulWidget {
  @override
  _PaywallPageState createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  Offerings? offerings;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOfferings();
  }

  Future<void> loadOfferings() async {
    try {
      Offerings result = await Purchases.getOfferings();
      setState(() {
        offerings = result;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching offerings: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> purchasePackage(Package package) async {
    try {
      PurchaseResult result = await Purchases.purchasePackage(package);

      CustomerInfo customerInfo = result.customerInfo;
      if (customerInfo.entitlements.all['premium']?.isActive ?? false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Purchase successful! Premium unlocked.'),
        ));
      }
    } catch (e) {
      print('Purchase error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    Package? package = offerings?.current?.availablePackages.first;

    return Scaffold(
      appBar: AppBar(title: Text('Upgrade')),
      body: package == null
          ? Center(child: Text("No products available."))
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              package.storeProduct.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(package.storeProduct.description),
            Text('Price: ${package.storeProduct.priceString}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => purchasePackage(package),
              child: Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}
