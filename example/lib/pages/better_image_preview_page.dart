import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_image_preview.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterImagePreviewPage extends StatelessWidget {
  const BetterImagePreviewPage({super.key});

  static const _images = <String>[
    'assets/images/cat.jpeg',
    'https://picsum.photos/id/1025/1200/1800',
    'https://picsum.photos/id/1015/1800/1200',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('图片预览'.tr)),
      body: Padding(
        padding: EdgeInsets.all(16.bw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('支持左右切换、双击或双指缩放。'.tr),
            SizedBox(height: 16.bw),
            BetterButton(
              text: '基础用法'.tr,
              onTap: () {
                BetterImagePreview.show(context: context, images: _images);
              },
            ),
            SizedBox(height: 12.bw),
            BetterButton(
              text: '显示关闭按钮'.tr,
              onTap: () {
                BetterImagePreview.show(
                  context: context,
                  images: _images,
                  startPosition: 1,
                  closeable: true,
                  closePosition: BetterImagePreviewClosePosition.topLeft,
                );
              },
            ),
            SizedBox(height: 12.bw),
            BetterButton(
              text: '纵向切换'.tr,
              onTap: () {
                BetterImagePreview.show(
                  context: context,
                  images: _images,
                  vertical: true,
                  closeable: true,
                );
              },
            ),
            SizedBox(height: 12.bw),
            BetterButton(
              text: '关闭双击缩放'.tr,
              onTap: () {
                BetterImagePreview.show(
                  context: context,
                  images: _images,
                  doubleScale: false,
                  closeable: true,
                );
              },
            ),
            SizedBox(height: 12.bw),
            BetterButton(
              text: '自定义页码'.tr,
              onTap: () {
                BetterImagePreview.show(
                  context: context,
                  images: _images,
                  indexBuilder: (context, index, total) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.bw,
                        vertical: 5.bw,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14.bw),
                      ),
                      child: Text(
                        '${index + 1} / $total',
                        style: TextStyle(color: Colors.white, fontSize: 14.bsp),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 12.bw),
            BetterButton(
              text: '自定义图片、加载与失败状态'.tr,
              onTap: () {
                BetterImagePreview.show(
                  context: context,
                  images: const [
                    'https://picsum.photos/id/1015/1800/1200',
                    'https://invalid.example.com/not-found.jpg',
                  ],
                  closeable: true,
                  imageBuilder: (context, image, index, child) {
                    return Padding(
                      padding: EdgeInsets.all(20.bw),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.bw),
                        child: child,
                      ),
                    );
                  },
                  loadingBuilder: (context, image, index) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 28.bw,
                            height: 28.bw,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.bw,
                            ),
                          ),
                          SizedBox(height: 10.bw),
                          Text(
                            '正在加载第 @index 张图片'.trParams({
                              'index': '${index + 1}',
                            }),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.bsp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  errorBuilder: (context, image, index) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.white70,
                            size: 40.bw,
                          ),
                          SizedBox(height: 10.bw),
                          Text(
                            '图片加载失败'.tr,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.bsp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
