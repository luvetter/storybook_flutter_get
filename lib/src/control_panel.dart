import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ControlPanel extends StatelessWidget {
  ControlPanel({
    Key? key,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  final Axis direction;

  final RxBool active = true.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHorizontal = direction == Axis.horizontal;

    final border = Border(
      left: isHorizontal ? BorderSide(color: theme.dividerColor) : BorderSide.none,
      top: isHorizontal ? BorderSide.none : BorderSide(color: theme.dividerColor),
    );

    return Obx(() {
      final panelSize = active.value ? _contentSize + _iconPanelSize : _iconPanelSize;
      return AnimatedContainer(
        key: ValueKey(direction),
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 250),
        width: isHorizontal ? panelSize : null,
        height: isHorizontal ? null : panelSize,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: isHorizontal ? null : 0,
              top: 0,
              bottom: isHorizontal ? 0 : null,
              child: SizedBox(
                width: isHorizontal ? _contentSize : null,
                height: isHorizontal ? null : _contentSize,
                child: !active.value
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                          border: border,
                          color: theme.cardColor,
                        ),
                        child: const KnobPanel(),
                      ),
              ),
            ),
            Align(
              alignment: isHorizontal ? Alignment.centerRight : Alignment.bottomCenter,
              child: Material(
                color: theme.cardColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(border: border),
                  width: isHorizontal ? _iconPanelSize : double.maxFinite,
                  height: isHorizontal ? null : _iconPanelSize,
                  child: Flex(
                    direction: isHorizontal ? Axis.vertical : Axis.horizontal,
                    children: [
                      IconButton(
                        icon: Icon(Icons.settings, color: active.value ? theme.colorScheme.secondary : null),
                        onPressed: () => active.value = !active.value,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

const double _iconPanelSize = 60;
const double _contentSize = 200;
