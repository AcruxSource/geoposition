import 'package:flutter/widgets.dart';
import 'positioncard.widget.dart';
import 'speedcard.widgets.dart';

class PrincipalCard extends StatefulWidget {
  const PrincipalCard({super.key});

  @override
  State<PrincipalCard> createState() => PrincipalCardStatus();
}

class PrincipalCardStatus extends State<PrincipalCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/gpsmap.webp'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
        const Positioned(
          top: 160,
          child: SizedBox(
            width: 380,
            height: 70,
            child: CurrentPosition(),
          ),
        ),
        const Positioned(
          top: 10,
          left: 2,
          child: SizedBox(
            width: 220,
            height: 40,
            child: CurrentSpeed(),
          ),
        )
      ],
    );
  }
}
