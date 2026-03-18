import 'package:flutter/material.dart';

class Top3SkeletonSection extends StatelessWidget {
  const Top3SkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: Row(
            children: [
              _SkeletonBox(width: 18, height: 18, radius: 9),
              SizedBox(width: 8),
              _SkeletonBox(width: 110, height: 16, radius: 8),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return const _Top3SkeletonCard();
            },
          ),
        ),
      ],
    );
  }
}

class _Top3SkeletonCard extends StatelessWidget {
  const _Top3SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _SkeletonBox(width: 34, height: 34, radius: 17),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    _SkeletonBox(width: double.infinity, height: 14, radius: 7),
                    SizedBox(height: 6),
                    _SkeletonBox(width: 140, height: 14, radius: 7),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SkeletonBox(width: 60, height: 30, radius: 15),
              _SkeletonBox(width: 90, height: 30, radius: 15),
              _SkeletonBox(width: 70, height: 30, radius: 15),
            ],
          ),
          SizedBox(height: 14),
          _SkeletonBox(width: double.infinity, height: 12, radius: 6),
          SizedBox(height: 8),
          _SkeletonBox(width: double.infinity, height: 12, radius: 6),
          SizedBox(height: 8),
          _SkeletonBox(width: 120, height: 12, radius: 6),
          Spacer(),
          _SkeletonBox(width: 120, height: 34, radius: 12),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final double radius;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  State<_SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<_SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.35, end: 0.75).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = widget.width == double.infinity
        ? null
        : widget.width;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: effectiveWidth,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        );
      },
    );
  }
}
