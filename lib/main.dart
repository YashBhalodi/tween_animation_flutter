import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tween Animation Basic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tween Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> animationWidth;
  AnimationController animationControllerWidth;
  Animation<double> animationHeight;
  AnimationController animationControllerHeight;
  Duration animationTime = Duration(seconds: 2);
  @override
  void initState() {
    super.initState();

    //animation setup of width animation
    animationControllerWidth =
        AnimationController(vsync: this, duration: animationTime);
    animationWidth = Tween(begin: 10.0, end: 300.0).animate(animationControllerWidth)
      ..addListener(() {
        setState(() {});
      });
    animationWidth.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationControllerWidth.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationControllerWidth.forward();
      }
    });
    animationControllerWidth.forward();

    //animation setup of height animation
    animationControllerHeight =
        AnimationController(vsync: this, duration: animationTime);
    animationHeight =
    Tween(begin: 10.0, end: 300.0).animate(animationControllerHeight)
      ..addListener(() {
        setState(() {});
      });
    animationHeight.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationControllerHeight.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationControllerHeight.forward();
      }
    });
    animationControllerHeight.forward();
  }

  _slowerAnimation(Duration delay){
    setState(() {
      animationTime = animationTime + delay;
      //print(animationTime.inMilliseconds);
      animationControllerHeight.duration = animationTime;
      animationControllerWidth.duration = animationTime;
    });
  }
  _spedUpAnimation(Duration rush){
    setState(() {
      animationTime = animationTime - rush;
      //print(animationTime.inMilliseconds);
      animationControllerHeight.duration = animationTime;
      animationControllerWidth.duration = animationTime;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                width: animationWidth.value,
                height: animationHeight.value,
                color: Colors.blue,
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 100.0,
                  child: Text(
                    "Width:-" + animationWidth.value.toInt().toString(),
                    style: TextStyle(fontSize: 16.0),
                  )),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                elevation: 2.0,
                onPressed: () {
                  animationControllerWidth.forward();
                },
                child: new Text("Play"),
              ),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.grey,
                elevation: 2.0,
                onPressed: () {
                  animationControllerWidth.stop();
                },
                child: new Text("Pause"),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 100.0,
                  child: Text(
                    "Height:-" + animationHeight.value.toInt().toString(),
                    style: TextStyle(fontSize: 16.0),
                  )),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                elevation: 2.0,
                onPressed: () {
                  animationControllerHeight.forward();
                },
                child: new Text("Play"),
              ),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.grey,
                elevation: 2.0,
                onPressed: () {
                  animationControllerHeight.stop();
                },
                child: new Text("Pause"),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 100.0,
                  child: Text(
                    "Dur.:-" + animationTime.inSeconds.toString() +" sec",
                    style: TextStyle(fontSize: 16.0,),softWrap: false,
                  )),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.black,
                color: Colors.green,
                elevation: 2.0,
                onPressed: () => _spedUpAnimation(Duration(milliseconds: 500)),
                child: new Text("Faster"),
              ),
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.black,
                color: Colors.amberAccent,
                elevation: 2.0,
                onPressed: () =>
                    _slowerAnimation(Duration(milliseconds: 500)),
                child: new Text("Slower"),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
          )
        ],
      ),
    );
  }
}
