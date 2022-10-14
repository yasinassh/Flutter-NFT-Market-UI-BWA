import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveBidsPage extends StatefulWidget {
  const LiveBidsPage({Key? key}) : super(key: key);

  @override
  State<LiveBidsPage> createState() => _LiveBidsPageState();
}

class _LiveBidsPageState extends State<LiveBidsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: _buildTopBar(),
        backgroundColor: const Color(0xFF161616),
        elevation: 0.0,
      ),
      body: Center(
        child: Text(
          'Live Bids Page',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
