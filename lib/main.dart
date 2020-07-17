import 'package:flutter/material.dart';
import 'Flutter_Expanded_Text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Html_css_text_Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Html_css_text_Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String htmlContent = """
<body>
<p style="font-size:2.5em;color:darkseagreen">This is a test</p>
<p style="font-size:1.8em;color:#ff3311">So is this</p>
<p style="font-size:45px;background:#3311ff;color:yellow">And this!</p><br/>
<br/>
<p style="font-size:1.5em">
Hello <b style="font-style:italic;color:#bb0000;background:#eeff00">World</b>!!
<br/>
How are you <span style="font-family:RobotoBlack;color:#ff0000;">today?</span>
<br/>
<b>But</b> why are you doing <a href="https://google.com">this?</a><br/>
<br/>
<span style="text-decoration: underline wavy; font-size:2em">Can you tell <del>me</del>?</span>
<br/>
Multiple <span style="font-weight:100">font</span> 
<span style="font-weight:600">weights</span><br/><br/>
Please visit <a style="font-weight:bold;" href="https://docs.flutter.io">Flutter docs</a>
</body>
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ExpandableText(htmlContent),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
