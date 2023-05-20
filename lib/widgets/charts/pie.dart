import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List ranking = [
    {'class': 'A', 'total': 23},
    {'class': 'B', 'total': 14},
    {'class': 'C', 'total': 8},
    {'class': 'D', 'total': 7},
    {'class': 'E', 'total': 21},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('D\'Chart')),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Bar Chart'),
              tileColor: Colors.green[200],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartBar(
                  data: [
                    {
                      'id': 'Bar',
                      'data': [
                        {'domain': '2020', 'measure': 3},
                        {'domain': '2021', 'measure': 4},
                        {'domain': '2022', 'measure': 6},
                        {'domain': '2023', 'measure': 0.3},
                      ],
                    },
                  ],
                  domainLabelPaddingToAxisLine: 16,
                  axisLineTick: 2,
                  axisLinePointTick: 2,
                  axisLinePointWidth: 10,
                  axisLineColor: Colors.green,
                  measureLabelPaddingToAxisLine: 16,
                  barColor: (barData, index, id) => Colors.green,
                  showBarValue: true,
                ),
              ),
            ),
        ])

//          
      ),
    );
  }
}
