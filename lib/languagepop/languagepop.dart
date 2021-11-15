import 'package:flutter/material.dart';
class LanguagePop extends StatelessWidget {
	final languages = ['zh','zh-TW'];
	LanguagePop({Key? key}) :super(key:key);
	@override
	Widget build(BuildContext context) {
		//return CustomScrollView(
		//	slivers: <Widget>[
		//		for (final item in languages)
		//			ListTile(title: Text(item)),
		//	],
		//);
		return MaterialApp(
      title: 'hello',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('hello'),
        ),
        body: ListView(
						children: [
								for (final item in languages)
									ListTile(title: Text(item)),
						]
				),
			)
		);
	}
}
