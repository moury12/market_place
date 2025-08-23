import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_text_button.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/presentations/profile/views/term_policy_help_page.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});
  static const String routeName = '/subscription-man';

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Offerings? _offerings;
  Package? _selected;
  bool _loading = true;
  bool _purchasing = false;

  // 🔗 আপনার HTTPS লিঙ্ক দিন (IP+HTTP ব্যবহার করবেন না)
  final Uri _privacy = Uri.parse('https://your-domain.com/privacy');
  final Uri _terms = Uri.parse('https://your-domain.com/terms');

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      setState(() {
        _offerings = offerings;
        _selected = offerings.current?.annual ?? offerings.current?.monthly;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      _showMsg('Could not load products. Please try again.');
    }
  }

  Future<void> _purchaseSelected() async {
    if (_selected == null) return;
    setState(() => _purchasing = true);
    try {
      await Purchases.purchasePackage(_selected!);
      _showMsg('Subscription purchased successfully.');
      if (mounted) Navigator.pop(context, true);
    } on PurchasesErrorCode catch (e) {
      _showMsg('Purchase failed: $e');
    } catch (e) {
      _showMsg('Purchase failed. Please try again.');
    } finally {
      setState(() => _purchasing = false);
    }
  }

  Future<void> _restore() async {
    try {
      await Purchases.restorePurchases();
      _showMsg('Restored purchases.');
    } catch (_) {
      _showMsg('Restore failed. Try again.');
    }
  }

  Future<void> _openManage() async {
    try {
      final info = await Purchases.getCustomerInfo();
      final managementUrlStr = info.managementURL;
      Uri? uri;

      if (managementUrlStr != null && managementUrlStr.isNotEmpty) {
        uri = Uri.parse(managementUrlStr);
      } else {
        uri =
            Platform.isIOS
                ? Uri.parse('https://apps.apple.com/account/subscriptions')
                : Uri.parse('https://play.google.com/store/account/subscriptions');
      }

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showMsg('Could not open subscription settings.');
      }
    } catch (e) {
      _showMsg('Failed to open subscription settings.');
    }
  }

  Future<void> _open(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showMsg('Could not open ${url.toString()}');
    }
  }

  void _showMsg(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child:
            _loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose Your Subscription Plan',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Get the best features to grow your business!',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(height: 16),

                      // Features highlight
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.verified, size: 20, color: AppColors.kPrimaryColor),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Priority access to our advanced listings\nCan add unlimited product',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Plans
                      if (_offerings?.current?.annual != null ||
                          _offerings?.current?.monthly != null)
                        Row(
                          children: [
                            if (_offerings?.current?.annual != null)
                              Expanded(
                                child: _planTile(_offerings!.current!.annual!, label: 'Yearly'),
                              ),
                            const SizedBox(width: 12),
                            if (_offerings?.current?.monthly != null)
                              Expanded(
                                child: _planTile(_offerings!.current!.monthly!, label: 'Monthly'),
                              ),
                          ],
                        ),

                      const SizedBox(height: 16),

                      // CTA
                      CustomButton(
                        onTap: () => _purchasing ? null : _purchaseSelected,

                        title: _purchasing ? 'Processing…' : 'Get started for free',
                      ),

                      const SizedBox(height: 10),

                      // Restore + Manage
                      Row(
                        spacing: 6.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextButton(
                              title: AppStaticStrings.privacyPolicy.tr,
                              onPressed: () {
                                Get.toNamed(TermsPolicyHelpPage.routeName);
                              },
                            ),
                          ),
                          Expanded(child: CustomTextButton(title: 'Restore Purchases', onPressed: _restore)),
                          Expanded(child: CustomTextButton(title: 'Manage', onPressed: _openManage)),
                        ],
                      ),

                      const SizedBox(height: 8),

                      const SizedBox(height: 8),

                      // Auto-renewal disclosure
                      Text(
                        _autoRenewalDisclosure(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black54,
                          height: 1.25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  // Plan card
  Widget _planTile(Package pkg, {required String label}) {
    final isSelected = _selected?.identifier == pkg.identifier;
    return InkWell(
      onTap: () => setState(() => _selected = pkg),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, size: 18, color: AppColors.kPrimaryColor),
              ],
            ),
            const SizedBox(height: 6),
            Text(pkg.storeProduct.priceString, style: const TextStyle(fontSize: 16)),
            if (pkg.packageType == PackageType.annual)
              const Text('Billed yearly', style: TextStyle(fontSize: 12, color: Colors.black54)),
            if (pkg.packageType == PackageType.monthly)
              const Text('Billed monthly', style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  String _autoRenewalDisclosure() {
    return 'Payment will be charged to your Apple ID at confirmation of purchase. '
        'Subscription auto-renews unless canceled at least 24 hours before the end of the current period. '
        'Your account will be charged for renewal within 24 hours prior to the end of the period. '
        'You can manage or cancel your subscription in App Store → Account → Subscriptions. '
        'Any unused portion of a free trial is forfeited when a subscription is purchased.';
  }
}
