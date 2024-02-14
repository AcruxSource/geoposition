/* ----------------------- Packete ---------------------- */
import 'package:flutter/material.dart';

/* ---------------------- TopBanner --------------------- */
class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /* --------------------- Background --------------------- */
        Container(
          height: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/gpsmap.webp'),
                  fit: BoxFit.cover)),
        )
      ],
    );
  }
}
