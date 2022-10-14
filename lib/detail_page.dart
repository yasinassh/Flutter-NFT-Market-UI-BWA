import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_nft_marketplace/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final CreatorProduct creator;
  const DetailPage({Key? key, required this.creator}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  String strDigits(int n) => n.toString().padLeft(2, '0');

  late TabController _tabController;

  List<CreatorBidHistory> listCreatorBidHistory = [
    CreatorBidHistory(
      creatorName: '1Cyborg',
      imgCreator: 'assets/image/img_creator_1.png',
      bidPrice: '2.50 ETH',
      lastBid: '9 min',
    ),
    CreatorBidHistory(
      creatorName: 'B0ldman',
      imgCreator: 'assets/image/img_creator_2.png',
      bidPrice: '2 ETH',
      lastBid: '2 hour',
    ),
    CreatorBidHistory(
      creatorName: 'GGaming',
      imgCreator: 'assets/image/img_creator_3.png',
      bidPrice: '2.30 ETH',
      lastBid: '1 hour',
    ),
  ];

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setCountDown(),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF161616),
        elevation: 0.0,
        title: _buildTopBar(),
      ),
      body: SingleChildScrollView(child: _buildMainBody()),
    );
  }

  Widget _buildTopBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 58.0,
              height: 58.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: Color(0xFF262626),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/ic_arrow_back.png',
                  scale: 4 / 1,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'NFT Details',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMainBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _buildItemCard(creator: widget.creator),
          const SizedBox(height: 16.0),
          _buildCreatorDetail(),
          const SizedBox(height: 16.0),
          _buildTabBar(),
          const SizedBox(height: 16.0),
          _buildTabBarView(),
          const Spacer(),
          _buildButtonBid(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildItemCard({CreatorProduct? creator}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.asset(
                creator?.imagePath ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          right: 20,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItemTime(),
                _buildPriceContainer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //make glassmorphism
  Widget _buildItemTime() {
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 40.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.6),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              style: BorderStyle.solid,
            ),
            color: Colors.white.withOpacity(0.2),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color(0xFFFD044F),
                  ),
                  child: Center(
                    child: Text(
                      '● Live',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(
                  Icons.schedule,
                  color: Colors.white,
                  size: 16.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${hours}h:${minutes}m:${seconds}s',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 9,
          sigmaY: 9,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          width: MediaQuery.of(context).size.width,
          height: 60.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.6),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //price NFT
              SizedBox(
                height: 60.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icon/ic_ethereum.png',
                            scale: 3 / 1,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            widget.creator.productPrice,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.creator.status,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFEAEAEA),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // likes
              Container(
                width: 68.0,
                height: 32.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon/ic_love.png',
                      scale: 4 / 1,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '29K',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF161616),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorDetail() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //profile creator
            SizedBox(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(21.0),
                      ),
                      child: Image.asset(
                        widget.creator.creatorImage,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    height: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.creator.productName,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                'Owned By ${widget.creator.creatorName}',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFEAEAEA),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Image.asset(
                                'assets/icon/ic_veryfied.png',
                                scale: 4 / 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //follow button
            Container(
              width: 78.0,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38.0),
                color: const Color(0xFF1D1D1D),
              ),
              child: Center(
                child: Text(
                  'Follow',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 46.0,
        decoration: BoxDecoration(
          color: const Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TabBar(
          controller: _tabController,
          // give the indicator a decoration (color and border radius)
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xFF2B2D20),
          ),
          padding: const EdgeInsets.all(4.0),
          labelColor: Colors.white,
          labelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFE8FB7A),
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF7F7F7F),
          ),
          tabs: const [
            // first tab [you can add an icon using the icon property]
            Tab(
              text: 'NFT Details',
            ),

            // second tab [you can add an icon using the icon property]
            Tab(
              text: 'Bid History',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildTabBidHistory(),
          _buildTabBidHistory(),
        ],
      ),
    );
  }

  Widget _buildTabBidHistory() {
    return SizedBox(
      child: ListView.builder(
        itemCount: listCreatorBidHistory.length,
        itemBuilder: (context, index) {
          return _buildItemBidHistory(creator: listCreatorBidHistory[index]);
        },
      ),
    );
  }

  Widget _buildItemBidHistory({CreatorBidHistory? creator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 21,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(21.0),
                        ),
                        child: Image.asset(
                          creator!.imgCreator,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    SizedBox(
                      height: 60.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creator.creatorName,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Bid ${creator.lastBid} ago',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF848484),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon/ic_ethereum.png',
                    scale: 3 / 1,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    creator.bidPrice,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBid() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      // height: 44,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: const Color(0xFFE8FB7A),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/ic_live_bids_innactive.png',
            color: const Color(0xFF161616),
            scale: 4 / 1,
          ),
          const SizedBox(width: 2.0),
          Text(
            'Place a bid',
            style: GoogleFonts.poppins(
              color: const Color(0xFF161616),
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

class CreatorBidHistory {
  final String creatorName;
  final String imgCreator;
  final String lastBid;
  final String bidPrice;

  CreatorBidHistory({
    required this.creatorName,
    required this.imgCreator,
    required this.bidPrice,
    required this.lastBid,
  });
}
