import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/product.dart';
import 'package:searchaholic/sidebar.dart';
import 'imports.dart';

class biCharts extends StatefulWidget {
  const biCharts({super.key});

  @override
  _biChartsState createState() => _biChartsState();
}

class _biChartsState extends State<biCharts> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void myalert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Login Faild',
      text: 'Wrong Email or Password',
    );
  }

  void myalert1() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Login Successful',
      text: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: formkey,
            child: Row(children: [
              Sidebar(),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.057,
                          ),
                          child: Text("BI charts",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width / 45,
                              )),
                        ),
                      ])))
            ])));
  }
}
