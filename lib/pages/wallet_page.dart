import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WalletPage extends StatefulWidget {
  final MainModel _model;

  WalletPage(this._model);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  initState() {
    widget._model.fetchWallet();
    super.initState();
  }

  Widget _buildWalletLogDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            iconSize: 30.0,
            onPressed: () {}),
        Column(children: <Widget>[
          Text('myWallet',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          Text('January 2018',
              style: TextStyle(color: Colors.white, fontSize: 16.0))
        ]),
        IconButton(
            icon: Icon(Icons.equalizer, color: Colors.white),
            iconSize: 30.0,
            onPressed: () {})
      ],
    );
  }

  Widget _buildWalletBalance(MainModel model) {
    return model.wallet == null
        ? CircularProgressIndicator()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('GHc',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 10.0,
              ),
              Text(
                  model.wallet != null
                      ? model.wallet.balance.toString()
                      : '0.0',
                  style: TextStyle(color: Colors.white, fontSize: 60.0)),
            ],
          );
  }

  Widget _buildWalletIncomeAndExpenditure() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.arrow_downward,
            color: Colors.green,
            size: 30.0,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Text(
                'Credit',
                style: TextStyle(color: Colors.white),
              ),
              Text('GHc1.48',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        SizedBox(width: 50),
        Container(
          child: Icon(
            Icons.arrow_upward,
            color: Colors.red,
            size: 30.0,
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Text(
                'Debit',
                style: TextStyle(color: Colors.white),
              ),
              Text('GHc1.48',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ],
    );
  }

  Widget _builHeaderStack(BuildContext context, MainModel model) {
    return Stack(
      children: <Widget>[
        Container(
          height: 350.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          bottom: 50.0,
          right: 100.0,
          child: Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              color: Color.fromRGBO(0, 25, 45, .40),
            ),
          ),
        ),
        Positioned(
          bottom: 150.0,
          left: 250.0,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Color.fromRGBO(0, 25, 45, .40)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
          child: Column(
            children: <Widget>[
              _buildWalletLogDate(),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(59, 70, 80, 1),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text('Current Balance',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 40.0),
              _buildWalletBalance(model),
              SizedBox(height: 40.0),
              _buildWalletIncomeAndExpenditure(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTransactionLog(
      String transaction, String transactionDate, String account) {
    return Material(
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(transactionDate, style: TextStyle(color: Colors.grey)),
                Text(transaction,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                Text(account, style: TextStyle(color: Colors.grey))
              ],
            ),
            Container(
                child: Row(
              children: <Widget>[
                Text('-19',
                    style: TextStyle(fontSize: 35.0, color: Colors.red)),
                Text('.99', style: TextStyle(color: Colors.red))
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text('myWallet',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 25.0,
                //                 fontWeight: FontWeight.bold)),
                background: _builHeaderStack(context, model),
                collapseMode: CollapseMode.pin,
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _buildTransactionLog('Withdrawal', '08/11/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Deposit', '06/5/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
                SizedBox(height: 10.0),
                _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
              ]),
            )
          ],
        );
      },
    );

    // ListView(
    //   children: <Widget>[
    //     Column(
    //       children: <Widget>[
    //         _builHeaderStack(context),
    //         SizedBox(height: 20.0),
    //         _buildTransactionLog('Withdrawal', '08/11/2018', 'My Account'),
    //         SizedBox(height: 10.0),
    //         _buildTransactionLog('Deposit', '06/5/2018', 'My Account'),
    //         SizedBox(height: 10.0),
    //         _buildTransactionLog('Withdrawal', '02/02/2018', 'My Account'),
    //         SizedBox(height: 10.0),
    //       ],
    //     ),
    //   ],
    // );
  }
}
