/* ----------------------- Packege ---------------------- */
import 'package:flutter/material.dart';

/* ----------------------- Library ---------------------- */
import 'core/toolbar.core.dart';
import '../widgets/banner.widget.dart';

/* ----------------- Class PositionData ----------------- */
class PositionData extends StatefulWidget {
  const PositionData({super.key});

  @override
  State<PositionData> createState() => PositionDataState();
}
/* ****************************************************** */

class PositionDataState extends State<PositionData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBody: true,
      body: const Column(
        children: [TopBanner()],
      ),
    );
  }
}
