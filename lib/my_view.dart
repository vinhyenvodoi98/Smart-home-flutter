import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_world/appliance_box.dart';

class MyView extends StatefulWidget {
  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  List<ApplianceBox> items = [
    ApplianceBox(title: "Bedroom", boxInfo: "2 Devices"),
    ApplianceBox(
      title: "LivingRoom",
      boxInfo: "7 Devices",
      image: SvgPicture.asset('assets/sofa.svg'),
    ),
    ApplianceBox(
      title: "Kitchen",
      boxInfo: "5 Devices",
      image: SvgPicture.asset("assets/fridge.svg"),
    ),
    ApplianceBox(title: "Bedroom", boxInfo: "2 Devices"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 20, 18, 20),
      child: StaggeredGridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: items,
        staggeredTiles: [
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 220),
          StaggeredTile.extent(1, 220),
          StaggeredTile.extent(1, 150)
        ],
      ),
    );
  }
}
