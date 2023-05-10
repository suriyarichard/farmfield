import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScatterChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScatterChartPageState();
}

class _ScatterChartPageState extends State {
  // int touchedIndex;
  Color greyColor = Colors.grey;
  List<int> selectedSpots = [];
  int lastPanStartOnIndex = -1;
  // double _height;
  // double _width;
  @override
  Widget build(BuildContext context) {
    // _width = MediaQuery.of(context).size.width;
    // _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scatter Chart Demo'),
      ),
      body: Container(
        //alignment:Alignment.center,
        // height:
        // width: _width,
        margin: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
        child: Card(
          color: Colors.black54,
          child: ScatterChart(
            ScatterChartData(
              scatterSpots: [
                ScatterSpot(
                  4,
                  5,
                  color: selectedSpots.contains(2)
                      ? Colors.purpleAccent
                      : greyColor,
                  radius: 8,
                ),
                ScatterSpot(
                  8,
                  6,
                  color: selectedSpots.contains(3) ? Colors.orange : greyColor,
                  radius: 20,
                ),
                ScatterSpot(
                  5,
                  7,
                  color: selectedSpots.contains(4) ? Colors.brown : greyColor,
                  radius: 14,
                ),
                ScatterSpot(
                  7,
                  2,
                  color: selectedSpots.contains(5)
                      ? Colors.lightGreenAccent
                      : greyColor,
                  radius: 18,
                ),
                ScatterSpot(
                  3,
                  2,
                  color: selectedSpots.contains(6) ? Colors.red : greyColor,
                  radius: 36,
                ),
              ],
              minX: 0,
              maxX: 10,
              minY: 0,
              maxY: 10,
              borderData: FlBorderData(
                show: false,
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                checkToShowHorizontalLine: (value) => true,
                getDrawingHorizontalLine: (value) =>
                    FlLine(color: Colors.white.withOpacity(0.1)),
                drawVerticalLine: true,
                checkToShowVerticalLine: (value) => true,
                getDrawingVerticalLine: (value) =>
                    FlLine(color: Colors.white.withOpacity(0.1)),
              ),
              titlesData: FlTitlesData(
                show: false,
              ),
              showingTooltipIndicators: selectedSpots,
              scatterTouchData: ScatterTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchTooltipData: ScatterTouchTooltipData(
                  tooltipBgColor: Colors.black,
                ),
                // touchCallback: (ScatterTouchResponse touchResponse) {
                //   if (touchResponse.touchInput is FlPanStart) {
                //     lastPanStartOnIndex = touchResponse.
                //     touchedSpotIndex;
                //   } else if (touchResponse.touchInput is FlPanEnd) {
                //     final FlPanEnd flPanEnd =
                //         touchResponse.touchInput;
                //     if (flPanEnd.velocity.pixelsPerSecond <=
                //         const Offset(4, 4)) {
                //       // Tap happened
                //       setState(() {
                //         if (selectedSpots.contains
                //           (lastPanStartOnIndex)) {
                //           selectedSpots.remove(lastPanStartOnIndex);
                //         } else {
                //           selectedSpots.add(lastPanStartOnIndex);
                //         }
                //       });
                //     }
                //   }
                // },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
