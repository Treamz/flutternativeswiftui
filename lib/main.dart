import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _platformChannel = MethodChannel('my_flutter_plugin');


  Future<void> _openSwiftUIView() async {
    try {
      final String result = await _platformChannel.invokeMethod('navigateToNativeView',{"arg1": "value1", "arg2": 123});
      print(result);
    } on PlatformException catch (e) {
      print('Error opening SwiftUI view: $e');
    }
    _platformChannel.setMethodCallHandler((call)  async {
      switch (call.method) {
        case 'onDataReturned':
        // Extract the data sent from Swift
          final dataFromSwift = call.arguments;
          print('Data returned from Swift: $dataFromSwift');
          // Handle the data as needed
          break;
        default:
          print('Unhandled method call from native code: ${call.method}');
          break;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            ElevatedButton(onPressed: _openSwiftUIView, child: Text("Open Native View")),
          ],
        ),
      ),
    );
  }
}
