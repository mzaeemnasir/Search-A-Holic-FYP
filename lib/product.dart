import 'package:searchaholic/imports.dart';
import 'package:searchaholic/sidebar.dart';

// Product class to Show the Product Details

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);
  @override
  _Product createState() => _Product();
}

class _Product extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.087,
                      ),
                      child: Text("Products",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 45,
                          ))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
