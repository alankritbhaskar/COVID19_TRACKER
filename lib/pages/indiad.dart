import 'package:covid_19/datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {



  Future  onRefresh() async{

    await Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(

            future: datas,
            builder: (BuildContext context,AsyncSnapshot snapshot){

              if(snapshot.hasData)
              {print(snapshot.data);
              return  GridView.builder(


                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0
                  ),
                  itemCount: 32,


                  itemBuilder: (BuildContext context, index) => SizedBox(


                      height : 50.0,
                      width : 50.0,
                      child: GestureDetector(
                          onTap:()=> showcard(snapshot.data[index]['confirmedCasesIndian'].toString(),
                              snapshot.data[index]['confirmedCasesForeign'].toString(),
                              snapshot.data[index]['discharged'].toString(),
                              snapshot.data[index]['deaths'].toString()),

                        child: Container(
                          height: 130,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: <Widget>[
                              Expanded(
                                child: Card(
                                 color: Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text('Cases: ${snapshot.data[index]['confirmedCasesIndian'].toString()}',
                                        style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white),),
                                      Image(image: AssetImage("images/cases.jpg"),
                                       height: 85,),
                                      Text(snapshot.data[index]['loc'],style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white),),
                                    ],
                                  ),
                                ),
                              ),






                            ],
                          ),
                        ),
                      )
                  )
              );



              }
              return Center(
                child: CircularProgressIndicator(),
              );

            }


        )



    );
  }

  Future showcard (String ind,inter,recover,death) async
  {
    await showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            backgroundColor: Colors.white70,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[

                  Text("Indian Cases :$ind",style: TextStyle(fontSize: 25,color : Colors.blue,fontWeight: FontWeight.bold),),
                  Text("Foreigner Cases :$inter",style: TextStyle(fontSize: 25,color : Colors.black,fontWeight: FontWeight.bold
                  ),),
                  Text("Total Recoveries :$recover",style: TextStyle(fontSize: 25,color : Colors.green[800],fontWeight: FontWeight.bold),),
                  Text("Total Deaths :$death",style: TextStyle(fontSize: 25,color : Colors.red,fontWeight: FontWeight.bold),),




                ],
              ),
            ),
          );
        }
    );
  }

  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future <List>  datas;

  Future <List>  getData() async
  {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
  }


  @override
  void initState(){

    super.initState();
    datas = getData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
            title: Text('State-wise Statistics'),


        ),

        body: RefreshIndicator(
          child: Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(

                  future: datas,
                  builder: (BuildContext context,AsyncSnapshot snapshot){

                    if(snapshot.hasData)
                    {print(snapshot.data);
                    return  GridView.builder(


                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0
                        ),
                        itemCount: 32,


                        itemBuilder: (BuildContext context, index) => SizedBox(


                            height : 50.0,
                            width : 50.0,
                            child: GestureDetector(
                                onTap:()=> showcard(snapshot.data[index]['confirmedCasesIndian'].toString(),
                                    snapshot.data[index]['confirmedCasesForeign'].toString(),
                                    snapshot.data[index]['discharged'].toString(),
                                    snapshot.data[index]['deaths'].toString()),

                              child: Container(
                                height: 130,
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Expanded(
                                      child: Card(

                                        color:Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Cases: ${snapshot.data[index]['confirmedCasesIndian'].toString()}',
                                              style: TextStyle(fontWeight: FontWeight.bold, color:Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white),),
                                            Image(image: AssetImage("images/cases.jpg"),
                                              height: 85,),
                                            Text(snapshot.data[index]['loc'],style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white),),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            )
                        )
                    );



                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  }


              )



          ), onRefresh: ()=>onRefresh()  ,

        )
    );
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}

