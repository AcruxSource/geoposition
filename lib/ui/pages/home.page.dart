import 'package:flutter/material.dart';
import 'package:geoposition/ui/controllers/network.controller.dart';
import 'package:geoposition/ui/pages/map.page.dart';
import 'package:get/get.dart';
import '../../database/model/myposition.model.dart';
import '../../ui/widgets/principalcard.widget.dart';
import '../../database/domain/myposition.controller.dart';
import '../controllers/geo.controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  MyPositionController posctrl = Get.find();
  GeoController geoCtl = Get.find();
  NetworkController netctl = Get.find();

  String statusRed() {
    if (netctl.connection == true) return 'OnLine';
    return 'OffLine';
  }

  Widget _displayInfo(MyPosition pos, int index) {
    return Stack(
      children: [
        Card(
          color: const Color.fromARGB(197, 255, 22, 5),
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  pos.date,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pos.time,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'LAT: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pos.latitude.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          ' / LONG: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          pos.longitude.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                leading: const Icon(
                  Icons.add_location,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 5,
          child: TextButton(
            onPressed: () {
              posctrl.deletePosition(pos, index);
            },
            child: const Icon(
              Icons.delete,
              color: Color.fromARGB(166, 0, 0, 0),
              size: 26,
            ),
          ),
        )
      ],
    );
  }

  Widget _listinfo() {
    return GetX<MyPositionController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: posctrl.positions.length,
          itemBuilder: (context, index) {
            var pos = controller.positions[index];
            return GestureDetector(
              child: _displayInfo(pos, index),
              onTap: () {
                Navigator.pop(context);

                Get.to(() => MapGoogle(index));
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(216, 20, 20, 20),
        toolbarHeight: 40,
        elevation: 0,
        title: const Text('GPS'),
        titleTextStyle: const TextStyle(fontSize: 25),
        actions: [
          const Icon(
            Icons.online_prediction,
            size: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              const Text("Estado de la red"),
              const Spacer(),
              Obx(() => Text(
                    statusRed(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ))
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const PrincipalCard(),
          ),
          const Divider(
            color: Color.fromARGB(223, 0, 0, 0),
            height: 10,
            thickness: 1,
            endIndent: 5,
            indent: 5,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: _listinfo(),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            backgroundColor: const Color.fromARGB(255, 228, 191, 82),
            onPressed: () {
              geoCtl.opensettings();
            },
            label: const Text(
              'Permisos',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            icon: const Icon(
              Icons.settings_accessibility,
              color: Color.fromARGB(134, 0, 0, 0),
              size: 30,
            ),
          ),
          const SizedBox(
            width: 47,
          ),
          FloatingActionButton.extended(
              label: const Text(
                'Posicion',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 228, 191, 82),
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(134, 0, 0, 0),
                size: 30,
              ),
              onPressed: () async {
                await geoCtl.getPosition();
                posctrl.addPosition(
                  MyPosition(
                    geoCtl.date.value,
                    geoCtl.time.value,
                    geoCtl.latitude.value,
                    geoCtl.longitude.value,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
