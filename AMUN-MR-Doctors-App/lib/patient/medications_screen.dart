import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../drawer/main_drawer.dart';

class MedicationsScreen extends StatefulWidget {
  static final routeName = 'Medication route';

  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  List<String> medications;
  @override
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    setState(() {
      if (routeArgs != null) {
        medications = routeArgs['medications'];
        medications = medications.reversed.toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Medications'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: medications == null
            ? Center(
                child: Text("No Medications Add"),
              )
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.05,
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
                children: List.generate(
                  medications.length,
                  (index) {
                    return buildItem(medications[index]);
                  },
                ),
              ),
      ),
    );
  }

  Widget buildItem(String medication) {
    return Container(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(.7),
                    Theme.of(context).primaryColor
                  ], //here you can change the color
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Medication: ',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Divider(
                        color: Theme.of(context).accentColor,
                        thickness: 0.6,
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '$medication',
                            maxLines: 5,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
