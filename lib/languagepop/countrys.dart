import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
Widget _buildIcon(String image) {
	return SvgPicture.asset(
			image,
			height: 100,
			width: 250,
			fit: BoxFit.fill,
	);
}
List<Widget> countrys = [
	_buildIcon('assets/countrys/cn.svg'),
	_buildIcon('assets/countrys/tw.svg'),
	_buildIcon('assets/countrys/mo.svg'),
	_buildIcon('assets/countrys/hk.svg'),
	_buildIcon('assets/countrys/hm.svg'),
	_buildIcon('assets/countrys/bt.svg'),
	_buildIcon('assets/countrys/cv.svg'),
	_buildIcon('assets/countrys/eu.svg'),
	_buildIcon('assets/countrys/gi.svg'),
	_buildIcon('assets/countrys/aw.svg'),
];
