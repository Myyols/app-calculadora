import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';  

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    setState(() {
      _resultado = avaliarExpressao(_expressao).toString(); 
    });
  }

  double avaliarExpressao(String expressao) {
    try {
      ExpressionEvaluator avaliador = const ExpressionEvaluator();
      double resultado = avaliador.eval(Expression.parse(expressao), {});
      return resultado;
    } catch (e) {
     
      Parser p = Parser();
      Expression exp = p.parse(expressao);
      ContextModel cm = ContextModel();
      double resultado = exp.evaluate(EvaluationType.REAL, cm);
      return resultado;
    }
  }

  Widget _botao(String valor) {
    return ElevatedButton(
      onPressed: () => _pressionarBotao(valor),
      child: Text(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _expressao,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  _resultado,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 2,
              children: [
                _botao('7'),
                _botao('8'),
                _botao('9'),
                _botao('/'),
                _botao('4'),
                _botao('5'),
                _botao('6'),
                _botao('*'),
                _botao('1'),
                _botao('2'),
                _botao('3'),
                _botao('-'),
                _botao('0'),
                _botao('.'),
                _botao('='),
                _botao('+'),
                _botao('sin'),
                _botao('cos'),
                _botao('tan'),
                _botao('log'),
                _botao('pow'),
                _botao('mean'),
                _botao('std'),
                _botao('factor'),
              ],
            ),
          ),
          Expanded(
            child: _botao(_limpar),
          )
        ],
      ),
    );
  }
}

      ),
    );
  }
}
