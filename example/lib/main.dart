import 'package:flutter/material.dart';
import 'package:fv_toast/fv_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toast example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Toast example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click to button to show toast message',
            ),
            ElevatedButton(
                onPressed: () {
                  // FvToast.of(context).show(ToastStatuses.success, 'Success!');
                  FvToast.of(context).showSuccess();
                },
                child: const Text('Success')),
            ElevatedButton(
                onPressed: () {
                  // FvToast.of(context).show(ToastStatuses.error, 'Error!');
                  FvToast.of(context).showError();
                },
                child: const Text('Error')),
            ElevatedButton(
                onPressed: () {
                  // FvToast.of(context).show(
                  //     ToastStatuses.message, 'The dictionary already exists.');
                  FvToast.of(context)
                      .showMessage('The dictionary already exists.');
                },
                child: const Text('Message')),
          ],
        ),
      ),
    );
  }
}
