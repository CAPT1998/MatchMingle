import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant.dart';
import 'Recordingbutton.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatInputField extends StatefulWidget {
  final dynamic message;
  final void Function() press;
  final void Function(String) voicemessagecallback;
  final dynamic filePress;

  ChatInputField({
    Key? key,
    required this.message,
    required this.voicemessagecallback,
    required this.press,
    required this.filePress,
  }) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool emojiShowing = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0 / 2,
      ),
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: appColor.withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Container(
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 20.0 * 0.01,
                  // ),
                  decoration: BoxDecoration(
                    color: appColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return BottomSheet(
                                onClosing: () {},
                                enableDrag: false,
                                builder: ((context) {
                                  return SizedBox(
                                      height: 200,
                                      child: EmojiPicker(
                                        textEditingController: widget.message,
                                        //onBackspacePressed: _onBackspacePressed,
                                        config: Config(
                                          columns: 7,
                                          // Issue: https://github.com/flutter/flutter/issues/28894
                                          emojiSizeMax: 32 *
                                              (foundation.defaultTargetPlatform ==
                                                      TargetPlatform.iOS
                                                  ? 1.30
                                                  : 1.0),
                                          verticalSpacing: 0,
                                          horizontalSpacing: 0,
                                          gridPadding: EdgeInsets.zero,
                                          initCategory: Category.RECENT,
                                          bgColor: const Color(0xFFF2F2F2),
                                          indicatorColor: Colors.blue,
                                          iconColor: Colors.grey,
                                          iconColorSelected: Colors.blue,
                                          backspaceColor: Colors.blue,
                                          skinToneDialogBgColor: Colors.white,
                                          skinToneIndicatorColor: Colors.grey,
                                          enableSkinTones: true,
                                          recentTabBehavior:
                                              RecentTabBehavior.RECENT,
                                          recentsLimit: 28,
                                          replaceEmojiOnLimitExceed: false,
                                          noRecents: const Text(
                                            'No Recents',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black26),
                                            textAlign: TextAlign.center,
                                          ),
                                          loadingIndicator:
                                              const SizedBox.shrink(),
                                          tabIndicatorAnimDuration:
                                              kTabScrollDuration,
                                          categoryIcons: const CategoryIcons(),
                                          buttonMode: ButtonMode.MATERIAL,
                                          checkPlatformCompatibility: true,
                                        ),
                                      ));
                                }),
                              );
                            },
                          );
                        },
                        child: IconButton(
                          icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                          onPressed: null,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ),
                      SizedBox(width: 20.0 / 4),
                      Expanded(
                        child: TextField(
                          controller: widget.message,
                          decoration: InputDecoration(
                            hintText: "Type message",
                            hintStyle: TextStyle(
                                fontSize: 14, fontFamily: 'NotoEmoji'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: widget.filePress,
                        icon: Icon(
                          CupertinoIcons.folder,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ),
                      RecordButton(
                        recordingFinishedCallback: (String x) {
                          widget.voicemessagecallback(x);
                        },
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                  color: appColor.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: widget.press,
                  icon: Icon(Icons.send_sharp, color: appColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
