import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_get/storybook_flutter_get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetStorybook(
      storyWrapperBuilder: (context, story, child) => Container(
        padding: story.padding,
        color: Theme.of(context).canvasColor,
        child: Center(child: child),
      ),
      children: [
        Story(
          section: '',
          name: 'Get-Dialog',
          builder: (_, k) => MaterialButton(
            onPressed: () => Get.defaultDialog(),
            child: Text(k.text(label: 'Text', initial: 'Flat button')),
          ),
        ),
        Story(
          name: 'Get-Dialog 2',
          builder: (_, k) => MaterialButton(
            onPressed: () => Get.defaultDialog(),
            child: Text(k.text(label: 'Text', initial: 'Flat button 2')),
          ),
        ),
      ],
    );
  }
}
