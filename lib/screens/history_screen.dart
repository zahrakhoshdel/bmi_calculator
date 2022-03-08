// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

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
        future: getResultData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<String> resultList = snapshot.data ?? [];
            return resultList.isEmpty
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
                    itemCount: resultList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (BuildContext context, int i) {
                      String result = resultList[i];
                      var resultItems = jsonDecode(result);

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
                          tileColor: Color(int.parse(resultItems['statusColor'],
                                  radix: 16))
                              .withOpacity(0.3),
                          title: Text(
                            resultItems['status'],
                          ),
                          subtitle: Text(resultItems['formattedDate']),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          leading: Text(
                            resultItems['bmi'],
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

  Future<List<String>> getResultData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saveList = prefs.getStringList('saveList') ?? [];

    return saveList;
  }

  void deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
