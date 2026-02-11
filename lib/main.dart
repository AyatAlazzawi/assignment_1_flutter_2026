import 'dart:math'; //this is the library that is used as the base for the random number generator
import 'package:flutter/material.dart';

//This app was built by Ayat Al-Azzawi for Mobile Web App course in Winter 2026
//Please not that I am also using this assinment to understand how flutter works so it may have some extra comments

void main() {
  runApp(const MyApp());
}

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
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Number Generator',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primarySwatch: Colors.blue, //sets the color for the whole app
        //useMaterial3: true,
      ),

      // First page that shows when the app starts
      home: const HomePage(),

      // Optional: named route for the second page
      routes: {'/second': (context) => const SecondPage()},
    );
  }
}

//for pages each page will have its own scaffold, appbar, and body
//basically every page is another widget
//keep in mind flutter doesn't automatically switch pages so we need to use Navigator.push(......) to go next, and pop to go back
// -------------------- PAGE 1 --------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This is Page 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap the button to go to Page 2.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
                // OR using the named route:
                // Navigator.pushNamed(context, '/second');
              },
              child: const Text('Go to Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- PAGE 2 --------------------
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'This is Page 2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'You navigated here from Page 1.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // go back to the previous page
                Navigator.pop(context);
              },
              child: const Text('Back to Page 1'),
            ),
          ],
        ),
      ),
    );
  }
}
