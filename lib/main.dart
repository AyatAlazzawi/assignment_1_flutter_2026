import 'dart:async';
import 'dart:math'; //this is the library that is used as the base for the random number generator
import 'package:flutter/material.dart';

//This app was built by Ayat Al-Azzawi for Mobile Web App course in Winter 2026
//Please not that I am also using this assinment to understand how flutter works so it may have some extra comments

/*Ayat Flutter Info
-In flutter screens and components = classes*/

const Color appBarBackgroundColor = Color(0xFF147CD3);
const Color bodyBackgroundColor = Color(0xFF2196F3);
const Color buttonColor = Color(0xFF147CD3);
const Color textColor = Colors.white;

const TextStyle headlineLargeStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: textColor,
);

const TextStyle bodyMediumStyle = TextStyle(fontSize: 16, color: textColor);

final ButtonStyle _elevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: buttonColor,
  foregroundColor: textColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  minimumSize: const Size(double.infinity, 48),
  elevation: 0,
  textStyle: const TextStyle(fontSize: 16),
);

void main() {
  runApp(const MyApp());
}

//Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Number Generator',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: appBarBackgroundColor,
          foregroundColor: textColor,
        ),
        scaffoldBackgroundColor: bodyBackgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: _elevatedButtonStyle,
        ),
        textTheme: const TextTheme(
          headlineLarge: headlineLargeStyle,
          bodyMedium: bodyMediumStyle,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// -------------------- PAGE 1 --------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //sae this on youtube and basically what it is is a clock that tcks every frame so 60 times a sec
  //Random logic
  final Random random = Random();
  int result = 0;
  bool displayRandomNumber =
      false; //this is to accout for the part in the video where there is nothing but the buttons on the screen
  bool isGenerating = false; //will coe back when im trying to do the animation

  final Map<int, int> counts =
      {}; //for my 'history' tab where i am mapping the actual result to the occurances / count

  late final AnimationController
  controller; //late allows me to basically promise viual studio that I will assign this before I actually use it, i kept facing issues because dart apparently wants everything initialized ASAP
  //originally tried AnimationController controller; but that did not work
  Timer?
  timer; //account for thr time where ther eis not imer running because it starts later after i press my button

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync:
          this, //makes sure animations update right as my screen refreshes "use this state object to control when frames update, also is th eprovider for my SingleTickerProviderStateMixin"
      duration: const Duration(seconds: 1),
    );
  }

  //I actually learned this part from here https://api.flutter.dev/flutter/animation/AnimationController-class.html
  //this mostly came because of flutters lifestyle documentation as well because apparenlty flutter controller takes up cpu frames
  // doc says to always dispose of resources
  //https://api.flutter.dev/flutter/widgets/State/dispose.html
  @override
  void dispose() {
    timer?.cancel(); //stops the timer immediately
    controller.dispose();
    super.dispose();
  }

  void startGenerate() {
    if (isGenerating) return;

    setState(() {
      isGenerating = true;
      displayRandomNumber = true;
    });

    controller.repeat();

    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        result = random.nextInt(9) + 1;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      timer?.cancel();
      controller.stop();

      setState(() {
        isGenerating = false;
        counts[result] = (counts[result] ?? 0) + 1;
      });
    });
  }

  void resetAll() {
    setState(() {
      counts.clear();
      result = 0;
      displayRandomNumber = false;
      isGenerating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
        centerTitle: false,
      ),
      body: Center(
        child: SizedBox(
          width: 260,
          child: Column(
            children: [
              const Spacer(), //the difference between spacer and padding is that padding adds space around a widget but spacer pushes the widgets in a row or column apart, spacer is also flexible and only works in rows, columns, or flex

              if (displayRandomNumber)
                RotationTransition(
                  turns: controller,
                  child: Text(
                    '$result',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),

              const Spacer(),

              ElevatedButton(
                onPressed: startGenerate,
                child: const Text('Generate'),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StatisticsPage(counts: counts, onReset: resetAll),
                    ),
                  );
                },
                child: const Text('View Statistics'),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- PAGE 2 --------------------

class StatisticsPage extends StatelessWidget {
  final Map<int, int> counts;
  final VoidCallback
  onReset; //VoidCallBack is a function that returns nothing and takes no parameters

  const StatisticsPage({
    super.key,
    required this.counts,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics'), centerTitle: false),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: List.generate(9, (i) {
                final index = i + 1;
                final count = counts[index] ?? 0;

                return ListTile(
                  title: Text(
                    'Number $index',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Text(
                    '$count times',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              onReset();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Reset'),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

//----------------------------------------------------------------------------------
/*sources:
1.)Understanding dispose method:
//https://api.flutter.dev/flutter/widgets/State/dispose.html
2.)Animation:
https://api.flutter.dev/flutter/animation/AnimationController-class.html
3.)Dart timer reference:
https://api.dart.dev/dart-async/Timer-class.html
4.)For the 60 ticks per second: https://api.flutter.dev/flutter/widgets/SingleTickerProviderStateMixin-mixin.html




 */
