import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Size Preview App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String _message = "";
  TextEditingController _controller = TextEditingController();
  double _textSize = 14.0;

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.network(
                  'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
                  height: 100,
                ),
              ),
              SizedBox(height: 10),
              Text(message),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void _navigateToSecondScreen(String text, double textSize) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(
          text: text,
          textSize: textSize,
        ),
      ),
    ).then((result) {
      if (result != null) {
        _showDialog(result);
        setState(() {
          _controller.clear();
          _textSize = 14.0;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter text'),
            ),
            Slider(
              value: _textSize,
              min: 10.0,
              max: 100.0,
              divisions: 90,
              label: _textSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _textSize = value; // Update text size
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isEmpty) {
                  showDialog(context: context, builder: (BuildContext ctx) {
                    return const AlertDialog(
                      title: Text("Message"),
                      content: Text("Enter some text!"),
                    );
                  });
                } else {
                  _navigateToSecondScreen(_controller.text, _textSize);
                }
              },
              child: Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String text;
  final double textSize;

  SecondScreen({required this.text, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Message"),
              content: Text("Don't know what to say"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Second Screen"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: textSize),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cool!');
                    },
                    child: Text('Ok'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Let\'s try something else');
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
