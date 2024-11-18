import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future showUploadPopup({
  required BuildContext context,
  required String title,
  required Function(String base64) onTap,
}) async {
  final picker = ImagePicker();
  File? _image;
  String? cropImage;
  String? _base64Image;

  Future<String> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    String targetPath = path.join(dir.absolute.path, 'temp.jpg');
    int quality = 100;
    XFile? compressedFile;

    do {
      compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
      );

      quality -= 10;
    } while (compressedFile != null &&
        File(compressedFile.path).lengthSync() > 1 * 1024 * 1024 &&
        quality > 0);

    return compressedFile!.path;
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage = await imgCropper(_image!.path);
      if (File(cropImage!).lengthSync() > 1 * 1024 * 1024) {
        final compressedImage = await _compressImage(File(cropImage!));
        cropImage = compressedImage;
      } else {
        cropImage = cropImage;
      }
      int compressedImageSize =  File(cropImage!).lengthSync();
      log((compressedImageSize / (1024 * 1024)).toStringAsFixed(2));
      return _base64Image = base64Encode(File(cropImage!).readAsBytesSync());
    } else {
      print('No image selected.');
      return null;
    }
    // });
  }

  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: AppColors.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(8),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: title,
                  textSize: 20,
                  color: AppColors.blackColor,
                  maxLine: 2,
                  align: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 12,
                ),
                Image.asset(PngAssetPath.uploadImg),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    getImage().then((value) {
                      if (value != null) {
                        selectedImg = value;
                        onTap(value);
                      }
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: AppColors.primaryColor,
                    surfaceTintColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: TextWidget(
                        text: "Upload",
                        textSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ));
}

String? selectedImg;

CroppedFile? croppedFile;

imgCropper(img) async {
  croppedFile = await ImageCropper().cropImage(
    sourcePath: img,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop your image',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ],
  );
  return croppedFile!.path;
}
