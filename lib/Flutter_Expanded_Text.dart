import 'package:css_text/css_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key key,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );

        var textSpan = TextSpan(
          style: TextStyle(
            color: widgetColor,
          ),
          children: <TextSpan>[
            HTML.toTextSpan(
              context,
              widget.text,
            ),
          ],
        );

        return Column(
          children: [
            ConstrainedBox(
              constraints: _readMore
                  ? new BoxConstraints(maxHeight: 200.0)
                  : new BoxConstraints(),
              child: RichText(
                softWrap: true,
                overflow: TextOverflow.clip,
                text: textSpan,
              ),
            ),
            RichText(
              text: link,
            ),
          ],
        );
      },
    );
    return result;
  }
}
