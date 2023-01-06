// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, avoid_print

// import 'package:flutter/material.dart';

// class Sidebar extends StatefulWidget {
//   const Sidebar({Key? key}) : super(key: key);

//   @override
//   _SidebarState createState() => _SidebarState();
// }

// class _SidebarState extends State<Sidebar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color.fromRGBO(80, 140, 252, 1),
//       width: MediaQuery.of(context).size.width / 4,

//       ///Everything is wrapped into a listview to prevent overflows
//       child: ListView(
//         children: [
//           ///SideBar title
//           Container(
//               height: MediaQuery.of(context).size.height * 0.12,
//               width: MediaQuery.of(context).size.width / 4,
//               color: Color.fromRGBO(217, 217, 217, 0.12),
//               child: Center(
//                   child: Padding(
//                 padding: EdgeInsets.fromLTRB(
//                     MediaQuery.of(context).size.width * 0.04,
//                     MediaQuery.of(context).size.height * 0.04,
//                     MediaQuery.of(context).size.width * 0.04,
//                     MediaQuery.of(context).size.height * 0.04),
//                 child: Image(
//                   image: AssetImage("images/sidebarLogo.png"),
//                 ),
//               ))),

//           ///Dashboard Card
//           Padding(
//               padding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.02,
//                   10,
//                   MediaQuery.of(context).size.width * 0.03,
//                   10),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 child: Card(
//                   elevation: 0,
//                   color: Color.fromRGBO(248, 249, 250, 1),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: InkWell(
//                     onTap: () {
//                       print("Dashboard Button Pressed");
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ///Image
//                         Padding(
//                           padding: EdgeInsets.only(
//                             right: 4,
//                             left: MediaQuery.of(context).size.width * 0.02,
//                             top: MediaQuery.of(context).size.height * 0.015,
//                             bottom: MediaQuery.of(context).size.height * 0.012,
//                           ),
//                           child: Image(
//                               image: AssetImage("images/dashboard_icon.png")),
//                         ),

//                         ///Text
//                         Text(
//                           "Dashboard",
//                           style: TextStyle(
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.w500,
//                             fontSize: MediaQuery.of(context).size.width / 45,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),

//           ///Products Card
//           Padding(
//               padding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.02,
//                   10,
//                   MediaQuery.of(context).size.width * 0.03,
//                   10),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 child: Card(
//                   elevation: 0,
//                   color: Color.fromRGBO(248, 249, 250, 1),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: InkWell(
//                     onTap: () {
//                       print("Products Button Pressed");
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ///Image
//                         Padding(
//                           padding: EdgeInsets.only(
//                             right: 4,
//                             left: MediaQuery.of(context).size.width * 0.02,
//                             top: MediaQuery.of(context).size.height * 0.015,
//                             bottom: MediaQuery.of(context).size.height * 0.012,
//                           ),
//                           child: Image(
//                               image: AssetImage("images/products_icon.png")),
//                         ),

//                         ///Text
//                         Text(
//                           "Products",
//                           style: TextStyle(
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.w500,
//                             fontSize: MediaQuery.of(context).size.width / 45,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),

//           ///Categories Card
//           Padding(
//               padding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.02,
//                   10,
//                   MediaQuery.of(context).size.width * 0.03,
//                   10),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 child: Card(
//                   elevation: 0,
//                   color: Color.fromRGBO(248, 249, 250, 1),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: InkWell(
//                     onTap: () {
//                       print("Categories Button Pressed");
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ///Image
//                         Padding(
//                           padding: EdgeInsets.only(
//                             right: 4,
//                             left: MediaQuery.of(context).size.width * 0.02,
//                             top: MediaQuery.of(context).size.height * 0.015,
//                             bottom: MediaQuery.of(context).size.height * 0.012,
//                           ),
//                           child: Image(
//                               image: AssetImage("images/categories_icon.png")),
//                         ),

//                         ///Text
//                         Text(
//                           "Categories",
//                           style: TextStyle(
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.w500,
//                             fontSize: MediaQuery.of(context).size.width / 45,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),

