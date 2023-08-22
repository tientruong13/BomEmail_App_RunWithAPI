import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AttachmentsGrid extends StatefulWidget {
  AttachmentsGrid({
    Key? key,
    required this.attachmentsList,
  }) : super(key: key);
  final List<String> attachmentsList;
  @override
  _AttachmentsGridState createState() => _AttachmentsGridState();
}

class _AttachmentsGridState extends State<AttachmentsGrid> {
  List<String> fileExtensions = [];

  Widget _displayWidgetForFile(String base64File, String extension) {
    var bytes = base64Decode(base64File);

    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Image.memory(bytes, fit: BoxFit.cover);
      case 'mp3':
      case 'wav':
      case 'ogg':
        return Icon(Icons.music_note, size: 50);
      case 'mp4':
      case 'mov':
        return Icon(Icons.videocam, size: 50);
      case 'pdf':
        return Icon(Icons.picture_as_pdf, size: 50);
      case 'zip':
      case 'rar':
        return Icon(Icons.archive, size: 50);
      case 'txt':
        return Icon(Icons.text_format, size: 50);
      default:
        return Icon(Icons.insert_drive_file, size: 50);
    }
  }

  String getExtension(int index) {
    if (index >= 0 && index < fileExtensions.length) {
      return fileExtensions[index];
    }
    return 'unknown'; // Default fallback
  }

  Future<void> openFile(String base64Image) async {
    // Decode the Base64 string
    var bytes = base64Decode(base64Image);

    // Get the temporary directory of the app
    final directory = await getTemporaryDirectory();

    // Create a temporary file
    final File file = File('${directory.path}/temp.jpg');

    // Write the bytes to the temporary file
    await file.writeAsBytes(bytes);

    // Open the temporary file
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: widget.attachmentsList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              openFile(widget.attachmentsList[index]);
            },
            child: _displayWidgetForFile(
                widget.attachmentsList[index], getExtension(index)),
          );
        },
      ),
    );
  }
}
