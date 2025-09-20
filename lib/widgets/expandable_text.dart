import 'package:flutter/material.dart';

/// A simple expandable/collapsible text widget with "Read more / Read less" toggle.
class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String expandLabel;
  final String collapseLabel;
  final TextStyle? linkStyle;
  final EdgeInsetsGeometry linkPadding;

  const ExpandableText(
    this.text, {
    super.key,
    this.maxLines = 4,
    this.style,
    this.textAlign,
    this.expandLabel = 'Read more',
    this.collapseLabel = 'Read less',
    this.linkStyle,
    this.linkPadding = const EdgeInsets.only(top: 8),
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _isOverflowing = false;
  double? _lastMeasuredWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recalculate overflow when dependencies change (e.g., theme/text scale).
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureOverflow());
  }

  @override
  void didUpdateWidget(covariant ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.maxLines != widget.maxLines ||
        oldWidget.style != widget.style) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _measureOverflow());
    }
  }

  void _measureOverflow([double? maxWidth]) {
    final textSpan = TextSpan(text: widget.text, style: widget.style);
    final tp =
        TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(
          maxWidth:
              maxWidth ??
              context.size?.width ??
              MediaQuery.of(context).size.width,
        );

    final didOverflow = tp.didExceedMaxLines;
    if (didOverflow != _isOverflowing) {
      setState(() => _isOverflowing = didOverflow);
    }
  }

  @override
  Widget build(BuildContext context) {
    final linkTextStyle =
        widget.linkStyle ??
        Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Ensure we re-measure when width changes
        if (_lastMeasuredWidth != constraints.maxWidth) {
          _lastMeasuredWidth = constraints.maxWidth;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _measureOverflow(constraints.maxWidth),
          );
        }

        return Column(
          crossAxisAlignment: _getAlignment(),
          children: [
            Text(
              widget.text,
              style: widget.style,
              textAlign: widget.textAlign,
              maxLines: _expanded ? null : widget.maxLines,
              overflow: _expanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (_isOverflowing)
              Padding(
                padding: widget.linkPadding,
                child: InkWell(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _expanded ? widget.collapseLabel : widget.expandLabel,
                        style: linkTextStyle,
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: linkTextStyle?.color,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  CrossAxisAlignment _getAlignment() {
    switch (widget.textAlign) {
      case TextAlign.center:
        return CrossAxisAlignment.center;
      case TextAlign.right:
      case TextAlign.end:
        return CrossAxisAlignment.end;
      case TextAlign.left:
      case TextAlign.start:
      default:
        return CrossAxisAlignment.start;
    }
  }
}
