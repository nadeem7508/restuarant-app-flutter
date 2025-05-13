
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class RevenueChart extends StatefulWidget {
  @override
  _RevenueChartState createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  String selectedPeriod = "Daily";
  List<String> periods = ["Daily", "Weekly","Monthly","Yearly"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
         border: Border.all(color: Colors.blue.shade300,width: 2),
         borderRadius: BorderRadius.circular(15),
          boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ], 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Revenue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedPeriod,dropdownColor: Colors.blue,
                  icon: Icon(Icons.arrow_drop_down,color: Color.fromARGB(255, 11, 77, 127),),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPeriod = newValue!;
                    });
                  },
                  items: periods.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
         padding:  EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "\$2,241",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
               
              ),
              padding: EdgeInsets.all(10),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, 1),
                        FlSpot(2, 2.5),
                        FlSpot(3, 1.8),
                        FlSpot(4, 2.8),
                        FlSpot(5, 2.2),
                      ],
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                      ),
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
