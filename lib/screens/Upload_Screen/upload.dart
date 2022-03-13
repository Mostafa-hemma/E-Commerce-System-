import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class Upload extends StatelessWidget {
  static String routeName = "/upload";
  String? title;
  String? description;
  String? price;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Fill With Product Details'),
                    content: SingleChildScrollView(
                      child: SafeArea(
                          child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.008),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your username',
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.05),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your username',
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.05),
                            TextFormField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your username',
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.05),
                            TextFormField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Choose images of the product',
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          final results = await FilePicker
                                              .platform
                                              .pickFiles(
                                            allowMultiple: true,
                                            allowedExtensions: ['png', 'jpg'],
                                            type: FileType.custom,
                                          );
                                          if (results == null) {
                                            Fluttertoast.showToast(
                                                msg: "No Image Selected");
                                          }
                                          final path =
                                              results!.files.single.path;
                                          return null;
                                        },
                                        icon:
                                            Icon(Icons.upload_file_rounded)))),
                            SizedBox(height: SizeConfig.screenHeight * 0.05),
                          ],
                        ),
                      )),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Upload',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ));
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.upload_file),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Upload",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
