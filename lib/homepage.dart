import 'dart:convert';

import 'package:covid_19/datasource.dart';
import 'package:covid_19/pages/countryPage.dart';
import 'package:covid_19/pages/faqs.dart';

import 'package:covid_19/pages/indiad.dart';
import 'package:covid_19/panels/developer.dart';
import 'package:covid_19/panels/infoPanel.dart';
import 'package:covid_19/panels/mostAffectedCountries.dart';
import 'package:covid_19/panels/wwpanel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData()async{
    http.Response response=await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData=jsonDecode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async{
    http.Response response=await http.get("https://corona.lmao.ninja/v2/countries?sort=cases");
    setState(() {
      countryData=json.decode(response.body);
    });
  }

 List stateData;
 fetchStateData() async{
  http.Response response=await http.get("https://api.covid19india.org/v2/state_district_wise.json") ;
  setState(() {
  stateData=jsonDecode(response.body);
 });
 }

  Future fetchData() async{
    fetchWorldWideData();
    fetchCountryData();
    fetchStateData();
   CupertinoAlertDialog(
     content:Text('Re-Fetched the data'),
   );
  }
  @override

  void initState(){
    fetchData();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              child: DrawerHeader(

                child: Text('COVID-19 TRACKER',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,


                ),
              ),
            ),
            ListTile(
              title: Text('Country-wise Statistics',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
              },
            ),
            ListTile(
              title: Text('State-wise Statistics',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>India()));
              },
            ),
            ListTile(
              title: Text('Frequently Asked Questions',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
              },
            ),
            ListTile(
              title: Text('Contribute in PMCARES',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                launch("https://www.pmcares.gov.in/en/web/contribution/donate_india");
              },
            ),
            ListTile(
              title: Text('Myths about COVID-19',style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                launch("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters");
              },
            ),

              ListTile(
                title: Text('About the Developer',style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DeveloperInfo()));
                },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19 TRACKER'),

        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],


      ),
      body: RefreshIndicator(
           onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 100,
                color: Colors.orange[100],
                child: Text(DataSource.quote,style: TextStyle(color: Colors.orange[800],fontWeight:FontWeight.bold,fontSize: 16),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Worldwide',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                      },
                      child: Container(

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(14),
                            color: Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,

                        ),
                          padding: EdgeInsets.all(10),
                          child: Text('Regional',style: TextStyle(fontSize: 18,color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,fontWeight: FontWeight.bold),)

                      ),
                    ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>India()));
                        },
                        child: Container (
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,
                              borderRadius: BorderRadius.circular(14),

              ),
                         padding: EdgeInsets.all(10),
                          child:  Text('India',style: TextStyle(fontSize: 18,color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,fontWeight: FontWeight.bold),)
                        ),
                      ),

                  ],
                ),
              ),
              worldData==null?Center(child:CircularProgressIndicator()):WorldPanel(worldData: worldData,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
                child: Text('Top 5 Affected Countries',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              ),
              countryData==null?Container():MostAffectedPanel(countryData: countryData,),

              InfoPanel(),
              SizedBox(height: 10,),
              Center(child: Text('!!! TOGETHER WE WILL WIN !!!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.teal[900]),)),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.bottomRight,child: Text("*International Data updated after every 10 minutes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.blueGrey),)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.bottomRight,child: Text("**National Data is fetched from MoHFW updated thrice a day",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.blueGrey),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
