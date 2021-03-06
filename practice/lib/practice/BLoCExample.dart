import 'package:flutter/material.dart';
import 'CounterBLoC.dart';

class BLoCExample extends StatefulWidget {
  @override
  _BLoCExampleState createState() => _BLoCExampleState();
}

class _BLoCExampleState extends State<BLoCExample> {
  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            StreamBuilder(
                stream: _bloc.counter,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text('${snapshot.data}');
                })
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: ()=> _bloc.counterEventSink.add(IncrementEvent()),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: ()=> _bloc.counterEventSink.add(DecrementEvent()),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
