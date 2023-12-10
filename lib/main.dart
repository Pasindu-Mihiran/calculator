import 'package:flutter/material.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Calculater()
    );
  }
}

class Calculater extends StatefulWidget {
  const Calculater({super.key});

  @override
  State<Calculater> createState() => _CalculaterState();
}

class _CalculaterState extends State<Calculater> {

  Widget calculation(String bttext , Color btcolor , Color textColor){
      return Container(
        child: ElevatedButton(
          onPressed: (){
              calc(bttext);
          },
          child: Text(
            '$bttext',
            style: TextStyle(
              color: textColor,
              fontSize: 50,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(btcolor),

          ),
        ),
        padding:EdgeInsets.all(15.0),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child:Text(
              "Calculator",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 10
              ),
            ),)
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children:<Widget>[
            Text(
              "$text",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                calculation('AC',Colors.grey.shade400,Colors.black),
                calculation('+/-',Colors.grey.shade400,Colors.black),
                calculation('%',Colors.grey.shade400,Colors.black),
                calculation('/',Colors.amber,Colors.white),
              ],
            ),
            SizedBox(height : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                calculation('7',Colors.grey.shade800,Colors.white),
                calculation('8',Colors.grey.shade800,Colors.white),
                calculation('9',Colors.grey.shade800,Colors.white),
                calculation('x',Colors.amber,Colors.white),
              ],
            ),
            SizedBox(height : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                calculation('4',Colors.grey.shade800,Colors.white),
                calculation('5',Colors.grey.shade800,Colors.white),
                calculation('6',Colors.grey.shade800,Colors.white),
                calculation('-',Colors.amber,Colors.white),
              ],
            ),
            SizedBox(height : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                calculation('1',Colors.grey.shade800,Colors.white),
                calculation('2',Colors.grey.shade800,Colors.white),
                calculation('3',Colors.grey.shade800,Colors.white),
                calculation('+',Colors.amber,Colors.white),
              ],
            ),
            SizedBox(height : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                Expanded(child:
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      calc('0');
                    },
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade800),
                      // shape: StadiumBorder()
                    ),
                  ),
                  padding:EdgeInsets.all(20.0),
                )
                )
                ,
                calculation('.',Colors.grey.shade800,Colors.white),
                calculation('=',Colors.amber,Colors.white),
              ],
            ),
            SizedBox(height : 20),
          ],
        ),
    );
  }
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calc(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}


