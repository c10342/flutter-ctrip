import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<XFile> _images = [];

  Future getImage(bool isCamera) async {
    // 移除底部弹框
    Navigator.pop(context);
    final ImagePicker picker = ImagePicker();
    XFile? image;
    if (isCamera) {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (image != null) {
        _images.add(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拍照功能'),
      ),
      body: Center(
        // flex方式将进行排列，并且可以换行
        child: Wrap(
//          边距
          spacing: 5,
          runSpacing: 5,
          children: _genImages(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageDialog,
        tooltip: '选择图片',
        child: const Icon(Icons.camera),
      ),
    );
  }

  void _showImageDialog() {
    // 调用底部弹框
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 120,
            child: Column(
              children: [
                _dialogItem('拍照', true),
                _dialogItem('从相册选择', false),
              ],
            ),
          );
        });
  }

  _dialogItem(String title, bool isCamera) {
    return GestureDetector(
      child: ListTile(
        // 左侧图标
        leading: Icon(isCamera ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isCamera),
      ),
    );
  }

  _genImages() {
    // 布局必须返回一个list，所以最后要toList一下
    return _images.map((file) {
      // Stack用来重叠组件
      return Stack(
        children: [
          ClipRRect(
//            圆角效果
            borderRadius: BorderRadius.circular(5),
            child: Image.file(File(file.path),
                width: 120, height: 90, fit: BoxFit.fill),
          ),
          // 定位，相对Stack
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _images.remove(file);
                });
              },
              child: ClipOval(
//                圆角删除按钮
                child: Container(
                  // 内边距
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Colors.black54),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }).toList();
  }
}
