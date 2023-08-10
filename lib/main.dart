import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var carApi =
        DefaultAssetBundle.of(context).loadString('assets/api/my_api.json');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: FutureBuilder(
            future: carApi,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Data not found');
              }
              var cars = jsonDecode(snapshot.data.toString());
              // debugPrint(cars.toString());
              // debugPrint((cars['cars'] is List).toString());
              List carList = cars['cars'];
              // debugPrint(carList.toString());
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  thickness: 3,
                ),
                itemCount: carList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(cars['cars'][index]['brand']),
                    subtitle: Text(carList[index]['year']),
                    trailing: Text(carList[index]['price'].toString()),
                  );
                },
              );
            },
          )),
    );
  }
}
