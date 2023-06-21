import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  ScaffoldWithNavBarTabItem(
      {this.initialLocation = "/", required Widget icon, String? label})
      : super(icon: icon, label: label);

  String initialLocation;
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> with AutomaticKeepAliveClientMixin  {
  late int _currentIndex = _locationToTabIndex(GoRouter.of(context).location);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ScaffoldWithNavBarTabItem> tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: "/camera",
      icon: const Icon(Icons.camera_alt),
      label: "CAMERA",
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: "/gallery",
      icon: const Icon(Icons.photo_album),
      label: "GALLERY",
    ),
  ];

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    HapticFeedback.heavyImpact();
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].initialLocation);
      setState(() {
        _currentIndex = tabIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        items: tabs,
        onTap: (index) => _onItemTapped(context, index),
        backgroundColor: Theme.of(context).colorScheme.background,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedFontSize: 10,
        unselectedItemColor: Theme.of(context).colorScheme.tertiary,
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}