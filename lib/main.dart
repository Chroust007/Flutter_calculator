import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: "Kalkulajda",
      theme: ThemeData(
        textTheme: const TextTheme(
            button: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal),
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Hind')),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              minimumSize: Size(80, 80),
              padding: EdgeInsets.all(10),
              primary: Colors.black,
              backgroundColor: Colors.lightBlue.shade50),
        ),
      ),
      home: StartPage(),
    );
    return materialApp;
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double count = 0;
  String valueDisplay = "Hello";
  double oldvalue = 0;
  String operator = "";
  String newValue = "";

// ********************* prcedure pro psaní čísla z numereckých kláves

  void pisCislo(String value) {
    setState(() {
      if (value == "<") {
        if (newValue.length == 0) return;
        newValue = newValue.substring(0, newValue.length - 1);
        value = "";
      }
      if (value == "C") {
        newValue = "";
      }

      if (newValue.length > 7) return;

      if (value == "." && newValue.contains(".")) return;
      newValue = newValue + "" + value;
      //numberFormat(newValue);

      valueDisplay = newValue; //numberFormat(newValue);
    });
  }

// ******************************* prcedure počítání

  void pocitej(var value, String sentOperator) {
    setState(() {
      // operatory

      if (sentOperator == "CLR") {
        count = 0;
        oldvalue = 0;
        newValue = "";
        operator = "";
        valueDisplay = "";
        value = "";
        return;
      }

      if (sentOperator == "C") {
        newValue = "";
        valueDisplay = "";
        value = "";
        return;
      }

      // přečti hodnotu na displeji

      if (newValue == "") {
        operator = sentOperator;
        return;
      }

      count = double.parse(newValue);

      // pokud už byl operátor zadaný, spočítej to
      if (operator != "") {
        if (operator == "+") {
          count = oldvalue + count;
        }
        if (operator == "-") {
          count = oldvalue - count;
        }
        if (operator == "x") {
          count = oldvalue * count + 111;
        }
        if (operator == "/") {
          count = oldvalue / count;
        }
        valueDisplay = numberFormat(count.toString(), count);
      }
      operator = sentOperator;

      if (sentOperator == "=") {
        operator = "";
      }
      oldvalue = count;
      newValue = "";
    });
  }

  // ************************************** Funkce formátuj do displaye

  numberFormat(String displayNumber, double count) {
    // Preved cislo na 8 ztanků
    displayNumber = count.toStringAsPrecision(8);

    // když obsahuje desetinou značku, tak ho zkrat na 7
    if (displayNumber.contains("."))
      displayNumber = count.toStringAsPrecision(7);

    // když opsahuje esponent, zkrať ho na 3
    if (displayNumber.contains("e"))
      displayNumber = count.toStringAsPrecision(3);

    return displayNumber;
  }

// ****************************************************************
// ****************************************************************
// ****************************************************************
// ******************** [  Hlavní widget  ] ***********************
// ****************************************************************
// ****************************************************************
// ****************************************************************

  @override
  Widget build(BuildContext context) {
    // definice rozestupů
    var mySpacer = SizedBox(width: 10, height: 10);
    // sestavení kalkulačky
    var calculator = [
      mySpacer,
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            alignment: Alignment.centerRight,
            width: 350,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Colors.black26,
            child: Text("$valueDisplay",
                style: TextStyle(fontFamily: 'DS-Digital', fontSize: 80))),
      ),
      mySpacer,
      mySpacer,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.black38),
              onPressed: () => {pisCislo("<")},
              child: Text(
                "BCK",
                style: TextStyle(color: Colors.white),
              )),
          mySpacer,
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.black12),
              onPressed: () => {pocitej(0, "C")},
              child: Text(
                "C",
                style: TextStyle(color: Colors.white),
              )),
          mySpacer,
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.black12),
              onPressed: () => {pocitej(0, "CLR")},
              child: Text(
                "AC",
                style: TextStyle(color: Colors.white),
              )),
          mySpacer,
          TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
              onPressed: () => {pocitej(0, "/")},
              child: Text(
                "/",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      mySpacer,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(onPressed: () => {pisCislo("7")}, child: Text("7")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("8")}, child: Text("8")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("9")}, child: Text("9")),
          mySpacer,
          TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
              onPressed: () => {pocitej(0, "x")},
              child: Text(
                "X",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      mySpacer,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(onPressed: () => {pisCislo("4")}, child: Text("4")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("5")}, child: Text("5")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("6")}, child: Text("6")),
          mySpacer,
          TextButton(
            style:
                TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
            onPressed: () => {pocitej(0, "-")},
            child: Text(
              "-",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      mySpacer,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Padding(padding: EdgeInsets.all(40)),
          TextButton(onPressed: () => {pisCislo("1")}, child: Text("1")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("2")}, child: Text("2")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("3")}, child: Text("3")),
          mySpacer,
          TextButton(
            style:
                TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
            onPressed: () => {pocitej(0, "+")},
            child: Text(
              "+",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      mySpacer,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(onPressed: null, child: Text(" ")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo("0")}, child: Text("0")),
          mySpacer,
          TextButton(onPressed: () => {pisCislo(".")}, child: Text(".")),
          mySpacer,
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () => {pocitej(0, "=")},
            child: Text(
              "=",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      mySpacer,
      /*
      Text("------------------- debug -------------------------"),
      Text("Oper: $operator Count: $count       "),
      Text("Oldvalue: $oldvalue / newv: $newValue ")
      */
    ];

    return Scaffold(
        appBar: new AppBar(
          leading: const IconButton(onPressed: null, icon: Icon(Icons.menu)),
          title: Text("Flutter Calculator"),
          actions: [
            //  Image(image: FileImage(File("web/icons/Icon-512.png"))),
            //const IconButton(onPressed: null, icon: Icon(Icons.cottage)),
          ],
        ),
        body: Center(
            child: Column(

                //crossAxisAlignment: cen, //MainAxisSize.min, //hgjg
                children: calculator)));
  }
}
