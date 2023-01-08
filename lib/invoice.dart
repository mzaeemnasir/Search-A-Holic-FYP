// ignore_for_file: library_private_types_in_public_api

import 'imports.dart';

// Invoice Class
class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.3),
                child: Container(color: Colors.blue),
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.3,
                  right: MediaQuery.of(context).size.width * 0.3),
              child: Container(color: Colors.red),
            ),
          ),
          Expanded(flex: 2, child: Container(color: Colors.orange)),
          Expanded(flex: 1, child: Container(color: Colors.pink)),
        ],
      ),
    );
  }
}
