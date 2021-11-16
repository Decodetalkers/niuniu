import 'package:flutter/material.dart';

class LanguagePop extends StatefulWidget {
  final int index;
  final languages = ['zh', 'zh-TW', 'EN', 'JP'];
  LanguagePop({Key? key, required this.index}) : super(key: key);
  @override
  State<LanguagePop> createState() => _LanguagePopState();
}

class _LanguagePopState extends State<LanguagePop> {
  late int _index;
  //LanguagePop({Key? key}) : super(key: key);
  // here to get the index from up class
  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.fromLTRB(100, 200, 100, 200),
        child: Container(
            //decoration:
            //    BoxDecoration(color: const Color(0xFFFFFFFF).withOpacity(1)),
            margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            width: 1000,
            child: Column(
                children: widget.languages
                    .asMap()
                    .map((i, item) => MapEntry(
                        i,
                        CheckboxListTile(
                            title: Text(item),
                            value: i == _index,
                            onChanged: (val) {
                              Navigator.pop(context, [i, item]);
                              if (i != _index) {
                                setState(() {
                                  _index = i;
                                });
                              }
                            })))
                    .values
                    .toList())));
  }
}
