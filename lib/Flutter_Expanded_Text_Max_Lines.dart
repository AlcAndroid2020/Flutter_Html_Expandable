import 'package:css_text/css_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableWithMaxLines extends StatefulWidget {
  const ExpandableWithMaxLines(
    this.text, {
    Key key,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  ExpandableWithMaxLinesState createState() => ExpandableWithMaxLinesState();
}

class ExpandableWithMaxLinesState extends State<ExpandableWithMaxLines> {
  bool _readMore = true,
      _toShowReadMore =
          false; // for onClickLink, for showing button according the value return from checking function
  //to catch widget value
  double height;

  @override
  void initState() {
    super.initState();
  }

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
        height = MediaQuery.of(context).size.height;

        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          maxLines: 6, //max line of html content
        );
        textPainter.layout(
          minWidth: constraints.minWidth,
          maxWidth: maxWidth,
        );
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);

        if (textPainter.didExceedMaxLines) {
          _toShowReadMore = true; //more than max lines
        } else {
          _toShowReadMore = false; //less than max line
        }

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
              constraints: !_toShowReadMore
                  ? new BoxConstraints() //if under 5 lines
                  : _readMore //for content more than 5 line
                      ? new BoxConstraints(maxHeight: 80)
                      : new BoxConstraints(), //onClicked  button
              child: RichText(
                //key to get size
                softWrap: true,
                overflow: TextOverflow.clip,
                text: textSpan,
              ),
            ),
            _toShowReadMore
                ? RichText(
                    text: link,
                  )
                : Container(),
          ],
        );
      },
    );
    return result;
  }
}
