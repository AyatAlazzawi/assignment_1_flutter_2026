import 'dart:math'; //this is the library that is used as the base for the random number generator
import 'package:flutter/material.dart';

//This app was built by Ayat Al-Azzawi for Mobile Web App course in Winter 2026
//Please not that I am also using this assinment to understand how flutter works so it may have some extra comments

/*Ayat Flutter Info
-In flutter screens and components = classes*/

void main() {
  runApp(const MyApp());
}

//var intValue = Random().nextInt(10); //this variable has an integer vaue greater or equal to one but less than 10, dart math also allows you to do this fir doubles or bools

//Root widget of the app
//Root widget = app wide setup = themedata, material app, App title, initial page/ home page, and any routes
//How will my WHOLE app look and behave?
/*so basic app structure is this basically:
main()
 └── MyApp (root widget)
     └── MaterialApp
         ├── ThemeData
         ├── HomePage (Page 1)
         │    └── Scaffold
         │         ├── AppBar
         │         └── Body
         └── SecondPage (Page 2)
              └── Scaffold
                   ├── AppBar
                   └── Body
  

  //themedata map
  ThemeData
├── AppBar colors
├── Page (Scaffold) background color
├── Button colors
├── Text colors
└── Overall color scheme

 */
class MyApp extends StatelessWidget {
  //create a new class MyApp which will not have a changing state since this is a root app widget which only sets up global things like themes
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Number Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFF147CD3),
          foregroundColor: Colors.white, //title and icon color
        ),
        scaffoldBackgroundColor: const Color(0xFF2196F3),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: const Color(0xFF2196F3),
            foregroundColor: Colors.white,
            minimumSize: const Size(
              double.infinity,
              48,
            ), //make buttons full size
          ),
        ),
        textTheme: const TextTheme(
          //using const so that it can be created on compile time since both textTheme and the const are immutable
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),

      // First page that shows when the app starts
      home: const HomePage(),

      // Optional: named route for the second page
      //routes: {'/second': (context) => const StatisticsPage()},
    );
  }
}

//for pages each page will have its own scaffold, appbar, and body
//basically every page is another widget
//keep in mind flutter doesn't automatically switch pages so we need to use Navigator.push(......) to go next, and pop to go back
// -------------------- PAGE 1 --------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var result = Random().nextInt(10,); //this variable has an integer vaue greater or equal to one but less than 10, dart math also allows you to do this fir doubles or bools
  //final Map<int, int> counts = {};
  //bool displayRandomNumber = false;
  final Random random = Random();
  int result = 0;
  bool displayRandomNumber = false;
  final Map<int, int> counts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        title: const Text('Random Number Generator'),
        centerTitle: false,
      ),

      body: Center(
        child: SizedBox(
          width: 260,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end, //what does this do again?
            children: [
              const Spacer(), //the difference between spacer and padding is that padding adds space around a widget but spacerpushes the widgets in a row or column apart, spacer is also flexible and only works in rows, columns, or flex
              Text('$result', style: Theme.of(context).textTheme.headlineLarge),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    result = random.nextInt(10);
                    displayRandomNumber = true;

                    if (counts.containsKey(result)) {
                      counts[result] = counts[result]! + 1;
                    } else {
                      counts[result] = 1;
                    }
                  });
                },

                child: const Text('Generate'),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatisticsPage(counts: counts),
                    ),
                  );
                },
                child: const Text('View Statistics'),
              ),
              const SizedBox(height: 40),
              //if (displayRandomNumber)
              //Text('Answer: $result', style: const TextStyle(fontSize: 28)),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- PAGE 2 --------------------
//this requires mapping /i need a var for result which i have but need to store how many times it appears and then a map?
//is result a local var for the previous page or is it global?

class StatisticsPage extends StatelessWidget {
  final Map<int, int> counts;
  const StatisticsPage({super.key, required this.counts});
  //this variable has an integer vaue greater or equal to one but less than 10, dart math also allows you to do this fir doubles or bools
  //bool displayRandomNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
        centerTitle: false,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: counts.entries.map((entry) {
                return ListTile(
                  title: Text('Number: ${entry.key}'),
                  subtitle: Text('Count: ${entry.value}'),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go Back'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}



//Ayat come back and see if youre supposed to do this for the list styling text o if it has its own styling?
/* 

am i supposed to vhange it to this like the other text?
Text('Answer: $result')
Text(
  'Answer: $result',
  style: Theme.of(context).textTheme.headlineLarge,
),
*/