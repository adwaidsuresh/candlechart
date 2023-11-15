import 'dart:async';
import 'dart:math';
import 'package:candlechart/modelclass/model_Class.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Candlestick extends StatefulWidget {
  const Candlestick({super.key});

  @override
  State<Candlestick> createState() => _CandlestickState();
}

class _CandlestickState extends State<Candlestick> {
  List<Details> data = [];
  late Timer time;
  Random random = Random();
  DateTime currentMinute = DateTime.now().subtract(
    const Duration(seconds: 1),
  );

  @override
  void initState() {
    super.initState();
    startDataGeneration();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  void startDataGeneration() {
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        generateData();
      });
    });
  }

  void generateData() {
    DateTime now = DateTime.now();

    if (now.difference(currentMinute) >= const Duration(minutes: 1)) {
      currentMinute = now;

      data.clear();
    }

    double open = random.nextDouble() * 05.0 + 50.0;
    double close = open + (random.nextBool() ? 1.0 : -1.0);
    double high = open + 0.5;
    double low = open - 0.5;
    double lineValue = random.nextDouble() * 05.0 + 40.0;

    Details newCandle = Details(
        x: now,
        open: open,
        high: high,
        low: low,
        close: close,
        color: close > open ? Colors.red : Colors.green,
        linevalue: lineValue);

    data.add(newCandle);
    if (data.length > 40) {
      data.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'CANDLESTICK',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SfCartesianChart(
          primaryYAxis: NumericAxis(
            majorTickLines: const MajorTickLines(size: 0),
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryXAxis: DateTimeAxis(
            majorTickLines: const MajorTickLines(size: 0),
            majorGridLines: const MajorGridLines(width: 0),
          ),
          series: <ChartSeries>[
            CandleSeries<Details, DateTime>(
              dataSource: data,
              xValueMapper: (Details data, _) => data.x,
              lowValueMapper: (Details data, _) => data.low,
              highValueMapper: (Details data, _) => data.high,
              openValueMapper: (Details data, _) => data.open,
              closeValueMapper: (Details data, _) => data.close,
              bearColor: Colors.green,
              bullColor: Colors.red,
            ),
            LineSeries<Details, DateTime>(
              dataSource: data,
              xValueMapper: (Details data, _) => data.x,
              yValueMapper: (Details data, _) => data.linevalue,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
