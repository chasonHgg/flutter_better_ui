import 'package:flutter/material.dart';
import 'package:flutter_better_ui/better_button.dart';
import 'package:flutter_better_ui/better_skeleton.dart';
import 'package:flutter_better_ui/better_switch.dart';
import 'package:flutter_better_ui/utils/better_screen_util.dart';
import 'package:get/get.dart';

class BetterSkeletonPage extends StatefulWidget {
  const BetterSkeletonPage({super.key});

  @override
  State<BetterSkeletonPage> createState() => _BetterSkeletonPageState();
}

class _BetterSkeletonPageState extends State<BetterSkeletonPage> {
  bool loading = true;

  final List<_ArticleDemoItem> items = List.generate(
    10,
    (index) => _ArticleDemoItem(
      title: 'Better UI 骨架屏示例 ${index + 1}',
      subtitle: index.isEven
          ? '自动读取组件尺寸、圆角和形状，进入屏幕后才参与绘制。'
          : '列表保持 Flutter 原生懒加载逻辑，滚动时才构建可见区域内容。',
      tag: index.isEven ? '组件库' : '加载态',
      color: Colors.primaries[index % Colors.primaries.length],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('骨架屏'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(color: Theme.of(context).dividerColor, height: 1.bw),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.bw, 14.bw, 16.bw, 10.bw),
            child: Row(
              children: [
                Text('Loading', style: TextStyle(fontSize: 14.bsp)),
                SizedBox(width: 10.bw),
                BetterSwitch(
                  width: 44.bw,
                  height: 26.bw,
                  defaultValue: loading,
                  onChanged: (value) {
                    setState(() {
                      loading = value;
                    });
                  },
                ),
                const Spacer(),
                BetterButton(
                  height: 34.bw,
                  padding: EdgeInsets.symmetric(horizontal: 14.bw),
                  text: loading ? '完成请求'.tr : '重新加载'.tr,
                  onTap: () {
                    setState(() {
                      loading = !loading;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BetterSkeletonizer(
              enabled: loading,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(16.bw, 4.bw, 16.bw, 16.bw),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  switch (index % 5) {
                    case 0:
                      return _FeatureArticleCard(item: item);
                    case 1:
                      return _BannerArticleCard(item: item);
                    case 2:
                      return _ProfileUpdateCard(item: item);
                    case 3:
                      return _StatsGridCard(item: item);
                    default:
                      return _CompactNoticeCard(item: item);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureArticleCard extends StatelessWidget {
  final _ArticleDemoItem item;

  const _FeatureArticleCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.bw),
      padding: EdgeInsets.all(12.bw),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.bw),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.bw),
            child: Container(
              width: 72.bw,
              height: 72.bw,
              color: item.color.withAlpha(38),
              child: Image.asset('assets/images/cat.jpeg', fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12.bw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.bsp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.bw),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 13.bsp,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 10.bw),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.bw,
                        vertical: 3.bw,
                      ),
                      decoration: BoxDecoration(
                        color: item.color.withAlpha(28),
                        borderRadius: BorderRadius.circular(12.bw),
                      ),
                      child: Text(
                        item.tag,
                        style: TextStyle(color: item.color, fontSize: 12.bsp),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.favorite, color: item.color, size: 18.bsp),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerArticleCard extends StatelessWidget {
  final _ArticleDemoItem item;

  const _BannerArticleCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.bw),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.bw),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 132.bw,
            width: double.infinity,
            child: Image.asset('assets/images/cat.jpeg', fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(12.bw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16.bsp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.bw),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.bsp, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileUpdateCard extends StatelessWidget {
  final _ArticleDemoItem item;

  const _ProfileUpdateCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.bw),
      padding: EdgeInsets.all(12.bw),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.bw),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.bw,
                backgroundColor: item.color.withAlpha(48),
                backgroundImage: const AssetImage('assets/images/cat.jpeg'),
              ),
              SizedBox(width: 10.bw),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.bsp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.bw),
                    Text(
                      '2 分钟前 · ${item.tag}',
                      style: TextStyle(fontSize: 12.bsp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, size: 20.bsp),
            ],
          ),
          SizedBox(height: 12.bw),
          Text(item.subtitle, style: TextStyle(fontSize: 14.bsp, height: 1.45)),
          SizedBox(height: 12.bw),
          Row(
            children: [
              _SmallAction(icon: Icons.thumb_up_alt_outlined, text: '赞'),
              SizedBox(width: 18.bw),
              _SmallAction(icon: Icons.mode_comment_outlined, text: '评论'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsGridCard extends StatelessWidget {
  final _ArticleDemoItem item;

  const _StatsGridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.bw),
      padding: EdgeInsets.all(12.bw),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.bw),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 15.bsp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.bw),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  color: item.color,
                  label: '浏览',
                  value: '12.8k',
                ),
              ),
              SizedBox(width: 10.bw),
              Expanded(
                child: _MetricTile(
                  color: Colors.teal,
                  label: '转化',
                  value: '86%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompactNoticeCard extends StatelessWidget {
  final _ArticleDemoItem item;

  const _CompactNoticeCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.bw),
      padding: EdgeInsets.symmetric(horizontal: 12.bw, vertical: 10.bw),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.bw),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 36.bw,
            height: 36.bw,
            decoration: BoxDecoration(
              color: item.color.withAlpha(36),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              color: item.color,
              size: 20.bsp,
            ),
          ),
          SizedBox(width: 10.bw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.bsp),
                ),
                SizedBox(height: 4.bw),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.bsp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.bw),
          Icon(Icons.chevron_right, size: 20.bsp),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const _MetricTile({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.bw),
      decoration: BoxDecoration(
        color: color.withAlpha(28),
        borderRadius: BorderRadius.circular(8.bw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12.bsp)),
          SizedBox(height: 8.bw),
          Text(
            value,
            style: TextStyle(fontSize: 20.bsp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _SmallAction extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SmallAction({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.bsp),
        SizedBox(width: 4.bw),
        Text(text, style: TextStyle(fontSize: 12.bsp)),
      ],
    );
  }
}

class _ArticleDemoItem {
  final String title;
  final String subtitle;
  final String tag;
  final Color color;

  const _ArticleDemoItem({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.color,
  });
}
