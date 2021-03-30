import 'package:flutter/material.dart';

import '../classes/Payer.dart';

class ResultPage extends StatelessWidget {
  final List<Payer> payers;
  final double valueWithoutDrinks;
  final double valueWithDrinks;
  final double valueToWaiter;

  ResultPage(
    this.payers,
    this.valueToWaiter,
    this.valueWithoutDrinks,
    this.valueWithDrinks,
  );

  @override
  Widget build(BuildContext context) {
    void backToHome() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Valores a pagar')),
      body: Column(
        children: [
          Container(
            child: Text(
              'O garçom deve receber R\$ ' +
                  this.valueToWaiter.toStringAsFixed(2) +
                  '.',
              style: TextStyle(fontSize: 30),
            ),
            margin: EdgeInsets.all(30),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(this.payers.length, (index) {
                Payer payer = this.payers[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    children: [
                      Text(
                        payer.name,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      payer.drinks
                          ? Icon(
                              Icons.wine_bar,
                              color: Colors.purple,
                              size: 30,
                            )
                          : Icon(
                              Icons.no_drinks,
                              size: 30,
                            ),
                      payer.drinks
                          ? Text(
                              'R\$ ' + this.valueWithDrinks.toStringAsFixed(2),
                              style: TextStyle(fontSize: 30),
                            )
                          : Text(
                              'R\$ ' +
                                  this.valueWithoutDrinks.toStringAsFixed(2),
                              style: TextStyle(fontSize: 30),
                            ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                );
              }),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: backToHome,
              child: Text('Voltar ao início'),
            ),
            margin: EdgeInsets.only(bottom: 100),
          ),
        ],
      ),
    );
  }
}
