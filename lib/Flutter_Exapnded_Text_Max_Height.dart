import 'package:css_text/css_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableWithMaxHeight extends StatefulWidget {
  const ExpandableWithMaxHeight(
    this.text, {
    Key key,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  ExpandableWithMaxHeightState createState() => ExpandableWithMaxHeightState();
}

class ExpandableWithMaxHeightState extends State<ExpandableWithMaxHeight> {
  bool _readMore = true,
      _toShowReadMore =
          false; // for onClickLink, for showing button according the value return from checking function

  double height; //Height will change according content

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
        height =
            MediaQuery.of(context).size.height; //get height of whole layout

        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );

        if (height > 150) {
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
                  ? new BoxConstraints() //if under 150 height
                  : _readMore //for content more than 150 height
                      ? new BoxConstraints(maxHeight: 150)
                      : new BoxConstraints(), //onClicked  button
              child: RichText(
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
