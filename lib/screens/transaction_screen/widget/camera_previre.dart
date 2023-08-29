// ignore_for_file: prefer_const_declarations

import 'dart:io';

import 'package:fin_trackr/constants/constant.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final File imageFile;
  const ImagePreview({required this.imageFile, super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  TransformationController controller = TransformationController();
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    controller = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.imageFile.path);
    return Scaffold(
      backgroundColor: AppColor.ftScafoldColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                onDoubleTapDown: (details) => tapDownDetails = details,
                onDoubleTap: () {
                  final position = tapDownDetails!.localPosition;

                  final double scale = 3;
                  final x = -position.dx * (scale - 1);
                  final y = -position.dy * (scale - 1);

                  final zoomed = Matrix4.identity()
                    ..translate(x, y)
                    ..scale(scale);
                  final value = controller.value.isIdentity()
                      ? zoomed
                      : Matrix4.identity();
                  controller.value = value;
                },
                child: InteractiveViewer(
                  transformationController: controller,
                  clipBehavior: Clip.none,
                  child: Image.file(picture),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 20,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x81000000),
                  shape: BoxShape.rectangle,
                ),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppColor.ftTabBarSelectorColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
