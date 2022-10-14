import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nft_marketplace/explore_page.dart';
import 'package:flutter_nft_marketplace/home_page.dart';
import 'package:flutter_nft_marketplace/live_bids_page.dart';
import 'package:flutter_nft_marketplace/profile_page.dart';
import 'package:flutter_nft_marketplace/wallet_page.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  int _selectedNavbar = 0;

  late int currentPage;
  late TabController tabController;

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  final _pageSelection = const [
    HomePage(),
    ExplorePage(),
    WalletPage(),
    LiveBidsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != _selectedNavbar && mounted) {
          _changeSelectedNavbar(value);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _pageSelection[_selectedNavbar],
      body: FrostedBottomBar(
        width: MediaQuery.of(context).size.width * 0.98,
        opacity: 0.6,
        sigmaX: 15,
        sigmaY: 15,
        bottom: 20,
        child: TabBar(
          controller: tabController,
          indicator: const BoxDecoration(),
          indicatorWeight: 0.0,
          indicatorColor: Colors.transparent,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          isScrollable: false,
          tabs: [
            TabsIcon(
              icon: _selectedNavbar == 0
                  ? Image.asset('assets/icon/ic_home_active.png', scale: 4 / 1)
                  : Image.asset('assets/icon/ic_home_innactive.png',
                      scale: 4 / 1),
              color: _selectedNavbar == 0
                  ? const Color(0xFFE8FB7A)
                  : const Color(0xFF848484),
              tabName: 'Home',
            ),
            TabsIcon(
              icon: _selectedNavbar == 1
                  ? Image.asset('assets/icon/ic_explore_active.png',
                      scale: 4 / 1)
                  : Image.asset('assets/icon/ic_explore_innactive.png',
                      scale: 4 / 1),
              color: _selectedNavbar == 1
                  ? const Color(0xFFE8FB7A)
                  : const Color(0xFF848484),
              tabName: 'Explore',
            ),
            TabsIcon(
              icon: _selectedNavbar == 2
                  ? Image.asset('assets/icon/ic_wallet_active.png',
                      scale: 4 / 1)
                  : Image.asset('assets/icon/ic_wallet_innactive.png',
                      scale: 4 / 1),
              color: _selectedNavbar == 2
                  ? const Color(0xFFE8FB7A)
                  : const Color(0xFF848484),
              tabName: 'Wallet',
            ),
            TabsIcon(
              icon: _selectedNavbar == 3
                  ? Image.asset('assets/icon/ic_live_bids_active.png',
                      scale: 4 / 1)
                  : Image.asset('assets/icon/ic_live_bids_innactive.png',
                      scale: 4 / 1),
              color: _selectedNavbar == 3
                  ? const Color(0xFFE8FB7A)
                  : const Color(0xFF848484),
              tabName: 'Live Bids',
            ),
            TabsIcon(
              icon: CircleAvatar(
                radius: 12.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Image.asset(
                    'assets/image/img_user_profile.png',
                  ),
                ),
              ),
              color: _selectedNavbar == 4
                  ? const Color(0xFFE8FB7A)
                  : const Color(0xFF848484),
              tabName: 'Profile',
            ),
          ],
          // onTap: _changeSelectedNavbar,
        ),
        borderRadius: BorderRadius.circular(20.0),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: _pageSelection,
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final String tabName;
  final Widget icon;

  const TabsIcon({
    Key? key,
    this.color = Colors.white,
    this.height = 60,
    this.width = 100,
    this.tabName = '',
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              tabName,
              style: GoogleFonts.poppins(
                color: color,
                fontSize: 9.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
