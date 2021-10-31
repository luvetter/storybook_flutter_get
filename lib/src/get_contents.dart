import 'package:get/get.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class GetContents extends Contents {
  GetContents() : super(onStorySelected: (s) => Get.offNamed(s.path, preventDuplicates: false));
}
