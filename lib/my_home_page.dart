import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0.obs;

  void _incrementCounter() async {
    _counter++;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("counter", _counter.value);
  }

  void _decrementCounter() async {
    _counter--;
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("counter", _counter.value);
  }

  loadValues() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _counter.value = sp.getInt("counter") ?? 0;
  }

  @override
  void initState() {
    super.initState();
    loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() => Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            )),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: FloatingActionButton(
              key: ValueKey<int>(_counter.value),
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(width: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: FloatingActionButton(
              key: ValueKey<int>(_counter.value - 1),
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MyHomePage(title: 'Flutter Demo Home Page')));
