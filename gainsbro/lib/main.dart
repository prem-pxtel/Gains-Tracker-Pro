import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

Color randColor() {
  int a = Random().nextInt((255));
  int r = Random().nextInt((255));
  int g = Random().nextInt((255));
  int b = Random().nextInt((255));
  Color randColor = Color.fromARGB(a, r, g, b);
  return randColor;
}

class Gains2Screen extends StatefulWidget {
  const Gains2Screen({super.key});

  @override
  State<Gains2Screen> createState() => _Gains2ScreenState();
}

class _Gains2ScreenState extends State<Gains2Screen> {
  final _textController = TextEditingController();

  String gString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Gains2ScreenText'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child:Text(gString),
              ),
            ),

            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'GAINTSHINT??',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                  }  
                )
              ),
            ),

            MaterialButton(
              onPressed: () {
                setState(() {
                  gString = _textController.text;
                });
              },
              color: Colors.orangeAccent,
              child: const Text('Generate Gains', style: TextStyle(color: Colors.white)),
            )
          ]
        ),
      )

    );


  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int count = 0;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        
        appBar:AppBar(
          backgroundColor: Colors.black,
          title: const Text('GA!NSBRO'),
        ),
        

        body:Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(100),
                padding: const EdgeInsets.all(10),
                color:randColor(),
                height:100,
                width:100,
                child: Text('$count gains'),
              ),
            ),

            Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Icon(Icons.back_hand),
                Icon(Icons.sports_gymnastics_rounded),
              ]
            ),

            ListView.builder(itemBuilder: (_, index) {
                return Container(
                  color: randColor(),
                  width: 500,
                  height: 500,
                );
              },
            ),

            ElevatedButton(
              child: const Text('GainsNavigatingButton'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Gains2Screen(),),
                );
              },
            ),

            <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Text('Page 1'),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text('Page 2'),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text('Page 3'),
              ),
            ][currentPageIndex],

          ],
        ),

      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
          });
        }
      ),




/*
      bottomNavigationBar: BottomNavigationBar(
        items: const [ 
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'GAINS1'),
          BottomNavigationBarItem(icon: Icon(Icons.fast_forward), label: 'GAINS2'),
          BottomNavigationBarItem(icon: Icon(Icons.door_front_door_outlined), label: 'GAINS3'),
        ]
      ),
*/

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
      


      ),
    );
  }
}
