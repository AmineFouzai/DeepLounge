import 'package:DeepLounge/auth/UserService.dart';
import "package:flutter/material.dart";

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          SettingsSection(
            sectionTitle: "Account Settings",
            sectionIcon: Icon(
              Icons.supervised_user_circle,
              color: Colors.green,
            ),
          ),
          SettingsSection(
            sectionTitle: "Billing and Payment",
            sectionIcon: Icon(
              Icons.account_balance,
              color: Colors.green,
            ),
          ),
          SettingsSection(
            sectionTitle: "App Settings",
            sectionIcon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
          ),
          SettingsSection(
            sectionTitle: "About",
            sectionIcon: Icon(
              Icons.verified_user,
              color: Colors.green,
            ),
          ),
          SettingsSection(
            sectionTitle: "Logout",
            sectionIcon: Icon(
              Icons.logout,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatefulWidget {
  final String sectionTitle;
  final Icon sectionIcon;

  SettingsSection({this.sectionTitle, this.sectionIcon});

  @override
  _SettingsSectionState createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          switch (widget.sectionTitle) {
            case 'Account Settings':
              print("account settings");
              break;
            case 'Billing and Payment':
              print("Billing and Payment");
              break;
            case 'App Settings':
              print("App Settings");
              break;
            case 'About':
              print("About");
              break;
            case 'Logout':
              await AuthService().signOut(context);
              break;
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.77,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              widget.sectionIcon,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.sectionTitle,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
