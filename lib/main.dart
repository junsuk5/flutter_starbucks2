import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starbucks/models/coffee.dart';
import 'package:flutter_starbucks/view/coffee_item.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('전체 메뉴'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Text('음료')),
              Tab(icon: Text('푸드')),
              Tab(icon: Text('상품')),
              Tab(
                  icon: Text(
                '홀케이크 예약',
                style: TextStyle(fontSize: 12),
              )),
            ],
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            DrinkPage(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class DrinkPage extends StatefulWidget {
  @override
  _DrinkPageState createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
  final _filterItems = [
    "추천",
    "콜드 브루",
    "리저브",
    "에스프레소",
    "디카페인",
    "디카페인",
    "디카페인",
    "디카페인",
  ];

  var _filterIndex = 0;

  var _coffeeList = List<Coffee>();

  _buildFilter() {
    final result = List<Widget>();
    for (var i = 0; i < _filterItems.length; i++) {
      if (_filterIndex == i) {
        result.add(
          Chip(
            label: Text(_filterItems[i]),
          ),
        );
      } else {
        result.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _filterIndex = i;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _filterItems[i],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }
    }
    return result;
  }

  _getCoffee() async {
    var url = 'http://54.180.153.12:8000/product/';
    var response = await http.get(url);
    print(response.body);

    var jsonArrayObject = json.decode(response.body);

    final items = List<Coffee>();
    jsonArrayObject.forEach((e) => items.add(Coffee.fromJson(e)));

    setState(() {
      _coffeeList = items;
    });
  }

  @override
  void initState() {
    super.initState();

    _getCoffee();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _buildFilter(),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              ListView(
                children:
                    _coffeeList.map((coffee) => CoffeeItem(coffee)).toList(),
              ),
              if (_coffeeList.length == 0)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[800],
          child: ListTile(
            title: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: '*매장 설정 후, '),
                  TextSpan(text: '주문가능 수량', style: TextStyle(color: Colors.yellow)),
                  TextSpan(text: '이 표시됩니다.'),
                ]
              ),
            ),
            trailing: Chip(
              backgroundColor: Colors.yellow,
              label: Text('설정'),
            ),
          ),
        )
//        Expanded(
//          child: ListView.builder(
//            itemCount: _coffeeList.length,
//            itemBuilder: (context, i) {
//              return CoffeeItem(_coffeeList[i]);
//            },
//          ),
//        ),
      ],
    );
  }
}
