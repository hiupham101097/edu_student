import 'package:edu_student/system/_variables/value/app_style.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _isOverflowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkOverflow();
  }

  void _checkOverflow() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: widget.style ?? DefaultTextStyle.of(context).style,
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(
      maxWidth: MediaQuery.of(context).size.width - 32,
    ); // trừ padding nếu cần

    setState(() {
      _isOverflowing = textPainter.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style,
          maxLines: _expanded ? null : widget.maxLines,
          overflow: TextOverflow.fade,
        ),
        if (_isOverflowing)
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _expanded ? 'Thu gọn' : 'Xem thêm ',
                    style: TextStyle(
                      color: AppStyle.colors[1][6],
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.arrow_upward : Icons.arrow_downward,
                    color: AppStyle.colors[1][6],
                    size: 12.0,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
