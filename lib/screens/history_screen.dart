// ignore_for_file: non_constant_identifier_names

import 'package:bmi/constants.dart';
import 'package:bmi/screens/home_screen.dart';
import 'package:bmi/widget/base/base_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onButtonPressed: () {
        setState(() {
          deleteAll();
        });
      },
      buttonText: 'Clear All',
      childWidget: FutureBuilder(
        future: Future.wait([
          getBmiData(),
          getStatusData(),
          getStatusColorData(),
          getDateListData(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<String> bmiList = snapshot.data[0];
            List<String> statusList = snapshot.data[1];
            List<String> statusColorList = snapshot.data[2];
            List<String> dateList = snapshot.data[3];
            // print(snapshot.data[0]);
            // print(snapshot.data[1]);
            // print(snapshot.data[2]);
            // print(snapshot.data[3]);
            return bmiList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Empty!',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 20.0),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: NeumorphicButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomeScreen();
                              }));
                            },
                            style: NeumorphicStyle(
                              color: Colors.white,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: const Text('Home'),
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(15.0),
                    itemCount: bmiList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (BuildContext context, int i) {
                      return Card(
                        shadowColor: kBlueColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          tileColor:
                              Color(int.parse(statusColorList[i], radix: 16))
                                  .withOpacity(0.3),
                          title: Text(statusList[i]),
                          subtitle: Text(dateList[i]),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          leading: Text(
                            bmiList[i],
                            style: kNumberStyle,
                          ),
                        ),
                      );
                    });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List> getBmiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bmiList = prefs.getStringList('bmilist') ?? [];

    return bmiList;
  }

  Future<List> getStatusData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> statusList = prefs.getStringList('statuslist') ?? [];

    return statusList;
  }

  Future<List> getStatusColorData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> statusColorList = prefs.getStringList('statusColorlist') ?? [];

    return statusColorList;
  }

  Future<List> getDateListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> DateList = prefs.getStringList('DateList') ?? [];

    return DateList;
  }

  void deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
