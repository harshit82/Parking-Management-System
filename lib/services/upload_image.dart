import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vehicle_parking_management/models/vehicle.dart';

/// {@ obj vehicle} of Vehicle class
Vehicle vehicle = Vehicle();

late String downloadUrl;

// Create the file metadata
final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
final storageRef = FirebaseStorage.instance.ref();

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Choose"),
      children: [
        SimpleDialogOption(
            onPressed: () {
              getImageFromCamera();
              Navigator.pop(context);
            },
            child: const ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
            )),
        SimpleDialogOption(
          onPressed: () {
            getImageFromGallery();
            Navigator.pop(context);
          },
          child: const ListTile(
            leading: Icon(Icons.browse_gallery),
            title: Text("Gallery"),
          ),
        )
      ],
    );
  }

  // getPathAndUpload() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String filePath = '${appDocDir.absolute}/${storageRef.name}';
  //   String fileName = "Random File";
  //   File file = File(filePath);

  //   try {
  //     uploadFile(file, fileName);
  //   } on FirebaseException catch (e) {
  //     e.toString();
  //   }
  // }

  Future<String> getDownloadUrl({required Reference reference}) async {
    return await reference.getDownloadURL();
  }

  uploadFile(File file, String fileName) {
    // Upload file and metadata to the path 'images/filename.jpeg'
    final uploadTask =
        storageRef.child("images/$fileName").putFile(file, metadata);

    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);

          Fluttertoast.showToast(msg: "Upload is $progress% complete");
          debugPrint("Upload is $progress% complete");
          break;
        case TaskState.paused:
          Fluttertoast.showToast(msg: "Upload is paused");
          debugPrint("Upload is paused");
          break;
        case TaskState.canceled:
          Fluttertoast.showToast(msg: "Upload was cancelled");
          debugPrint("Upload was cancelled");
          break;
        case TaskState.error:
          Fluttertoast.showToast(msg: "Some error occurred");
          debugPrint("Some error occurred");
          break;
        case TaskState.success:
          Fluttertoast.showToast(msg: "Upload successful");

          // TODO: Not displaying value
          setState(() {
            downloadUrl = getDownloadUrl(reference: taskSnapshot.ref) as String;
            debugPrint(downloadUrl);
          });

          debugPrint("Upload successful");
          break;
      }
    });
  }

  Future getImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      uploadFile(image, vehicle.vehicleNumber.toString());
    }
  }

  Future getImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.camera)
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      uploadFile(image, vehicle.vehicleNumber.toString());
    }
  }
}
