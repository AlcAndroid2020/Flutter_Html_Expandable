import 'package:flutter/material.dart';
import 'package:flutterhtmlcssexample/Flutter_Exapnded_Text_Max_Height.dart';
import 'Flutter_Expanded_Text_Max_Lines.dart';

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
  String htmlContent = """<p>This is a test</p>
<p >So is this</p>
<p>This is a test</p>
<p >So is this</p>
<p>This is a test</p>
<p>This is a test</p>
<p>This is a test</p>
<p >So is this</p>
<p>This is a test</p>
<p >So is this</p>
<p>This is a test</p>
<p>This is a test</p>
<p>This is a test</p>
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
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10),
                child: Text("Max Line",style: TextStyle(color: Colors.red,fontSize: 15),),
              ),
              Container(
                child: ExpandableWithMaxLines(htmlContent),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10),
                child: Text("Max height",style: TextStyle(color: Colors.red,fontSize: 15),),
              ),
              Container(
                child: ExpandableWithMaxHeight(htmlContent),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
