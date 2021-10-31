import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_get/src/control_panel.dart';
import 'package:storybook_flutter_get/src/get_contents.dart';

class StoryPageWrapper extends StatelessWidget with GetResponsiveMixin {
  StoryPageWrapper({
    Key? key,
    this.story,
    ResponsiveScreenSettings settings = const ResponsiveScreenSettings(tabletChangePoint: 800),
  })  : screen = ResponsiveScreen(settings),
        super(key: key);

  final Story? story;
  @override
  final ResponsiveScreen screen;

  @override
  Widget? desktop() {
    return _buildScaffold(false);
  }

  @override
  Widget? tablet() {
    return _buildScaffold(true);
  }

  @override
  bool get alwaysUseBuilder => false;

  Widget _buildScaffold(bool isMobile) {
    var theme = Theme.of(screen.context);
    final direction = isMobile ? Axis.vertical : Axis.horizontal;
    return Scaffold(
      drawer: isMobile ? Drawer(child: GetContents()) : null,
      appBar: AppBar(title: Text(story?.name ?? 'Storybook')),
      body: Flex(
        direction: direction,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (!isMobile)
            Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: theme.dividerColor)),
                color: theme.cardColor,
              ),
              width: 200,
              child: GetContents(),
            ),
          const Expanded(child: CurrentStory()),
          ControlPanel(direction: direction),
        ],
      ),
    );
  }
}
