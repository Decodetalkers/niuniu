import 'package:flutter/material.dart';
import 'countrys.dart';

class LanguagePop extends StatefulWidget {
  final int index;

  const LanguagePop({Key? key, required this.index}) : super(key: key);
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
        insetPadding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Container(
            //decoration:
            //    BoxDecoration(color: const Color(0xFFFFFFFF).withOpacity(1)),
            margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            width: 1000,
            child: Column(children: [
              Expanded(
                child: ListView(
                    children: countrys
                        .asMap()
                        .map((i, item) => MapEntry(
                            i,
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Spacer(),
                                  item,
                                  const Spacer(),
                                  Checkbox(
                                      value: i == _index,
                                      onChanged: (val) {
                                        //Navigator.pop(context, [i, item]);
                                        if (i != _index) {
                                          setState(() {
                                            _index = i;
                                          });
                                        }
                                      })
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              )
                            ])))
                        .values
                        .toList()),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      //BorderRadius.only(bottomLeft: Radius.circular(6)),
                      color: Colors.lightBlueAccent,
                    ),
                    height: 45,
                    child: TextButton(
                      child: const Text('cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.lightBlueAccent,
                    ),
                    height: 45,
                    child: TextButton(
                      child: const Text('conferm'),
                      onPressed: () {
                        Navigator.pop(context, [_index, countrys[_index]]);
                      },
                    ))
              ])
            ])));
  }
}
