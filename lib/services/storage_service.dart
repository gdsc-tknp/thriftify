import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Reference get storage => FirebaseStorage.instance.ref();

class StorageService {
  Future<String?> getImageFromDb(String? imgLabel) async {
    if (imgLabel == null) {
      return null;
    }
    try {
      var ref = storage.child('images').child('${imgLabel.toLowerCase()}.png');
      var imgRef = await ref.getDownloadURL();
      return imgRef;
    } catch (e) {
      return null;
    }
  }

  Future<String?> upload(XFile image) async {
    Reference ref =
        FirebaseStorage.instance.ref('images${imagePathName(image)}');
    await ref.putFile(File(image.path));
    return await ref.getDownloadURL();
  }

  String imagePathName(XFile image) {
    return image.path.split('/').last;
  }

  Future picImage(ImageSource src) async {
    final pickedImage =
        await ImagePicker().pickImage(source: src, imageQuality: 50);
    if (pickedImage == null) {
      return;
    }
    var file = await ImageCropper.platform.cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) {
      return;
    }
    file;
    // await upload(pickedImage.path);
  }

// Future<File> compressImage(String path, int quality) async {
//   final imgPath = p.join((await getTempraryDirectory()).path,
//       '${DateTime.now()}.${p.extension(path)}');
// }

  static Future<String> uploadImage(File imageFile, String productTitle) async {
    final storageRef =
        storage.child('productImages').child('$productTitle.jpg');
    final snapshot = await storageRef.putFile(imageFile);

    if (snapshot.state == TaskState.success) {
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } else {
      throw Exception('Image upload failed');
    }
  }

  static Future<void> saveData(
    String description,
    String imageUrl,
    double amount,
    String title,
    String date,
    String uid,
  ) async {
    await FirebaseFirestore.instance.collection('productImages').doc(uid).set({
      'description': description,
      'productImage': imageUrl,
      'productTitle': title,
      'amount': amount,
      'date': date,
    });
  }

  static Future<DocumentSnapshot> getDataStream(String uid) async {
    return await FirebaseFirestore.instance
        .collection('productImages')
        .doc(uid)
        .get();
  }
}
