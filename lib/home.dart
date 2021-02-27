import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

// Home Page State of the Application //
class HomePageState extends State<HomePage> {


  // constant characters for each player
  static const String HUMAN_PLAYER = "X";
  static const String COMPUTER_PLAYER = "O";
  // Initial Text for infoLabel
  String _text = "X's Turn";

  // constant for board size
  static const BOARD_SIZE = 9;

  // Game Variables
  var gameOver = false;
  var win = 0;
  //var turn = 0;
  var _mBoard = ["", "", "", "", "", "", "", "", ""];
  var rnd = new Random(BOARD_SIZE);


// Game Code

 // Computer Move
  int checkWinner() {
    // Check horizontal wins
    for (int i = 0; i <= 6; i += 3) {
      if (_mBoard[i] == (HUMAN_PLAYER) &&
          _mBoard[i + 1] == (HUMAN_PLAYER) &&
          _mBoard[i + 2] == (HUMAN_PLAYER)) return 2;

      if (_mBoard[i] == (COMPUTER_PLAYER) &&
          _mBoard[i + 1] == (COMPUTER_PLAYER) &&
          _mBoard[i + 2] == (COMPUTER_PLAYER)) return 3;
    }

    // Check vertical wins
    for (int i = 0; i <= 2; i++) {
      if (_mBoard[i] == (HUMAN_PLAYER) &&
          _mBoard[i + 3] == (HUMAN_PLAYER) &&
          _mBoard[i + 6] == (HUMAN_PLAYER)) return 2;

      if (_mBoard[i] == (COMPUTER_PLAYER) &&
          _mBoard[i + 3] == (COMPUTER_PLAYER) &&
          _mBoard[i + 6] == (COMPUTER_PLAYER)) return 3;
    }

    // Check for diagonal wins
    if ((_mBoard[0] == (HUMAN_PLAYER) &&
        _mBoard[4] == (HUMAN_PLAYER) &&
        _mBoard[8] == (HUMAN_PLAYER)) ||
        (_mBoard[2] == (HUMAN_PLAYER) &&
            _mBoard[4] == (HUMAN_PLAYER) &&
            _mBoard[6] == (HUMAN_PLAYER))) return 2;

    if ((_mBoard[0] == (COMPUTER_PLAYER) &&
        _mBoard[4] == (COMPUTER_PLAYER) &&
        _mBoard[8] == (COMPUTER_PLAYER)) ||
        (_mBoard[2] == (COMPUTER_PLAYER) &&
            _mBoard[4] == (COMPUTER_PLAYER) &&
            _mBoard[6] == (COMPUTER_PLAYER))) return 3;

    for (int i = 0; i < BOARD_SIZE; i++) {
      // If we find a number, then no one has won yet
      if (!(_mBoard[i] == (HUMAN_PLAYER)) && !(_mBoard[i] == (COMPUTER_PLAYER)))
        return 0;
    }

    // If we make it through the previous loop, all places are taken, so it's a tie*/
    return 1;
  }


//  Computer Move
  void _getComputerMove()
  {

    int move;
    // First see if there's a move O can make to win
    for (int i = 0; i < BOARD_SIZE; i++) {
      if (_mBoard[i] != HUMAN_PLAYER && _mBoard[i] != COMPUTER_PLAYER) {
        String curr = _mBoard[i];
        _mBoard[i] = COMPUTER_PLAYER;
        if (checkWinner() == 3) {
          var k=i+1;
          print("Computer is moving to $k ");
          return;
        }
        else
          _mBoard[i] = curr;
      }
    }

    // See if there's a move O can make to block X from winning
    for (int i = 0; i < BOARD_SIZE; i++) {
      if (_mBoard[i] != HUMAN_PLAYER && _mBoard[i] != COMPUTER_PLAYER) {
        String curr = _mBoard[i];   // Save the current number
        _mBoard[i] = HUMAN_PLAYER;
        if (checkWinner() == 2) {
          _mBoard[i] = COMPUTER_PLAYER;
          var k=i+1;
          print("Computer is moving to $k ");
          return;
        }
        else
          _mBoard[i] = curr;
      }
    }

    // Generate random move
    do
    {
      move = rnd.nextInt(BOARD_SIZE);

    } while (_mBoard[move] == HUMAN_PLAYER || _mBoard[move] == COMPUTER_PLAYER);
    var k = move+1;
    print("Computer is moving to $k");

    _mBoard[move] = COMPUTER_PLAYER;
  }

  // Display Message

  void displayMessage(String Text)
  {
    _text = Text;
  }

