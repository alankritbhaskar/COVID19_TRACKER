import 'package:covid_19/datasource.dart';
import 'package:covid_19/pages/faqs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 10,bottom: 5),

              color:Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,

              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('FAQs',style: TextStyle(color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.arrow_forward,color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,),
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: (){
              launch("https://www.pmcares.gov.in/en/web/contribution/donate_india");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical:5),
              color:Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('DONATE TO PMCARES',style: TextStyle(color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.arrow_forward,color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,),
                  ),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: (){
              launch("https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical:5),
              color:Theme.of(context).brightness==Brightness.dark?Colors.white:primaryBlack,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('MYTH BUSTERS: WHO',style: TextStyle(color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.arrow_forward,color: Theme.of(context).brightness==Brightness.dark?primaryBlack:Colors.white,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
