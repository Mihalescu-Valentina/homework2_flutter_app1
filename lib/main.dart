import 'package:flutter/material.dart';

void main() {
  runApp(const SquareTriangularApp());
}

class SquareTriangularApp extends StatelessWidget {
  const SquareTriangularApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  createAlertDialog(BuildContext context, int n, String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$n"),
            content: Text(message),
          );
        });
  }

  bool? _checkSquare(int n) {
    for (int i = 0; i <= n / 2; i++) {
      if (i * i == n) {
        return true;
      }
    }
    return false;
  }

  bool? _checkTriangular(int n) {
    for (int i = 0; i <= n / 3; i++) {
      if (i * i * i == n) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(title: const Text("Number Shapes"), centerTitle: true),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  "Please input a number to see if it is square or triangular.",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 20)),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _controller,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a non empty value';
                  }
                  final int? result = int.tryParse(value);
                  if (result == null) {
                    return 'Please enter an integer number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () {
              final bool valid = Form.of(context)!.validate();
              if (valid) {
                final int userinput = int.parse(_controller.text);
                final bool? isSquare = _checkSquare(userinput);
                final bool? isTriangular = _checkTriangular(userinput);
                String message;

                if (isSquare != null &&
                    isSquare == true &&
                    isTriangular != null &&
                    isTriangular == true) {
                  message = "Number $userinput is both SQUARE and TRIANGULAR.";
                  createAlertDialog(context, userinput, message);
                } else if (isSquare != null && isSquare == true) {
                  message = "Number $userinput is a SQUARE!";
                  createAlertDialog(context, userinput, message);
                } else if (isTriangular != null && isTriangular == true) {
                  message = "Number $userinput is TRIANGULAR!";
                  createAlertDialog(context, userinput, message);
                } else if (isSquare != null &&
                    isSquare == false &&
                    isTriangular != null &&
                    isTriangular == false) {
                  message =
                      "Number $userinput is neither SQUARE nor TRIANGULAR.";
                  createAlertDialog(context, userinput, message);
                }
              }
            },
          );
        }),
      ),
    );
  }
}
