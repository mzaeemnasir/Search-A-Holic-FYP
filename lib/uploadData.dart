import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchaholic/firebase_.dart';
import 'package:searchaholic/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadData extends StatefulWidget {
  // Removing Title Bar from the App

  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  late String email;

  void success_alert() {
    QuickAlert.show(
      context: context,
      title: "File Uploaded",
      text: "Your file has been uploaded successfully",
      type: QuickAlertType.success,
    );
  }

  void error_alert() {
    QuickAlert.show(
      context: context,
      title: "Error",
      text:
          "There was an error uploading your file, Please check the Sample Data Your Fields are not matching with the Sample Data",
      type: QuickAlertType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.057,
                      ),
                      child: Text("Upload Bulk Data",
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 45,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.13,
                      ),
                      child: ElevatedButton(
                          child: Text('Upload CSV File'),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['csv'],
                            );

                            if (result != null) {
                              PlatformFile file = result.files.first;
                              setState(() {
                                // Show a Dismissible Alert Dialog containing the file name and size and Are you sure you want to upload this file?
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("File Details"),
                                        content: Text(
                                            "File Name: ${file.name}\nFile Size: ${file.size} bytes\n\nAre you sure you want to upload this file?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                print("Cancel the upload");
                                                Navigator.of(context).pop();
                                                // Cancel the upload
                                              },
                                              child: Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                get_email();
                                                // wait for 1 second
                                                print(email);

                                                Flutter_api()
                                                    .uploadFile(
                                                        result
                                                            .files.single.path!,
                                                        email)
                                                    .then((value) => {
                                                          if (value == true)
                                                            {
                                                              success_alert(),
                                                            }
                                                          else
                                                            {
                                                              print("Error"),
                                                            }
                                                        });

                                                // To Do: Upload the file to the database

                                                print("Upload the file");
                                                Navigator.of(context).pop();
                                                // Upload the file to the database
                                              },
                                              child: const Text("Upload"))
                                        ],
                                      );
                                    });
                              });
                            } else {
                              print("No file selected");
                            }
                          }),
                    ),

                    // Instructions to Upload Data Key Points
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.075,
                        right: MediaQuery.of(context).size.width * 0.45,
                      ),
                      child: Text(
                          "1. Identify the data to be updated.\n2. Use the correct input method.\n3. Double-check the data before submitting.\n4. Verify the update has been made correctly.\n5. Keep track of updates for future reference.",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w200,
                            fontSize: MediaQuery.of(context).size.width / 80,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.135,
                        left: MediaQuery.of(context).size.width * 0.01,
                      ),
                      child: ElevatedButton(
                          child: const Text('Download Sample Data'),
                          onPressed: () {
                            Uri uri = Uri.parse(
                                "https://cdn.discordapp.com/attachments/748221133819609108/1091224870320349194/MedicinceData.csv"); // To Do: Add the link to the sample data
                            launchUrl(uri);
                          }),
                    ),
                  ]))),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void get_email() {
    Flutter_api().getEmail().then((value) {
      setState(() {
        email = value;
      });
    });
  }
}






/*
Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                // Making the button in the center
                alignment: Alignment.center,
                padding: EdgeInsets.all(100), // 100 is the width of the button
                child: ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['csv'],
                    );
                    if (result != null) {
                      PlatformFile file = result.files.first;
                      print(file.name);
                      print(file.bytes);
                      print(file.size);
                      print(file.extension);
                      print(file.path);
                    } else {
                      print("No file selected");
                    }
                  },
                  child: Text('Upload CSV File'),
                ),
              )),
              SizedBox(height: 20),
              Text('Download Sample Data'),
            ],
          ),
        ),
        */