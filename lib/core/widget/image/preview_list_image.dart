import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../theme/theme.dart';
import '../../utils/string_utils.dart';
import 'app_image.dart';

class PreviewListImage extends StatefulWidget {
  const PreviewListImage({
    super.key,
    this.initalSelected = 0,
    required this.images,
    this.onChanged,
  });

  final int initalSelected;
  final List<String> images;
  final ValueChanged<int>? onChanged;

  @override
  State<PreviewListImage> createState() => _PreviewListImageState();
}

class _PreviewListImageState extends State<PreviewListImage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      initialIndex: widget.initalSelected,
      length: widget.images.length,
    );
    _controller.addListener(changeState);
  }

  void changeState() => Future.delayed(Duration.zero, () {
        if (mounted) {
          widget.onChanged?.call(_controller.index);
        }
        setState(() {});
      });

  @override
  void dispose() {
    _controller.removeListener(changeState);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: Colors.black,
        actions: const [CloseButton(), SizedBox(width: 8)],
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          TabBarView(
            controller: _controller,
            children: widget.images.map((url) {
              if (StringUtils.isURL(url)) {
                return AppImage(
                  imageURL: url,
                  width: double.infinity,
                  fit: BoxFit.contain,
                );
              } else {
                return AppImage.file(
                  url,
                  color: Colors.black,
                  fit: BoxFit.contain,
                  width: double.infinity,
                );
              }
            }).toList(),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${_controller.index + 1}/${_controller.length}',
                style: context.textStyle.titleMedium,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          height: kToolbarHeight,
          alignment: Alignment.center,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final bool isSelected = _controller.index == index;
              return AnimatedOpacity(
                duration: AppParams.animationDuration,
                opacity: isSelected ? 1 : 0.25,
                child: GestureDetector(
                  onTap: () => _controller.animateTo(index),
                  child: Builder(builder: (context) {
                    if (isSelected) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Scrollable.ensureVisible(
                          context,
                          alignment: 0.5,
                          duration: AppParams.animationDurationFast,
                        );
                      });
                    }
                    if (StringUtils.isURL(widget.images[index])) {
                      return AppImage.square(
                        size: kToolbarHeight,
                        imageURL: widget.images[index],
                      );
                    } else {
                      return AppImage.file(
                        widget.images[index],
                        width: 48,
                        height: 48,
                        borderRadius: BorderRadius.circular(6),
                      );
                    }
                  }),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 4),
            itemCount: widget.images.length,
          ),
        ),
      ),
    );
  }
}
