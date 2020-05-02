import 'package:flutter/material.dart';
import 'package:covid_19/utils/info_Card.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:flutter/services.dart';

const url = 'https://in.linkedin.com/in/alankrit-kumar-bhaskar-a85338198';
const email = 'alankritbhaskar1@gmail.com';
const phone = '+916307732932';


class DeveloperInfo extends StatefulWidget {
  @override
  _DeveloperInfoState createState() => _DeveloperInfoState();
}

class _DeveloperInfoState extends State<DeveloperInfo> {

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('images/alan.jpeg'),
              ),
              Text(
                'Alankrit K. Bhaskar',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              Text(
                'SOPHOMORE at NIT JAMSHEDPUR',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 16.0,
                  color: Colors.teal[50],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FLUTTER DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20.0,
                  color: Colors.teal[50],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.teal.shade700,
                ),
              ),

              InfoCard(
                text: phone,
                icon: Icons.phone,
                onPressed: () async {
                  String removeSpaceFromPhoneNumber = phone.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
                  final phoneCall = 'tel:$removeSpaceFromPhoneNumber';

                  if (await launcher.canLaunch(phoneCall)) {
                    await launcher.launch(phoneCall);
                  } else {
                    _showDialog(
                      context,
                      title: 'Sorry',
                      msg: 'Phone number can not be called. Please try again!',
                    );
                  }
                },
              ),
              InfoCard(
                text: email,
                icon: Icons.email,
                onPressed: () async {
                  final emailAddress = 'mailto:$email';

                  if (await launcher.canLaunch(emailAddress)) {
                    await launcher.launch(emailAddress);
                  } else {
                    _showDialog(
                      context,
                      title: 'Sorry',
                      msg: 'Email can not be send. Please try again!',
                    );
                  }
                },
              ),
              InfoCard(
                text: url,
                icon: Icons.web,
                onPressed: () async {
                  if (await launcher.canLaunch(url)) {
                    await launcher.launch(url);
                  } else {
                    _showDialog(
                      context,
                      title: 'Sorry',
                      msg: 'URL can not be opened. Please try again!',
                    );
                  }
                },
              ),
              InfoCard(
                text: 'Gorakhpur, Uttar Pradesh',
                icon: Icons.location_city,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.teal[700],
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

void _showDialog(BuildContext context, {String title, String msg}) {

      final dialog = AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          RaisedButton(
            color: Colors.teal,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Close',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      showDialog(context: context, builder: (x) => dialog);

    }




