import 'package:flutter/material.dart';

class WorldPanel extends StatelessWidget {
  final Map worldData;

  const WorldPanel({Key key, this.worldData}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
        children: <Widget>[
          stpanel(
            title:'CONFIRMED',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: worldData['cases'].toString(),
          ),
          stpanel(
            title:'ACTIVE',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: worldData['active'].toString(),
          ),
          stpanel(
            title:'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green[900],
            count: worldData['recovered'].toString(),
          ),
          stpanel(
            title:'DEATHS',
            panelColor: Colors.grey[300],
            textColor: Colors.grey[900],
            count: worldData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}


class stpanel extends StatelessWidget {
  @override
  final String title;
  final String count;
  final Color textColor;
  final Color panelColor;

  const stpanel(
      {Key key, this.title, this.count, this.textColor, this.panelColor})
      : super(key: key);

  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      color: panelColor,
      margin: EdgeInsets.all(5),
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: textColor),),
          Text(count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: textColor),),
        ],
      ),
    );
  }
}

