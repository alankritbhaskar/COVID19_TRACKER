import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid_19/pages/search.dart';

class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  List stateData;

  fetchStateData() async {
    http.Response response =
    await http.get('https://api.covid19india.org/v2/state_district_wise.json');
    setState(() {
      stateData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchStateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){

            showSearch(context: context, delegate: Search(stateData));

          },)
        ],
        title: Text('District-wise Statistics'),
      ),
      body: stateData == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemBuilder: (context, index) {

          return Card(


            child: Container(
              height: 130,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  Expanded(child: Container(
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          stateData[index]['state'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.only(top:5.0)),
                        Image(image: AssetImage("images/cases.jpg"),
                          height: 100,
                          width: 100
                          ,),
                      ],
                    ),

              ),),



                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(

                                stateData[index]['districtData'][index]['district'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                ),
                          ),

                          Text(

                            'CONFIRMED:' +
                                stateData[index]['districtData'][index]['confirmed'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),

                          Text(

                            'ACTIVE:' +
                                stateData[index]['districtData'][index]['active'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),


                          Text(

                            'RECOVERED:' +
                                stateData[index]['districtData'][index]['recovered'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),


                          Text(
                            'DEATHS:' +
                                stateData[index]['districtData'][index]['deceased'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness==Brightness.dark?Colors.grey[100]:Colors.grey[900]),
                          ),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          );
        },
        itemCount: stateData == null ? 0 : stateData.length,
      ),
    );
  }
}




