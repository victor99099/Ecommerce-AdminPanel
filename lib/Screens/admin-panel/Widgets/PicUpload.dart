import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PicUpload extends StatefulWidget {
  final RxnString imgUrl;
  const PicUpload({super.key, required this.imgUrl});

  @override
  State<PicUpload> createState() => _PicUploadState();
}

class _PicUploadState extends State<PicUpload> {
  DropzoneViewController? dropzoneController;

  Future<String> GetUrl(XFile image) async {
    try {
      final ref =
          FirebaseStorage.instance.ref('categoriesImages/').child(image.name);
      // final metadata = SettableMetadata(
      // contentType: 'image/jpeg'); // 👈 Ensure correct MIME type

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        await ref.putData(bytes); // 👈 Appl
      } else {
        await ref.putFile(File(image.path)); // 👈 Appl
      }

      final url = await ref.getDownloadURL();
      widget.imgUrl.value = url;
      return url;
    } catch (e) {
      print("Image upload error: $e");
      return "";
    }
  }

  Future<void> _pickFile() async {
    try {
      EasyLoading.show();
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(withData: true, type: FileType.image);

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        // Convert Uint8List to XFile
        XFile xFile;
        if (file.path != null) {
          xFile = XFile(file.path!); // For non-web platforms
        } else {
          // Convert Uint8List to File (For web and some platforms)
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${file.name}');
          await tempFile.writeAsBytes(file.bytes!);
          xFile = XFile(tempFile.path);
        }

        final url = await GetUrl(xFile);
        widget.imgUrl.value = url;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Picture uploaded',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ));
      } else {
        print("File not selected.");
      }
    } catch (e) {
      print("Error in file picker: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: _pickFile,
      child: DottedBorder(
        color: theme.colorScheme.tertiaryFixed,
        strokeWidth: 1.5,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          width: Get.width * 0.2,
          height: Get.height * 0.4,
          alignment: Alignment.center,
          child: Center(
            child: Stack(
              children: [
                DropzoneView(
                  onCreated: (controller) => dropzoneController = controller,
                  onDropFile: (dynamic file) async {
                    try {
                      EasyLoading.show();
                      final String name =
                          await dropzoneController!.getFilename(file);
                      final Uint8List bytes =
                          await dropzoneController!.getFileData(file);

                      // Convert Uint8List to XFile
                      final XFile xFile = XFile.fromData(bytes, name: name);

                      final url = await GetUrl(xFile);
                      widget.imgUrl.value = url;

                      print(widget.imgUrl.value);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Picture uploaded',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ));
                    } catch (e) {
                      print("Error in Dropzone: $e");
                    } finally {
                      EasyLoading.dismiss();
                    }
                  },
                ),
                Positioned(
                  child: Obx(
                    () => Center(
                      child: widget.imgUrl.value == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload,
                                    size: 40,
                                    color: theme.colorScheme.onPrimary),
                                "Click to upload".text.blue500.make(),
                                "or Drag & Drop".text.make(),
                                "Max, File Size: 20MB".text.gray500.sm.make(),
                              ],
                            )
                          : Image.network(widget.imgUrl.value!,
                              width: Get.width * 0.18,
                              height: Get.height * 0.36,
                              fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductUpdatePicUpload extends StatefulWidget {
  final RxnString imgUrl;
  const ProductUpdatePicUpload({super.key, required this.imgUrl});

  @override
  State<ProductUpdatePicUpload> createState() => _ProductUpdatePicUploadState();
}

class _ProductUpdatePicUploadState extends State<ProductUpdatePicUpload> {
  DropzoneViewController? dropzoneController;

  Future<String> GetUrl(XFile image) async {
    try {
      final ref =
          FirebaseStorage.instance.ref('categoriesImages/').child(image.name);
      // final metadata = SettableMetadata(
      // contentType: 'image/jpeg'); // 👈 Ensure correct MIME type

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        await ref.putData(bytes); // 👈 Appl
      } else {
        await ref.putFile(File(image.path)); // 👈 Appl
      }

      final url = await ref.getDownloadURL();
      widget.imgUrl.value = url;
      return url;
    } catch (e) {
      print("Image upload error: $e");
      return "";
    }
  }

  Future<void> _pickFile() async {
    try {
      EasyLoading.show();
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(withData: true, type: FileType.image);

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        // Convert Uint8List to XFile
        XFile xFile;
        if (file.path != null) {
          xFile = XFile(file.path!); // For non-web platforms
        } else {
          // Convert Uint8List to File (For web and some platforms)
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${file.name}');
          await tempFile.writeAsBytes(file.bytes!);
          xFile = XFile(tempFile.path);
        }

        final url = await GetUrl(xFile);
        widget.imgUrl.value = url;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product picture uploaded',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ));
      } else {
        print("File not selected.");
      }
    } catch (e) {
      print("Error in file picker: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: _pickFile,
      child: DottedBorder(
        color: theme.colorScheme.tertiaryFixed,
        strokeWidth: 1.5,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          width: Get.width * 0.12,
          height: Get.height * 0.2,
          alignment: Alignment.center,
          child: Center(
            child: Stack(
              children: [
                DropzoneView(
                  onCreated: (controller) => dropzoneController = controller,
                  onDropFile: (dynamic file) async {
                    try {
                      EasyLoading.show();
                      final String name =
                          await dropzoneController!.getFilename(file);
                      final Uint8List bytes =
                          await dropzoneController!.getFileData(file);

                      // Convert Uint8List to XFile
                      final XFile xFile = XFile.fromData(bytes, name: name);

                      final url = await GetUrl(xFile);
                      widget.imgUrl.value = url;

                      print(widget.imgUrl.value);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Product picture uploaded',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ));
                    } catch (e) {
                      print("Error in Dropzone: $e");
                    } finally {
                      EasyLoading.dismiss();
                    }
                  },
                ),
                Positioned(
                  child: Obx(
                    () => Center(
                      child: widget.imgUrl.value == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload,
                                    size: 40,
                                    color: theme.colorScheme.onPrimary),
                                "Click to upload".text.blue500.make(),
                                "or Drag & Drop".text.make(),
                                "Max, File Size: 20MB".text.gray500.sm.make(),
                              ],
                            )
                          : Image.network(widget.imgUrl.value!,
                              width: Get.width * 0.18,
                              height: Get.height * 0.36,
                              fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserUpdatePicUpload extends StatefulWidget {
  final RxnString imgUrl;
  const UserUpdatePicUpload({super.key, required this.imgUrl});

  @override
  State<UserUpdatePicUpload> createState() => _UserUpdatePicUploadState();
}

class _UserUpdatePicUploadState extends State<UserUpdatePicUpload> {
  DropzoneViewController? dropzoneController;

  Future<String> GetUrl(XFile image) async {
    try {
      final ref =
          FirebaseStorage.instance.ref('categoriesImages/').child(image.name);
      // final metadata = SettableMetadata(
      // contentType: 'image/jpeg'); // 👈 Ensure correct MIME type

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        await ref.putData(bytes); // 👈 Appl
      } else {
        await ref.putFile(File(image.path)); // 👈 Appl
      }

      final url = await ref.getDownloadURL();
      widget.imgUrl.value = url;
      return url;
    } catch (e) {
      print("Image upload error: $e");
      return "";
    }
  }

  Future<void> _pickFile() async {
    try {
      EasyLoading.show();
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(withData: true, type: FileType.image);

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        // Convert Uint8List to XFile
        XFile xFile;
        if (file.path != null) {
          xFile = XFile(file.path!); // For non-web platforms
        } else {
          // Convert Uint8List to File (For web and some platforms)
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${file.name}');
          await tempFile.writeAsBytes(file.bytes!);
          xFile = XFile(tempFile.path);
        }

        final url = await GetUrl(xFile);
        widget.imgUrl.value = url;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User picture uploaded',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ));
      } else {
        print("File not selected.");
      }
    } catch (e) {
      print("Error in file picker: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: _pickFile,
      child: DottedBorder(
        color: theme.colorScheme.tertiaryFixed,
        strokeWidth: 1.5,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          width: Get.width * 0.05,
          height: Get.height * 0.05,
          alignment: Alignment.center,
          child: Center(
            child: Stack(
              children: [
                DropzoneView(
                  onCreated: (controller) => dropzoneController = controller,
                  onDropFile: (dynamic file) async {
                    try {
                      EasyLoading.show();
                      final String name =
                          await dropzoneController!.getFilename(file);
                      final Uint8List bytes =
                          await dropzoneController!.getFileData(file);

                      // Convert Uint8List to XFile
                      final XFile xFile = XFile.fromData(bytes, name: name);

                      final url = await GetUrl(xFile);
                      widget.imgUrl.value = url;

                      print(widget.imgUrl.value);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('User picture uploaded',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ));
                    } catch (e) {
                      print("Error in Dropzone: $e");
                    } finally {
                      EasyLoading.dismiss();
                    }
                  },
                ),
                Positioned(
                  child: Obx(
                    () => Center(
                      child: widget.imgUrl.value == null
                          ? Icon(Icons.cloud_upload,
                              size: 20, color: theme.colorScheme.onPrimary)
                          : Image.network(widget.imgUrl.value!,
                              width: Get.width * 0.18,
                              height: Get.height * 0.36,
                              fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserUpdatePicUpload2 extends StatefulWidget {
  final RxnString imgUrl;
  const UserUpdatePicUpload2({super.key, required this.imgUrl});

  @override
  State<UserUpdatePicUpload2> createState() => _UserUpdatePicUpload2State();
}

class _UserUpdatePicUpload2State extends State<UserUpdatePicUpload2> {
  DropzoneViewController? dropzoneController;

  Future<String> GetUrl(XFile image) async {
    try {
      final ref =
          FirebaseStorage.instance.ref('categoriesImages/').child(image.name);
      // final metadata = SettableMetadata(
      // contentType: 'image/jpeg'); // 👈 Ensure correct MIME type

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        await ref.putData(bytes); // 👈 Appl
      } else {
        await ref.putFile(File(image.path)); // 👈 Appl
      }

      final url = await ref.getDownloadURL();
      widget.imgUrl.value = url;
      return url;
    } catch (e) {
      print("Image upload error: $e");
      return "";
    }
  }

  Future<void> _pickFile() async {
    try {
      EasyLoading.show();
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(withData: true, type: FileType.image);

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        // Convert Uint8List to XFile
        XFile xFile;
        if (file.path != null) {
          xFile = XFile(file.path!); // For non-web platforms
        } else {
          // Convert Uint8List to File (For web and some platforms)
          final tempDir = await getTemporaryDirectory();
          final tempFile = File('${tempDir.path}/${file.name}');
          await tempFile.writeAsBytes(file.bytes!);
          xFile = XFile(tempFile.path);
        }

        final url = await GetUrl(xFile);
        widget.imgUrl.value = url;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User picture uploaded',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ));
      } else {
        print("File not selected.");
      }
    } catch (e) {
      print("Error in file picker: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    return InkWell(
      onTap: _pickFile,
      child: DottedBorder(
        color: theme.colorScheme.tertiaryFixed,
        strokeWidth: 1.5,
        dashPattern: [6, 3],
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          width: Get.width * 0.15,
          height: Get.height * 0.15,
          alignment: Alignment.center,
          child: Center(
            child: Stack(
              children: [
                DropzoneView(
                  onCreated: (controller) => dropzoneController = controller,
                  onDropFile: (dynamic file) async {
                    try {
                      EasyLoading.show();
                      final String name =
                          await dropzoneController!.getFilename(file);
                      final Uint8List bytes =
                          await dropzoneController!.getFileData(file);

                      // Convert Uint8List to XFile
                      final XFile xFile = XFile.fromData(bytes, name: name);

                      final url = await GetUrl(xFile);
                      widget.imgUrl.value = url;

                      print(widget.imgUrl.value);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .update({'userImg': widget.imgUrl.value});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('User picture uploaded',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ));
                    } catch (e) {
                      print("Error in Dropzone: $e");
                    } finally {
                      EasyLoading.dismiss();
                    }
                  },
                ),
                Positioned(
                  child: Obx(
                    () => Center(
                      child: widget.imgUrl.value == null
                          ? Icon(Icons.cloud_upload,
                              size: 20, color: theme.colorScheme.onPrimary)
                          : Image.network(widget.imgUrl.value!,
                              width: Get.width * 0.18,
                              height: Get.height * 0.36,
                              fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
