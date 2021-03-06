import 'package:flutter/material.dart';
import 'package:practice/practice/AnimationExample.dart';
import 'package:practice/practice/BLoCExample.dart';
import 'package:practice/practice/BLoCInheritedWidget.dart';
import 'package:practice/practice/BLoCRxDart.dart';
import 'package:practice/practice/GlobalKeyPractice.dart';
import 'package:practice/practice/ParentWidgetManagesState.dart';
import 'package:practice/practice/ProviderExample.dart';
import 'package:practice/practice/ReduxExample.dart';
import 'package:practice/practice/RouteExample.dart';
import 'package:practice/practice/ScopedModelExample.dart';
import 'package:practice/practice/Test.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

void main() {
  Store<int> store = Store<int>(mainReducer, initialState: 0);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // for Redux
  final Store<int> store;

  MyApp({this.store});

  // @override //for Redux
  // Widget build(BuildContext context) {
  //   return StoreProvider(
  //     store: store,
  //     child: MaterialApp(
  //       title: 'Flutter Demo',
  //       home: StoreConnector(
  //         builder: (BuildContext context, int counter) {
  //           return ReduxExample(counter: counter);
  //         },
  //         converter: (Store<int> store) {
  //           //store的狀態轉變成widget需要的狀態
  //           return store.state;
  //         },
  //       ),
  //       debugShowCheckedModeBanner: false,
  //     ),
  //   );
  // }

// for Provider
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //for Provider
      providers: [
        ChangeNotifierProvider.value(value: CounterChangeNotifier())
      ],
      //在 widget 元件樹中的最上層，使用 provider ，方便傳遞到其他底層頁面
      //建議採用 MultiProvider，因為一個 APP 很少一個 provider 就夠用，所以直接上 MultiProvider 。
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: <String, WidgetBuilder>{
          'RouteExample': (BuildContext context) => RouteExample(),
          '/Screen1': (BuildContext context) => Screen1(),
          '/Screen2': (BuildContext context) => Screen2(),
          '/Screen3': (BuildContext context) => Screen3(),
          '/Screen4': (BuildContext context) => Screen4(),
        },
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> practice = [
    GlobalKeyPractice(),
    ParentWidgetManagesState(),
    Test2(),
    ProviderExample(),
    ScopedModelExample(),
    BLoCExample(),
    BLoCInheritedWidget(),
    BLoCRxDart(),
    RouteExample(),
    AnimationExample(),
  ];
  List<String> practiceTitle = [
    'GlobalKeyPractice',
    'ParentWidgetManagesState',
    'Test',
    'ProviderExample',
    'ScopedModelExample',
    'BLoCExample',
    'BLoCInheritedWidget',
    'BLoCRxDart',
    'RouteExample',
    'AnimationExample',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('你確定要退出嗎？'),
            actions: [
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('退出'),
              ),
              RaisedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('取消'))
            ],
          )),
      child: Scaffold(
          body: ListView.builder(
              itemCount: practice.length,
              itemBuilder: (context, index) {
                return RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => practice[index]));
                  },
                  child: Text(practiceTitle[index]),
                );
              })),
    );
  }
}
