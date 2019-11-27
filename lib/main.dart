import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_starbucks/models/coffee.dart';
import 'package:flutter_starbucks/models/store.dart';
import 'package:flutter_starbucks/view/coffee_item.dart';
import 'package:flutter_starbucks/view/store_item.dart';
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Text('전체 메뉴'),
              color: Colors.teal[100],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoreSearchPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Text('매장 검색'),
              color: Colors.teal[200],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Sound of screams but the'),
            color: Colors.teal[300],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Who scream'),
            color: Colors.teal[400],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Revolution is coming...'),
            color: Colors.teal[500],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Revolution, they...'),
            color: Colors.teal[600],
          ),
        ],
      ),
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
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  TabBarView _buildBody() {
    return TabBarView(
      children: <Widget>[
        DrinkPage(),
        StoreSearchPage(),
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
              text: TextSpan(style: TextStyle(color: Colors.white), children: [
                TextSpan(text: '*매장 설정 후, '),
                TextSpan(
                    text: '주문가능 수량', style: TextStyle(color: Colors.yellow)),
                TextSpan(text: '이 표시됩니다.'),
              ]),
            ),
            trailing: Chip(
              backgroundColor: Colors.yellow,
              label: Text('설정'),
            ),
          ),
        )
      ],
    );
  }
}

/// 매장 검색
class StoreSearchPage extends StatefulWidget {
  @override
  _StoreSearchPageState createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  final _filterItems = [
    "DT",
    "리저브",
    "블론드",
    "나이트로 콜드 브루",
    "주차 가능",
    "디카페인",
    "디카페인",
  ];

  var _filterIndex = 0;

  var _storeList = List<Store>();
  var _filteredList = List<Store>();

  List<Widget> _buildFilter() {
    return _filterItems.map((filter) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          child: Text(filter),
          color: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          onPressed: () {},
        ),
      );
    }).toList();
  }

  _getStores() async {
    var url = 'http://54.180.153.12:8000/supplier/';
    var response = await http.get(url);
    print(response.body);

    var jsonArrayObject = json.decode(response.body);

    final items = List<Store>();
    jsonArrayObject.forEach((e) => items.add(Store.fromJson(e)));

    setState(() {
      _storeList = items;
      _filteredList = items;
    });
  }

  @override
  void initState() {
    super.initState();
    _getStores();

//    _getLocation();
  }

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
           children: <Widget>[
              Icon(Icons.arrow_back_ios),
              Text('뒤로', style: TextStyle(fontSize: 17),),
           ],
          ),
        ),
        backgroundColor: Colors.black,
        title: Text('매장 검색'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (text) {
                print(text);
              },
              onChanged: (text) {
                setState(() {
                  _filteredList = _storeList
                      .where((store) => store.address.contains(text))
                      .toList();
                });
              },
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '검색',
              ),
            ),
          ),
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
                      _filteredList.map((store) => StoreItem(store)).toList(),
                ),
                if (_filteredList.length == 0)
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
                text: TextSpan(style: TextStyle(color: Colors.white), children: [
                  TextSpan(text: '*매장 설정 후, '),
                  TextSpan(
                      text: '주문가능 수량', style: TextStyle(color: Colors.yellow)),
                  TextSpan(text: '이 표시됩니다.'),
                ]),
              ),
              trailing: Chip(
                backgroundColor: Colors.yellow,
                label: Text('설정'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
