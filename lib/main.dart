import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayedValue = '';
  String _currentOperation = ''; // Nowa zmienna przechowująca aktualne działanie
  int? _firstOperand;
  String? _operation;
  final List<String> _history = [];

  void _onDigitPressed(String digit) {
    setState(() {
      _displayedValue += digit;
      _currentOperation += digit; // Dodanie cyfry do aktualnego działania
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      _firstOperand = int.parse(_displayedValue);
      _operation = operation;
      _displayedValue = '';
      _currentOperation += ' $operation '; // Dodanie operatora do aktualnego działania
    });
  }

  void _onEqualsPressed() {
    setState(() {
      if (_firstOperand != null && _operation != null) {
        double secondOperand = double.parse(_displayedValue);
        String result;
        switch (_operation) {
          case '+':
            result = (_firstOperand! + secondOperand).toString();
            break;
          case '-':
            result = (_firstOperand! - secondOperand).toString();
            break;
          case '*':
            result = (_firstOperand! * secondOperand).toString();
            break;
          case '/':
            if (secondOperand != 0) {
              result = (_firstOperand! / secondOperand).toString();
            } else {
              result = 'Nie można dzielić przez zero';
            }
            break;
          default:
            result = 'Błąd';
        }

        _currentOperation += ' = $result'; // Dodanie wyniku do aktualnego działania
        _history.add(_currentOperation); // Dodanie aktualnego działania do historii
        _currentOperation = ''; // Resetowanie aktualnego działania
        _firstOperand = null;
        _operation = null;
        _displayedValue = result;
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _displayedValue = '';
      _firstOperand = null;
      _operation = null;
      _currentOperation = ''; // Resetowanie aktualnego działania
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white,
            height: 4.0,
          ),
        ),
        title: const Text(
          'kalkulator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Text(
              _displayedValue,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Text(
              _currentOperation, // Wyświetlenie aktualnego działania nad wynikiem
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildOperationButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildOperationButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildOperationButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildOperationButton('+'),
              _buildEqualsButton(),
            ],
          ),
          const SizedBox(height: 16),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _onDigitPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        fixedSize: const Size(80, 80),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 50,
        ),
      ),
    );
  }

  Widget _buildOperationButton(String operation) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: () => _onOperationPressed(operation),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fixedSize: const Size(80, 80),
        ),
        child: Text(
          operation,
          style: const TextStyle(
            fontSize: 50,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _buildEqualsButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 80, height: 80),
      child: ElevatedButton(
        onPressed: _onEqualsPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          '=',
          style: TextStyle(
            fontSize: 50,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Container(
      margin: const EdgeInsets.only(right: 15.0, bottom: 10.0),
      child: ElevatedButton(
        onPressed: _onClearPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          fixedSize: const Size(80, 80),
        ),
        child: const Text(
          'C',
          style: TextStyle(
            fontSize: 40,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
