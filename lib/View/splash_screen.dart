import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(vsync: this,
  duration: const Duration(seconds: 3)
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldStatesScreen()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(animation: _controller,
                child: const Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Image(image: AssetImage("images/virus.png")),
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget? child){
              return Transform.rotate(angle: _controller.value*2.0 * math.pi,
              child: child,
              );
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            const Align(
              alignment: Alignment.center,
              child: Text("COVID-19\nTracker App", textAlign: TextAlign.center ,style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
