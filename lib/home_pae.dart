import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;

  var selectYear;
  Animation? animation;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation = animationController;
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  void showPicker(BuildContext context) {
    showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((DateTime? dt) => setState(() {
              selectYear = dt!.year;
              calculateAge();
            }));
  }

  calculateAge() {
    setState(() {
      age = (2024 - selectYear).toDouble();

      animation = Tween<double>(begin: animation!.value, end: age).animate(
          CurvedAnimation(
              parent: animationController!, curve: Curves.fastOutSlowIn));

      animation!.addListener(() {
        setState(() {});
      });

      animationController!.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculate Age",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: OutlinedButton(
              onPressed: () {
                showPicker(context);
              },
              child: Text(selectYear != null
                  ? selectYear.toString()
                  : "Select your year of birth "),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Your age is ${animation!.value.toStringAsFixed(0)}",
            style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
