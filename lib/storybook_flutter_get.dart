library storybook_flutter_get;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_get/src/story_page_wrapper.dart';

class GetStorybook extends StatelessWidget {
  GetStorybook({
    Key? key,
    this.children = const [],
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.localizationDelegates,
    this.storyWrapperBuilder,
    Iterable<Plugin>? plugins,
    this.initialRoute = '/',
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
  })  : plugins = plugins ?? allPlugins,
        super(key: key);

  /// Theme override for the light theme.
  final ThemeData? theme;

  /// Theme override for the dark theme.
  final ThemeData? darkTheme;

  /// Indicates theme mode to use: light, dark or system.
  final ThemeMode themeMode;

  /// Stories in the storybook.
  final List<Story> children;

  /// Localizations Delegates override
  final List<LocalizationsDelegate>? localizationDelegates;

  /// Optional list of plugins.
  final Iterable<Plugin> plugins;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver> navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.builder}
  ///
  /// Material specific features such as [showDialog] and [showMenu], and widgets
  /// such as [Tooltip], [PopupMenuButton], also require a [Navigator] to properly
  /// function.
  final TransitionBuilder? builder;

  /// Optional parameter to override story wrapper.
  ///
  /// {@macro storybook_flutter.default_story_wrapper}
  ///
  /// You can also override individual story wrapper by using
  /// [Story.wrapperBuilder].
  final StoryWrapperBuilder? storyWrapperBuilder;

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return CustomStorybook(
      storyWrapperBuilder: storyWrapperBuilder,
      children: children,
      builder: (c) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: theme ?? ThemeData(brightness: Brightness.light),
        darkTheme: darkTheme ?? ThemeData(brightness: Brightness.dark),
        localizationsDelegates: localizationDelegates,
        initialRoute: initialRoute,
        getPages: children
            .map((story) => GetPage(
                  name: '/${story.path}',
                  page: () => StoryPageWrapper(),
                  transitionDuration: Duration.zero,
                ))
            .toList(),
        unknownRoute: GetPage(name: '/', page: () => StoryPageWrapper()),
        builder: builder,
        navigatorObservers: navigatorObservers,
      ),
    );
  }
}