//           ///Sales Card
//           Padding(
//               padding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.02,
//                   10,
//                   MediaQuery.of(context).size.width * 0.03,
//                   10),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 child: Card(
//                   elevation: 0,
//                   color: Color.fromRGBO(248, 249, 250, 1),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ///Image
//                       Padding(
//                         padding: EdgeInsets.only(
//                           right: 4,
//                           left: MediaQuery.of(context).size.width * 0.02,
//                           top: MediaQuery.of(context).size.height * 0.015,
//                           bottom: MediaQuery.of(context).size.height * 0.012,
//                         ),
//                         child:
//                             Image(image: AssetImage("images/sales_icon.png")),
//                       ),

//                       ///Text
//                       Text(
//                         "Sales",
//                         style: TextStyle(
//                           fontFamily: "Montserrat",
//                           fontWeight: FontWeight.w500,
//                           fontSize: MediaQuery.of(context).size.width / 45,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )),

//           ///Analytics Card
//           Padding(
//               padding: EdgeInsets.fromLTRB(
//                   MediaQuery.of(context).size.width * 0.02,
//                   10,
//                   MediaQuery.of(context).size.width * 0.03,
//                   10),
//               child: Container(
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   child: Card(
//                     elevation: 0,
//                     color: Color.fromRGBO(248, 249, 250, 1),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     child: InkWell(
//                       onTap: () {
//                         print("Analytics Button Pressed");
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           ///Image
//                           Padding(
//                             padding: EdgeInsets.only(
//                               right: 4,
//                               left: MediaQuery.of(context).size.width * 0.02,
//                               top: MediaQuery.of(context).size.height * 0.015,
//                               bottom:
//                                   MediaQuery.of(context).size.height * 0.012,
//                             ),
//                             child: Image(
//                                 image: AssetImage("images/analytics_icon.png")),
//                           ),

//                           ///Text
//                           Text(
//                             "Analytics",
//                             style: TextStyle(
//                               fontFamily: "Montserrat",
//                               fontWeight: FontWeight.w500,
//                               fontSize: MediaQuery.of(context).size.width / 45,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ))),

//           ///Divider
//           Padding(
//             padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width * 0.02,
//                 right: MediaQuery.of(context).size.width * 0.02),
//             child: Divider(
//               thickness: 0.6,
//               color: Colors.black,
//             ),
//           ),

//           ///Settings
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//                 MediaQuery.of(context).size.width * 0.03,
//                 MediaQuery.of(context).size.height * 0.02,
//                 MediaQuery.of(context).size.width * 0.04,
//                 0),
//             child: ListTile(
//                 onTap: () {
//                   print("Settings Button Pressed");
//                 },
//                 leading: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.036,
//                   width: MediaQuery.of(context).size.height * 0.036,
//                   child: Image(
//                     image: AssetImage("images/settings_icon.png"),
//                   ),
//                 ),
//                 title: Text(
//                   "Settings",
//                   style: TextStyle(
//                     color: Color.fromRGBO(248, 249, 250, 1),
//                     fontFamily: "Montserrat",
//                     fontWeight: FontWeight.w400,
//                     fontSize: MediaQuery.of(context).size.width / 55,
//                   ),
//                 )),
//           ),

//           ///Profile
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//                 MediaQuery.of(context).size.width * 0.03,
//                 0,
//                 MediaQuery.of(context).size.width * 0.04,
//                 0),
//             child: ListTile(
//                 onTap: () {
//                   print("Profile Button Pressed");
//                 },
//                 leading: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.036,
//                   width: MediaQuery.of(context).size.height * 0.036,
//                   child: Image(
//                     image: AssetImage("images/profile_icon.png"),
//                   ),
//                 ),
//                 title: Text(
//                   "Profile",
//                   style: TextStyle(
//                     color: Color.fromRGBO(248, 249, 250, 1),
//                     fontFamily: "Montserrat",
//                     fontWeight: FontWeight.w400,
//                     fontSize: MediaQuery.of(context).size.width / 55,
//                   ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchaholic/login.dart';
import 'package:searchaholic/product.dart';
//import 'package:alert/alert.dart';
import 'package:quickalert/quickalert.dart';

import 'dashboard.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(80, 140, 252, 1),
      width: MediaQuery.of(context).size.width / 4,

      ///Everything is wrapped into a listview to prevent overflows
      child: ListView(
        children: [
          ///SideBar title
          Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width / 4,
              color: Color.fromRGBO(217, 217, 217, 0.12),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.04,
                    MediaQuery.of(context).size.height * 0.04,
                    MediaQuery.of(context).size.width * 0.04,
                    MediaQuery.of(context).size.height * 0.04),
                child: Image(
                  image: AssetImage("images/sidebarLogo.png"),
                ),
              ))),

          ///Dashboard Card
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  10,
                  MediaQuery.of(context).size.width * 0.03,
                  10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Card(
                  elevation: 0,
                  color: Color.fromRGBO(248, 249, 250, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Image
                        Padding(
                          padding: EdgeInsets.only(
                            right: 4,
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.012,
                          ),
                          child: Image(
                              image: AssetImage("images/dashboard_icon.png")),
                        ),

                        ///Text
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width / 60,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),

          ///Products Card
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  10,
                  MediaQuery.of(context).size.width * 0.03,
                  10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Card(
                  elevation: 0,
                  color: Color.fromRGBO(248, 249, 250, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Product()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Image
                        Padding(
                          padding: EdgeInsets.only(
                            right: 4,
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.012,
                          ),
                          child: Image(
                              image: AssetImage("images/products_icon.png")),
                        ),

                        ///Text
                        Text(
                          "Products",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width / 60,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),

          ///Categories Card
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  10,
                  MediaQuery.of(context).size.width * 0.03,
                  10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Card(
                  elevation: 0,
                  color: Color.fromRGBO(248, 249, 250, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      print("Categories Button Pressed");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Image
                        Padding(
                          padding: EdgeInsets.only(
                            right: 4,
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.012,
                          ),
                          child: Image(
                              image: AssetImage("images/categories_icon.png")),
                        ),

                        ///Text
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width / 60,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),

          ///Sales Card
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  10,
                  MediaQuery.of(context).size.width * 0.03,
                  10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Card(
                  elevation: 0,
                  color: Color.fromRGBO(248, 249, 250, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      print("Sales Button Pressed");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Image
                        Padding(
                          padding: EdgeInsets.only(
                            right: 4,
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.012,
                          ),
                          child:
                              Image(image: AssetImage("images/sales_icon.png")),
                        ),

                        ///Text
                        Text(
                          "Sales",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width / 60,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),

          ///Analytics Card
          Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  10,
                  MediaQuery.of(context).size.width * 0.03,
                  10),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Card(
                    elevation: 0,
                    color: Color.fromRGBO(248, 249, 250, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        print("Analytics Button Pressed");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///Image
                          Padding(
                            padding: EdgeInsets.only(
                              right: 4,
                              left: MediaQuery.of(context).size.width * 0.02,
                              top: MediaQuery.of(context).size.height * 0.015,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.012,
                            ),
                            child: Image(
                                image: AssetImage("images/analytics_icon.png")),
                          ),

                          ///Text
                          Text(
                            "Analytics",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.width / 60,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),

          ///Divider
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Divider(
              thickness: 0.6,
              color: Colors.black,
            ),
          ),

          ///Settings
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.width * 0.04,
                0),
            child: ListTile(
                onTap: () {
                  print("Settings Button Pressed");
                },
                leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.036,
                  width: MediaQuery.of(context).size.height * 0.036,
                  child: Image(
                    image: AssetImage("images/settings_icon.png"),
                  ),
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: Color.fromRGBO(248, 249, 250, 1),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 55,
                  ),
                )),
          ),

          ///Profile
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.03,
                0,
                MediaQuery.of(context).size.width * 0.04,
                0),
            child: ListTile(
                onTap: () {
                  print("You pressed Profile");
                },
                leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.036,
                  width: MediaQuery.of(context).size.height * 0.036,
                  child: Image(
                    image: AssetImage("images/profile_icon.png"),
                  ),
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Color.fromRGBO(248, 249, 250, 1),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 55,
                  ),
                )),
          ),

          /// Logout
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.03,
                0,
                MediaQuery.of(context).size.width * 0.04,
                0),
            child: ListTile(
                onTap: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    animType: QuickAlertAnimType.scale,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    onConfirmBtnTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    cancelBtnText: 'No',
                    confirmBtnColor: Colors.green,
                    titleColor: Colors.red,
                  );
                },
                leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.036,
                  width: MediaQuery.of(context).size.height * 0.036,
                  child: Image(
                    image: AssetImage("images/logout_icon3.png"),
                  ),
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: Color.fromRGBO(248, 249, 250, 1),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width / 55,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
