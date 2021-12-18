import 'package:flutter/material.dart';
//import 'package:fucky/animatewidget/annimate.dart';
import 'package:fucky/sidebarbutton/sidebarbutton.dart';
import 'package:fucky/languagepop/languagepop.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

//final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '献出牛子',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: '康康牛子'),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ADick {
  final String name;
  final List<String> dick;
  ADick({
    required this.name,
    required this.dick,
  });
  factory ADick.fromJson(dynamic json) => ADick(
        name: json["name"],
        dick: (json["trans"] as List).map((e) => e as String).toList(),
      );
}

class Dick {
  final List<ADick> dicks;
  Dick({required this.dicks});
  factory Dick.fromJson(dynamic json) =>
      Dick(dicks: (json as List).map((e) => ADick.fromJson(e)).toList());
}

Future<Dick> createAlbum(String input) async {
  var re = RegExp(r"([a-zA-z0-9]{2,})+");
  String input2 = "";
  Iterable<RegExpMatch> matches = re.allMatches(input);
  for (var match in matches) {
    input2 += "${match.group(0)},";
  }

  var postback = await http.post(
    Uri.parse('https://lab.magiconch.com/api/nbnhhsh/guess'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'text': input2,
    }),
  );
  //print(postback.body);
  return Dick.fromJson(jsonDecode(postback.body));
  //print(mm);
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  int _index = 0;
  String _name = "hhsh";
  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  final _controller = TextEditingController();
  final list = ['牛子', 'News', '关于'];
  //final Future<String> _panel =
  //    Future<String>.delayed(const Duration(seconds: 3), () => 'Data loaded');

  //final Future<Dick> _panel = createAlbum('hhsh,yyds,xz,yysy,shzy,ybb,xxs,yxs,xswl');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // with builder , I can get the context of this widget, then I can set the state
        leading: Builder(builder: (context) {
          return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); //打开开始方向抽屉布局
              });
        }),

        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Input search',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _name = _controller.text;
                        });
                      },
                      icon: const Icon(Icons.send))),
              onFieldSubmitted: (String value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            FutureBuilder<Dick>(
              future: createAlbum(
                  _name), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<Dick> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = (snapshot.data as Dick)
                      .dicks
                      .map((e) => ExpansionTile(
                            title: Text(e.name),
                            children: e.dick.map((e) => Text(e)).toList(),
                          ))
                      .toList();
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: children,
                  ),
                );
              },
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            for (final item in list)
              ListTile(
                title: Text(item),
                onTap: () {
                  Navigator.pop(context);
                  _navigateAndDisplaySelection(context);
                },
              ),
            ListTile(
              title: const Text('Language'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => LanguagePop(
                    index: _index,
                  ),
                ).then((value) {
                  if (value is List) {
                    var name = value[1];
                    var index = value[0];
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text('$name')));
                    setState(() {
                      _index = index;
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '牛子'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: '详情'),
        ],
      ),
    );
  }
}
