import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(KalkulatorPkl());
}
class KalkulatorPkl extends StatelessWidget{
@override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kalkulator',
      debugShowCheckedModeBanner: false,
      home:  CalculatorPage(),
    );
  }}
class CalculatorPage extends StatefulWidget {
 @override 
  _CalculatorPageState createState() => _CalculatorPageState(); 
}
class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _result = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E), 
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
            flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Color(0xFFB9D2D2), 
             child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Digital',
                      ),
                    ),
                  ],
                ),
              ),
            ),

        SizedBox(height: 120,),

            Expanded(
              flex: 5,
              child: buildButtons(),
            ),
          ],
        ),
      ),
    );
  }
Widget buildButtons () {
  final buttons = [
    ['AC', '()', '%', '/'],
      ['7', '8', '9', 'x'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', 'C', '='],
  ];
   return Column(
      children: buttons.map((row) {
        return Expanded(
          child: Row(
            children: row.map((text) {
             return Expanded(
           child: Padding(
           padding: const EdgeInsets.all(6),
            child: ElevatedButton(
             onPressed: () => onButtonPressed(text),
              style: ElevatedButton.styleFrom(backgroundColor: getButtonColor(text),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Center(
                      child: Text(
                        text,
                      style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: getTextColor(text),
                    ),
                    ),
                    ),
                ),
              ),
            );
          }).toList(),
          ),
        );
      }).toList(),
    );
}
Color getButtonColor(String text) {
  if(text == 'AC' || text == 'C') return Colors.red.shade400;
  if(text == 'AC') return Colors.yellow.shade600;
  if(text == 'AC') return Colors.redAccent.shade200;
  if (text == '()' || text == '%' ) return Colors.teal.shade300;
  if(text == 'x' || text == '-' || text == '/' || text == '+') return Colors.blue.shade700;
  if (text == '=') return Colors.yellow;
  return Color(0xFFDCEAE9);
}
Color getTextColor(String text) {
  if(text == '=' || text == 'AC' || text == 'C' );
  return Colors.black;
}
void onButtonPressed(String text) {
    setState(() {
      if (text == 'AC') {
        _input = '';
        _result = '0';
      } else if (text == 'C') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (text == '=') {
        hasil();
      } 
       else {
        _input += (text == 'x') ? '*' : text;
      }
    });
  }
 void hasil() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _result = eval.toStringAsFixed(0);
    } catch (_) {
      _result = 'Gabisa';
    }
  }
}