  // Function to display Board in console
  void displayBoard()
  {
      print(_mBoard[0]+' | '+_mBoard[1]+' | '+_mBoard[2]);
      print(_mBoard[3]+' | '+_mBoard[4]+' | '+_mBoard[5]);
      print(_mBoard[6]+' | '+_mBoard[7]+' | '+_mBoard[8]);
  }


// Functions For Buttons
void _button(int btn_no) {
  print('on tap called card $btn_no was pressed ');
  setState(() {
    // no one has won continue game
    if(!gameOver) {
      if (_mBoard[btn_no] != HUMAN_PLAYER &&
          _mBoard[btn_no] != COMPUTER_PLAYER) {
        _mBoard[btn_no] = HUMAN_PLAYER;
        displayBoard();

        //check for wins
        win = checkWinner();

        // Decide What message should be displayed to user according to his move
        switch (win) {
          case 1:
            {
              displayMessage(" Game Tie !!! ");
              gameOver=true;
            }
            break;
          case 2:
            {
              displayMessage("X Wins!");
              gameOver=true;
            }
            break;

          case 3:
            {
              displayMessage("O wins! ");
              gameOver=true;
            }
            break;

          default :
            {
              displayMessage("O\'s turn ");
            }
            break;
        }

        // If win = 0 means no one has won yet so continue game, and let computer make his move
       if (win == 0) {
          _getComputerMove();
          win = checkWinner();

          // Decide What message should be displayed to user
          switch (win) {
            case 1:
              {
                displayMessage("Game Tie !!");
                gameOver=true;
              }
              break;

            case 2:
              {
                displayMessage("X Wins! ");
                gameOver=true;
              }
              break;

            case 3:
              {
                displayMessage("O wins!");
                gameOver=true;
              }
              break;

            default :
              {
                displayMessage('O Moved, X\'s Turn ');
              }
              break;
          }
        }
      } else {
        print('Already Filled !!!');
      }
    }else{
      print('Game Over');
    }

  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// ------------------- Start of the AppBar -----------------//
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
          leading: IconButton(
            icon: Icon(
              Icons.border_all,
              semanticLabel: 'menu',
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
// ------------------- 1st Icon Button -----------------//
            new IconButton(
              icon: new Icon(Icons.new_releases),
              onPressed: () {},
              tooltip: "New Game",
            ),
// ------------------- 2nd Icon Button -----------------//
            new IconButton(
              icon: new Icon(Icons.clear),
              onPressed: () {},
              tooltip: "Quit Game",
            ),
// ------------------- OverFlow menu (AKA "3 dot button") Start -------------- //
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
// ------------------- 1st Option Button -----------------//
                  PopupMenuItem(
                    child: new GestureDetector(
                      onTap: () {
                        // some method
                      },
                      child: new Text("About",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
// ------------------- 2nd Option Button -----------------//
                  PopupMenuItem(
                    child: new GestureDetector(
                      onTap: () {
                        // some method
                      },
                      child: new Text("Settings",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
// ------------------- End of Pop-up Menu Items --------------- //
                ];
              },
            )
// ------------------- End of Over-Flow Menu --------------- //
          ],
        ),
// ------------------- End of AppBar ----------------------- //

// ------------------- Start of the Center --------------- //
        body: Center(
// ------------------- Start of the Column --------------- //
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
// ------------------- Start of the Row 1 --------------- //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
// ------------------- Start of the 1st Containter (In Row 1) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 1 in Row 1 --------------- //
                        // 1st Button in 1st Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed:(){
                              _button(0);
                            },
                            child: new Text(_mBoard[0],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
// ------------------- Start of the 2nd Containter (In Row 1) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 2 in Row 1 --------------- //
                        // 2nd Btton in 1st Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(1);
                            },
                            child: new Text(_mBoard[1],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
// ------------------- Start of the 3rd Containter (In Row 1) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 3 in Row 1 --------------- //
                        // 3rd Button in 1st Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(2);
                            },
                            child: new Text(_mBoard[2],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
                  ],
                ),
// ------------------- Start of the Row 2 --------------- //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
// ------------------- Start of the 1st Containter (In Row 2) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 1 in Row 2 --------------- //
                        // 1st Button in 2nd Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(3);
                            },
                            child: new Text(_mBoard[3],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
// ------------------- Start of the 2nd Containter (In Row 2) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 2 in Row 2 --------------- //
                        // 2nd Btton in 2nd Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(4);
                            },
                            child: new Text(_mBoard[4],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
// ------------------- Start of the 3rd Containter (In Row 2) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 3 in Row 2 --------------- //
                        // 3rd Button in 2nd Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(5);
                            },
                            child: new Text(_mBoard[5],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
                  ],
                ),
// ------------------- Start of the Row 3 --------------- //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
// ------------------- Start of the 1st Containter (In Row 3) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 1 in Row 3 --------------- //
                        // 1st Button in 3rd Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(6);
                            },
                            child: new Text(_mBoard[6],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
// ------------------- Start of the 2nd Containter (In Row 3) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 2 in Row 3 --------------- //
                        // 2nd Btton in 3rd Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(7);
                            },
                            child: new Text(_mBoard[7],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
// ------------------- Start of the 3rd Containter (In Row 3) --------------- //
                    Container(
                        height: 100.0,
                        width: 100.0,
                        margin: EdgeInsets.all(10.0),
// ------------------- Start of Button 3 in Row 3 --------------- //
                        // 3rd Button in 3rd Row
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: (){
                              _button(8);
                            },
                            child: new Text(_mBoard[8],
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 80.0,
                                  fontFamily: 'Roboto',
                                )))),
                  ],
                ),
// *************** End of (Row-Container-Button) Pattern *************** //

// ------------------- Start of the Row 4 --------------- //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 100.0,
                        width: 300.0,
                        margin: EdgeInsets.all(10.0),
                        // Button in 2nd Row
                        child: new Text(_text,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              fontFamily: 'Roboto',
                            ))),
                  ],
                ),
// ------------------- Start of the Row 5 --------------- //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 40.0,
                        width: 200.0,
                        margin: EdgeInsets.all(10.0),
                        // 1st Button in Row 5
                        child: RaisedButton(
                            onPressed: (){
                             setState(() {
                               _mBoard = ["","","","","","","","",""];
                               displayBoard();
                               displayMessage('X\'s turn ');
                               gameOver=false;
                             });

                            },
                            child: new Text("New Game",
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                )))),
                  ],
                )
              ]),
        ));
  }
}
