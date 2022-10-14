import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_nft_marketplace/detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  String strDigits(int n) => n.toString().padLeft(2, '0');

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
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  List<String> listImage = [
    'assets/image/img_1.jpeg',
    'assets/image/img_2.jpeg',
    'assets/image/img_3.jpeg',
  ];

  List<CreatorProduct> listCreatorProduct = const [
    CreatorProduct(
        imagePath: 'assets/image/img_1.jpeg',
        creatorName: 'Bryan Wan',
        creatorImage: 'assets/image/img_creator_4.png',
        productName: 'Lady Cyborg #009',
        productPrice: '2.90 ETH',
        status: 'Highest bid'),
    CreatorProduct(
        imagePath: 'assets/image/img_2.jpeg',
        creatorName: 'Bryan Wan',
        creatorImage: 'assets/image/img_creator_4.png',
        productName: 'Lady Masked #007',
        productPrice: '2.70 ETH',
        status: 'Highest bid'),
    CreatorProduct(
        imagePath: 'assets/image/img_3.jpeg',
        creatorName: 'Bryan Wan',
        creatorImage: 'assets/image/img_creator_4.png',
        productName: 'Yellow Cyborg #003',
        productPrice: '2.98 ETH',
        status: 'Highest bid'),
  ];

  List<Creator> listCreator = [
    const Creator(
      imagePath: 'assets/image/img_creator_1.png',
      creatorName: '1Cyborg',
      revenue: '\$3.350.100',
    ),
    const Creator(
      imagePath: 'assets/image/img_creator_2.png',
      creatorName: 'B0ldMan',
      revenue: '\$935.200',
    ),
    const Creator(
      imagePath: 'assets/image/img_creator_3.png',
      creatorName: 'GGaming',
      revenue: '\$2.100.250',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildTopBar(),
        backgroundColor: const Color(0xFF161616),
        elevation: 0.0,
      ),
      body: _buildMainBody(),
    );
  }

  Widget _buildMainBody() {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Live Bids',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'See More',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF848484),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            _buildSlider(),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Creator',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'See More',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF848484),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            _buildListTopCreator(),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search Form
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: TextFormField(
                cursorColor: const Color(0xFFFFFFFF),
                style: const TextStyle(
                  color: Color(0xFF7F7F7F),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Search NFT',
                  contentPadding: EdgeInsets.zero,
                  hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  prefixIcon: Image.asset(
                    'assets/icon/ic_search.png',
                    scale: 3.5 / 1,
                  ),
                  suffixIcon: Image.asset(
                    'assets/icon/ic_mic.png',
                    scale: 3.5 / 1,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF262626))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF262626))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFF262626))),
                  filled: true,
                  fillColor: const Color(0xFF262626),
                  focusColor: const Color(0xFF262626),
                  hoverColor: const Color(0xFF262626),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          // notification form
          Container(
            width: 48.0,
            height: 48.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Color(0xFF262626),
            ),
            child: Center(
              child: Image.asset(
                'assets/icon/ic_notification.png',
                scale: 3.5 / 1,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1.2,
      height: MediaQuery.of(context).size.height * 0.55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listCreatorProduct.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      creator: listCreatorProduct[index],
                    ),
                  ),
                );
              },
              child: _buildItemCard(creatorProduct: listCreatorProduct[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemCard({CreatorProduct? creatorProduct}) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              creatorProduct?.imagePath ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          right: 20,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItemTime(),
                _buildCreatorContainer(creatorProduct: creatorProduct),
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

  Widget _buildCreatorContainer({CreatorProduct? creatorProduct}) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
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
            color: Colors.white.withOpacity(0.3),
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
              //profile creator
              SizedBox(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Image.asset(
                          creatorProduct!.creatorImage,
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
                            creatorProduct.productName,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  'By ${creatorProduct.creatorName}',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
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
              SizedBox(
                height: 60.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icon/ic_ethereum.png',
                            scale: 4 / 1,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            creatorProduct.productPrice,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      creatorProduct.status,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFEAEAEA),
                        ),
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

  Widget _buildListTopCreator() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1.2,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listCreator.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildTopCreator(creator: listCreator[index]),
          );
        },
      ),
    );
  }

  Widget _buildTopCreator({Creator? creator}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    child: Image.asset(
                      creator?.imagePath ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9D545),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: const Color(0xFF161616),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        size: 12.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              creator?.creatorName ?? '-',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              creator?.revenue ?? '-',
              style: GoogleFonts.poppins(
                color: const Color(0xFF7F7F7F),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Creator {
  final String imagePath;
  final String creatorName;
  final String revenue;

  const Creator({
    required this.imagePath,
    required this.creatorName,
    required this.revenue,
  });
}

class CreatorProduct {
  final String imagePath;
  final String creatorName;
  final String creatorImage;
  final String productName;
  final String productPrice;
  final String status;

  const CreatorProduct({
    required this.imagePath,
    required this.creatorName,
    required this.creatorImage,
    required this.productName,
    required this.productPrice,
    required this.status,
  });
}
