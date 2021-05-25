import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage>
    with TickerProviderStateMixin {
  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  late AnimationController onChangedAnimation;

  var selectedIndex = 0;
  var previousIndex;

  final List<Widget> _telas = [
    NewPageScreen("Minha conta"),
    NewPageScreen("Meus pedidos"),
    NewPageScreen("Favoritos")
  ];

  Duration animationDuration = Duration(milliseconds: 1000);
  @override
  void initState() {
    super.initState();
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);

    onSelectedAnimation.reset();
    onSelectedAnimation.forward().orCancel;
  }

  @override
  void dispose() {
    super.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[selectedIndex],
      backgroundColor: Colors.grey[800],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          onSelectedAnimation.reset();
          onSelectedAnimation.forward().orCancel;

          onChangedAnimation.value = 1;
          // onChangedAnimation.reverse().orCancel;
          onChangedAnimation.reset();

          setState(() {
            previousIndex = selectedIndex;
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Lottie.asset("assets/lotties/32891-home-icon-red.json",
                height: 30,
                controller: selectedIndex == 0
                    ? onSelectedAnimation
                    : previousIndex == 0
                        ? onChangedAnimation
                        : idleAnimation),
            label: "",
          ),
          BottomNavigationBarItem(
            icon:
                Lottie.asset("assets/lotties/32873-campus-social-account.json",
                    height: 30,
                    controller: selectedIndex == 1
                        ? onSelectedAnimation
                        : previousIndex == 1
                            ? onChangedAnimation
                            : idleAnimation),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset("assets/lotties/32604-app-icon-tab-mine.json",
                height: 30,
                controller: selectedIndex == 2
                    ? onSelectedAnimation
                    : previousIndex == 2
                        ? onChangedAnimation
                        : idleAnimation),
            label: "",
          ),
        ],
      ),
    );
  }
}

class NewPageScreen extends StatelessWidget {
  final String texto;

  NewPageScreen(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          texto,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
