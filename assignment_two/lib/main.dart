// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js_util';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'database/database.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Assignment Two',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF222222)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> itemCounts = [];
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    itemCounts = List.generate(postsManage.length, (index) => 1);
    _calculateTotalAmount();
  }

  void _calculateTotalAmount() {
    totalAmount = 0;
    for (int i = 0; i < postsManage.length; i++) {
      totalAmount += multiply(itemCounts[i], postsManage[i]['price']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                )
              ],
            ),
            const Text(
              'My Bag',
              style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 35,
                  fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: postsManage.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> currentItem = postsManage[index];
                  int count = itemCounts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: double.infinity,
                      height: 104,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 25,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              child: Image.asset(
                                currentItem['image'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentItem['title'],
                                style: const TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Color: ",
                                    style: TextStyle(
                                        fontFamily: 'Metropolis',
                                        color: Color(0xFF9B9B9B),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    currentItem['color'],
                                    style: const TextStyle(
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Size: ",
                                    style: TextStyle(
                                        fontFamily: 'Metropolis',
                                        color: Color(0xFF9B9B9B),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    currentItem['size'],
                                    style: const TextStyle(
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (itemCounts[index] > 1) {
                                        setState(() {
                                          itemCounts[index]--;
                                          _calculateTotalAmount();
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Color(0xFF9B9B9B),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    count.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        itemCounts[index]++;
                                        _calculateTotalAmount();
                                      });
                                      if (itemCounts[index] == 5) {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: const Text(
                                                "Congratulations!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Metropolis',
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              content: SingleChildScrollView(
                                                child: SizedBox(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'You have added ',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Metropolis',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w100,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const Text('5',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                      Text(
                                                          '${currentItem['title']} on your bag!',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                SizedBox(
                                                  height: 50,
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 4.0,
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFdb3022),
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    child: const Text(
                                                      'OKAY',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Metropolis',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Color(0xFF9B9B9B),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Color(0xFF9B9B9B),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${itemCounts[index] * currentItem['price']}\$",
                                style: const TextStyle(
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                const Text(
                  "Total amount:",
                  style: TextStyle(
                      fontFamily: 'Metropolis',
                      color: Color(0xFF9B9B9B),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                const Spacer(),
                Text(
                  "${totalAmount.toString()}\$",
                  style: const TextStyle(
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Congratulation!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                    backgroundColor: const Color(0xFFdb3022),
                    foregroundColor: Colors.white),
                child: const Text(
                  'CHECK OUT',
                  style: TextStyle(fontFamily: 'Metropolis', fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
