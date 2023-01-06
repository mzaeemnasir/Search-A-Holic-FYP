import 'package:searchaholic/imports.dart';
import 'package:flutter/material.dart';
import 'package:searchaholic/sidebar.dart';
//import 'package:searchaholic/textBox.dart';

class profile extends StatefulWidget {
  const profile({
    Key? key,
  }) : super(key: key);
  //const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
// Update State
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Sidebar(),
        Expanded(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(children: [
                ///image of store with name
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.087,
                  ),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 1.5,
                    child: Image.asset(
                        'images/password_recover.jpg'), //this is a dumy image
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
    //]));
  }
}
