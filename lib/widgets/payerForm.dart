import 'package:flutter/material.dart';

class PayerForm extends StatefulWidget {
  final Function _createPayer;

  PayerForm(this._createPayer);

  @override
  _PayerFormState createState() => _PayerFormState();
}

class _PayerFormState extends State<PayerForm> {
  final _myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _drinks = false;

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  String _validateTotalValueInput(value) {
    String validationResult;

    if (value == null || value.isEmpty) {
      validationResult = 'Digite um nome válido';
    }

    return validationResult;
  }

  void _create() {
    if (_formKey.currentState.validate()) {
      widget._createPayer(_myController.text, _drinks);
      _myController.clear();
      Navigator.pop(context);
    }
  }

  void _handleSwitchChange(value) {
    setState(() {
      _drinks = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  labelText: 'Nome do pagador',
                  errorMaxLines: 2,
                ),
                validator: this._validateTotalValueInput),
            margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
          ),
          Container(
            child: Row(
              children: [
                Text('Bebe?'),
                Switch(
                  value: this._drinks,
                  onChanged: this._handleSwitchChange,
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _create,
                  child: Text('Criar pagador'),
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
