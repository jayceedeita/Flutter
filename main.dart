import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator with Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: _isLoggedIn
            ? Calculator(logoutCallback: () {
                setState(() {
                  _isLoggedIn = false;
                });
              })
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoggedIn = true;
                  });
                },
                child: Text('Login'),
              ),
      ),
    );
  }
}

class Calculator extends StatelessWidget {
  final VoidCallback logoutCallback;

  Calculator({required this.logoutCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: logoutCallback,
          ),
        ],
      ),
      body: CalculatorWidget(),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _output = '';
  String _currentNumber = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operation = '';
  bool _reset = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (_reset && buttonText != 'C') {
        _output = '';
        _reset = false;
      }

      if (buttonText == 'C') {
        _output = '0';
        _currentNumber = '';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
        _num1 = double.parse(_currentNumber);
        _operation = buttonText;
        _output += buttonText;
        _currentNumber = '';
      } else if (buttonText == '=') {
        _num2 = double.parse(_currentNumber);
        if (_operation == '+') {
          _output = (_num1 + _num2).toString();
        } else if (_operation == '-') {
          _output = (_num1 - _num2).toString();
        } else if (_operation == 'x') {
          _output = (_num1 * _num2).toString();
        } else if (_operation == '/') {
          if (_num2 != 0) {
            _output = (_num1 / _num2).toString();
          } else {
            _output = 'Error';
          }
        }
        _reset = true;
      } else if (buttonText == '.') {
        if (!_currentNumber.contains('.')) {
          _currentNumber += buttonText;
          _output += buttonText;
        }
      } else {
        _currentNumber += buttonText;
        _output += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(20.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            buildButton('7'),
            buildButton('8'),
            buildButton('9'),
            buildButton('/'),
          ],
        ),
        Row(
          children: <Widget>[
            buildButton('4'),
            buildButton('5'),
            buildButton('6'),
            buildButton('x'),
          ],
        ),
        Row(
          children: <Widget>[
            buildButton('1'),
            buildButton('2'),
            buildButton('3'),
            buildButton('-'),
          ],
        ),
        Row(
          children: <Widget>[
            buildButton('.'),
            buildButton('0'),
            buildButton('C'),
            buildButton('+'),
          ],
        ),
        Row(
          children: <Widget>[
            buildButton('='),
          ],
        ),
      ],
    );
  }
}
