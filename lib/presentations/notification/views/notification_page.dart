import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_refresh_indicator.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/presentations/notification/controller/notification_controller.dart';
import 'package:market_place/presentations/notification/loading/notification_card_loading.dart';

import '../../../core/components/empty_widget.dart';
import '../../../core/constants/padding_constant.dart';
import '../widget/notification_card_item_widget.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = "/notification";

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.notifications.tr),
      body: CustomRefreshIndicatorWidget(
        onRefresh: () async{
          await NotificationController.to.getNotificationRequest();

        },
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [SliverToBoxAdapter(child:  Padding(
            padding: padding12,
            child: Obx(() {
              return NotificationController.to.isLoadingNotificationList.value
                  ? NotificationCardLoading(): NotificationController.to.notificationList.isEmpty?EmptyWidget( text:"Notification List is Empty!!" ,)
                  : Column(
                spacing: 8.h,
                children: List.generate(
                  NotificationController.to.notificationList.length,
                      (index) => NotificationCardItem(
                    notificationModel:
                    NotificationController.to.notificationList[index],
                  ),
                ),
              );
            }),
          ),)],
        ),
      ),
    );
  }
}
