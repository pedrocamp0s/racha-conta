import 'package:flutter/material.dart';

import '../widgets/billForm.dart';
import '../widgets/payerForm.dart';
import '../classes/Payer.dart';
import './result_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Payer> payers = [];
  var redrawObject;

  void _createPayer(payerName, payerDrinks) {
    Payer newPayer = Payer(name: payerName, drinks: payerDrinks);
    this.payers.add(newPayer);
    setState(() {});
  }

  void _removePayer(payer) {
    this.payers.remove(payer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void _navigateToResultPage(
        drinksValue, totalValue, percentageValue, formKey) {
      double totalValueConverted = double.parse(
        totalValue,
      );
      double drinksValueConverted = double.parse(drinksValue);
      double percentageValueConverted = double.parse(percentageValue);

      double valueToWaiter =
          totalValueConverted * (percentageValueConverted / 100);
      double valueWithoutDrinks =
          (totalValueConverted - valueToWaiter - drinksValueConverted) /
              this.payers.length;
      int numberOfDrinkers = this.payers.fold(0, (olderValue, newValue) {
        if (newValue.drinks) {
          return olderValue + 1;
        }
        return olderValue + 0;
      });
      double valueWithDrinks =
          valueWithoutDrinks + (drinksValueConverted / numberOfDrinkers);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            this.payers,
            valueToWaiter,
            valueWithoutDrinks,
            valueWithDrinks,
          ),
        ),
      );
    }

    void _handleNewPayer() {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: [PayerForm(_createPayer)],
              title: Text('Novo pagador'),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Racha Conta'),
      ),
      body: this.payers.length > 0
          ? Column(
              children: [
                BillForm(
                    key: ValueKey<Object>(redrawObject),
                    everybodyDrinks:
                        this.payers.every((element) => element.drinks == true),
                    navigateToResultPage: _navigateToResultPage),
                Expanded(
                  child: ListView.builder(
                    itemCount: this.payers.length,
                    itemBuilder: (context, index) {
                      Payer payer = this.payers[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.only(left: 70, right: 70, top: 30),
                        child: ListTile(
                          leading: payer.drinks
                              ? Icon(
                                  Icons.wine_bar,
                                  color: Colors.purple,
                                )
                              : Icon(Icons.no_drinks),
                          title: Text(
                            payer.name,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _removePayer(payer);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Container(
              child: Center(
                child: Text(
                  'Você ainda não tem nenhum pagador. Crie algum para poder calcular a conta!',
                  textAlign: TextAlign.center,
                ),
              ),
              margin: EdgeInsets.all(50),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleNewPayer,
        label: Text('Novo pagador'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
