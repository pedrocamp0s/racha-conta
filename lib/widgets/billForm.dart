import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/drinksForm.dart';

class BillForm extends StatefulWidget {
  final bool everybodyDrinks;
  final Function navigateToResultPage;

  BillForm({Key key, this.everybodyDrinks, this.navigateToResultPage})
      : super(key: key);

  @override
  _BillFormState createState() => _BillFormState();
}

class _BillFormState extends State<BillForm> {
  final _controllerForTotal = TextEditingController();
  final _controllerForPercentage = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controllerForTotal.dispose();
    _controllerForPercentage.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  String _validateTotalValueInput(value) {
    String validationResult;

    if (value == null || value.isEmpty) {
      validationResult = 'Digite o valor total da conta';
    } else {
      final n = num.tryParse(value);

      if (n != null && n < 0) {
        validationResult = 'O valor total da conta deve ser positivo';
      }
    }

    return validationResult;
  }

  String _validatePercentageInput(value) {
    String validationResult;

    if (value == null || value.isEmpty) {
      validationResult =
          'Digite a porcentagem da conta que será pago como gorjeta';
    } else {
      final n = num.tryParse(value);

      if (n != null && (n < 0 || n > 100)) {
        validationResult =
            'O valor total da conta deve ser positivo e menor que 100';
      }
    }

    return validationResult;
  }

  @override
  Widget build(BuildContext context) {
    void calculateBill() async {
      if (_formKey.currentState.validate()) {
        if (widget.everybodyDrinks) {
          widget.navigateToResultPage(
            '0',
            _controllerForTotal.text,
            _controllerForPercentage.text,
            _formKey,
          );
        } else {
          var result = await showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    DrinksForm(double.parse(_controllerForTotal.text))
                  ],
                  title: Text('Valor das bebidas'),
                );
              });
          if (result != null) {
            widget.navigateToResultPage(
              result,
              _controllerForTotal.text,
              _controllerForPercentage.text,
              _formKey,
            );
          }
        }
      }
    }

    return Form(
      key: this._formKey,
      child: Column(
        children: [
          Container(
            child: TextFormField(
              controller: this._controllerForTotal,
              decoration: InputDecoration(
                labelText: 'Total da conta',
                errorMaxLines: 2,
              ),
              validator: this._validateTotalValueInput,
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
            margin: EdgeInsets.only(top: 50, left: 100, right: 100, bottom: 20),
          ),
          Container(
            child: TextFormField(
              controller: this._controllerForPercentage,
              decoration: InputDecoration(
                labelText: 'Porcentagem da gorjeta',
                errorMaxLines: 2,
              ),
              validator: this._validatePercentageInput,
              keyboardType: TextInputType.number,
            ),
            margin: EdgeInsets.only(left: 100, right: 100, bottom: 20),
          ),
          Container(
            child: ElevatedButton(
              onPressed: calculateBill,
              child: Text('Calcular conta'),
            ),
          ),
        ],
      ),
    );
  }
}
