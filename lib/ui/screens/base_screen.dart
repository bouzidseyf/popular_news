import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/screens/settings_screen/settings_presenter.dart';
import 'package:clean_news_ai/ui/screens/settings_screen/settings_screen.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_screen.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'favorites/favorites_presenter.dart';
import 'favorites/favorites_screen.dart';

class BaseScreen extends StatefulWidget {
  final int initialIndex;
  BaseScreen({Key key, this.initialIndex}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState(initialIndex);
}

class _BaseScreenState extends State<BaseScreen> with TickerProviderStateMixin {
  TabController _controller;
  final int initialIndex;

  _BaseScreenState(this.initialIndex);

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          NewsGradient(),
          TabBarView(controller: _controller, children: <Widget>[
            PresenterProvider<Store<AppState>, TopNewsPresenter>(
              key: ValueKey('topNewsPresenter'),
              child: TopNewsScreen(PageStorageKey('news')),
              presenter: TopNewsPresenter(),
            ),
            PresenterProvider<Store<AppState>, FavoritesPresenter>(
              key: ValueKey('favoritesPresenter'),
              child: FavoritesScreen(PageStorageKey('favorites')),
              presenter: FavoritesPresenter(),
            ),
            PresenterProvider<Store<AppState>, SettingsPresenter>(
              key: ValueKey('settingsPresenter'),
              child: SettingsScreen(PageStorageKey('settings')),
              presenter: SettingsPresenter(),
            ),
          ]),
          NavigationAppBar(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
