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
  bool _readMore = true, _toShowReadMore = false;// for onClickLink, for showing button according the value return from checking function


  GlobalKey _keyWidget = GlobalKey();//to init into widget that you want get the size
  Size sizeWidget;//to catch widget value
  double RichTextHeight;//Height will change according content

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  _afterLayout(_) async {
    await _getSizes();
  }

  _getSizes() {
    final RenderBox renderBoxRed = _keyWidget.currentContext.findRenderObject();
    sizeWidget = renderBoxRed.size;
    setState(() {
      RichTextHeight = sizeWidget.height * 0.80; //first init height
    });
  }

  getWidgetHeight() {
    if (sizeWidget != null)
      RichTextHeight = sizeWidget.height * 0.80; //customize height here
    else
      RichTextHeight =
          150; //to prevent null value error only, it get the value from getSize
    return RichTextHeight;
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
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          maxLines: 5, //max line of html content
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
                  ? new BoxConstraints()  //if under 5 lines
                  : _readMore //for content more than 5 line
                      ? new BoxConstraints(maxHeight: getWidgetHeight())
                      : new BoxConstraints(), //onClicked  button
              child: RichText(
                key: _keyWidget, //key to get size
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
