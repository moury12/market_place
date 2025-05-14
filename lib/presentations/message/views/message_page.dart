import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/message/controllers/message_controller.dart';

import '../../../core/constants/padding_constant.dart';
import '../widgets/message_card_item_widget.dart';

class MessageListPage extends StatelessWidget {
  static const String routeName = '/message';

  const MessageListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding12,
        child: Obx(() {
          return  Column(
            spacing: 12.h,
            children: List.generate(
              MessageController.to.conversationList.length,
                  (index) =>
                  MessageCardItemWidget(conversation: MessageController.to
                      .conversationList[index],),
            ),
          );
        }),
      ),
    );
  }
}
