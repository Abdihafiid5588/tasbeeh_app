import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'TasbeehCounterScreen.dart';  // Ensure this import is present

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasbeeh', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TasbeehCounterScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.cog, color: Colors.white),
            onPressed: () {
              // Settings action
            },
          ),
        ],
        backgroundColor: Color(0xFF833ab4), // Ensure a contrasting color for the AppBar
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE9E0E0), Color(0xFFEDE5CB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'أَسْتَغْفِرُ ٱللَّٰهَ',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Astaghfirullah',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Container(
                width: 240,  // Adjust the width as needed
                height: 300, // Adjust the height as needed
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF833ab4), Color(0xFFfd1d1d), Color(0xFFfcb045)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(55),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(35),
                child: Container(
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_counter',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        child: Text('Tap'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 248, 248, 247),
                          foregroundColor: const Color.fromARGB(255, 25, 7, 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(Icons.refresh, color: const Color.fromARGB(255, 254, 253, 252)),
                        onPressed: _resetCounter,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
