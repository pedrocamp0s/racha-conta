import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrinksForm extends StatefulWidget {
  final double billTotalValue;

  DrinksForm(this.billTotalValue);

  @override
  _DrinksFormState createState() => _DrinksFormState();
}

class _DrinksFormState extends State<DrinksForm> {
  final _myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  String _validateTotalDrinksInput(value) {
    String validationResult;

    if (value == null || value.isEmpty) {
      validationResult = 'Digite o valor referente às bebidas';
    } else {
      final n = num.tryParse(value);

      if (n != null && (n < 0 || n > widget.billTotalValue)) {
        validationResult =
            'O valor referente às bebidas não pode ser maior que R\$ ' +
                widget.billTotalValue.toString() +
                ', nem negativo';
      }
    }

    return validationResult;
  }

  @override
  Widget build(BuildContext context) {
    void _confirmDrinksValue() {
      if (_formKey.currentState.validate()) {
        Navigator.pop(context, _myController.text);
      }
    }

    void _cancel() {
      Navigator.pop(context);
    }

    return Form(
      key: this._formKey,
      child: Column(
        children: [
          Container(
            child: TextFormField(
              controller: this._myController,
              decoration: InputDecoration(
                labelText: 'Valor gasto em bebidas',
                errorMaxLines: 2,
              ),
              validator: this._validateTotalDrinksInput,
              keyboardType: TextInputType.number,
            ),
            margin: EdgeInsets.all(20),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _confirmDrinksValue,
                  child: Text('Confirmar'),
                ),
                margin: EdgeInsets.all(10),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: _cancel,
                  child: Text('Cancelar'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
