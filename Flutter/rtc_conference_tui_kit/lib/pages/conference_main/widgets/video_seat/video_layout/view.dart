// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtc_conference_tui_kit/common/index.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class VideoLayoutWidget extends GetView<VideoLayoutController> {
  final List<UserModel> userList;
  final startIndex;
  final endIndex;
  final isScreenLayout;
  final isTwoUserLayout;
  const VideoLayoutWidget(
      {Key? key,
      required this.userList,
      required this.startIndex,
      required this.endIndex,
      this.isScreenLayout = false,
      this.isTwoUserLayout = false})
      : super(key: key);

  Widget _buildView() {
    if (isScreenLayout) {
      return VideoItemWidget(
        isScreenStream: true,
        userModel: RoomStore.to.screenShareUser,
      );
    } else if (isTwoUserLayout) {
      return Obx(
        () => WithDraggableWindowWidget(
          mainWidget: VideoItemWidget(
            userModel: userList[0],
          ),
          draggableWidget: userList.length == 2
              ? VideoItemWidget(
                  userModel: userList[1],
                )
              : null,
          draggableWidgetHeight:
              (userList.length == 2 && userList[1].hasVideoStream.value)
                  ? 180.0
                  : 100.0,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(7.0.scale375()),
        child: Wrap(
          spacing: 7.0.scale375(),
          runSpacing: 7.0.scale375(),
          alignment: controller.getWrapAlignment(userList),
          runAlignment: controller.getWrapAlignment(userList),
          children: List.generate(
            endIndex - startIndex + 1,
            (index) {
              return VideoItemWidget(
                width: 176.0.scale375(),
                height: 176.0.scale375(),
                userModel: userList[startIndex + index],
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoLayoutController>(
      init: VideoLayoutController(),
      autoRemove: false,
      id: "video_layout",
      builder: (_) {
        return _buildView();
      },
    );
  }
}
