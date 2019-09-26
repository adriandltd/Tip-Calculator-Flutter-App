import 'package:flutter/material.dart';

void main()
{
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget
{
  @override
    _State createState() => new _State();
}

class _State extends State<MyApp>
{
  double billAmount = 0.0;
  double tip = 0.0;

  void _onChanged(double value){
    setState((){
      tip = value;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    // Create first input field
    TextField billAmountField = new TextField(
        cursorColor: Colors.pinkAccent,
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          try {
            billAmount = double.parse(value);
          } catch (exception) {
            billAmount = 0.0;
          }
        },
        decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent),),
          labelText: "Bill Amount (\$)",
          labelStyle: new TextStyle(color: Colors.black,fontSize: 25),

        ),
        style: TextStyle(color: Colors.grey[700],fontSize: 25),

    );
    // Create button
    RaisedButton calculateButton = new RaisedButton(
        splashColor: Colors.pink,
        child: new Text("Calculate",
        style: TextStyle(color: Colors.white),),
        color: Colors.pinkAccent,
        onPressed: () {
          // Calculate tip and total
          double calculatedTip = billAmount * (tip/100);
          double total = billAmount + calculatedTip;
          String tipS = calculatedTip.toStringAsFixed(2);
          String tot = total.toStringAsFixed(2);

          // Generate dialog
          AlertDialog dialog = new AlertDialog(
              content: new Text("Tip: \$$tipS \n" "\nTotal: \$$tot\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)));
          // Show dialog
          showDialog(context: context, builder: (BuildContext context) => dialog);
        });

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.pinkAccent,
      title: new Text('Tip Calculator', style: TextStyle(color: Colors.white.withOpacity(1.0)),),
      ),
      body: new Container(
          padding: new EdgeInsets.all(25.0),
          child:new Column(
            children: <Widget>[

              new Text('Tip Percentage',
                  style: TextStyle(color: Colors.black,fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center),
              new Text('${tip.round()}%',
                  style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              new Slider(
                activeColor: Colors.pinkAccent,
                inactiveColor: Colors.pink[100],
                divisions: 5,
                min: 0.0,
                max: 25.0,
                value: tip,
                onChanged: (double value){_onChanged(value);},
              )
              ,billAmountField,
              calculateButton],
        ),
      ),
    );
  }
}
