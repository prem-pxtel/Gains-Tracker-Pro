
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp( MyApp() );
}

Color randColor() {
  int a = Random().nextInt((255));
  int r = Random().nextInt((255));
  int g = Random().nextInt((255));
  int b = Random().nextInt((255));
  Color randColor = Color.fromARGB(a, r, g, b);
  return randColor;
}

//screens go here brrr navigation bar
int _index = 0;
final screens = [
MyApp(),
second(),
];

class second extends StatelessWidget {

  //text controller and shit bro

  const second({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  final _textController = TextEditingController();
  int count = 0;
  
  String userPost = '';

  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("yaeaaa baby lightweight"),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:() {
            setState(() {
              count++;
            });
          } ),

          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (int index) {
              setState(() {
               _index = index;
              });
            },
            destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "home"
              ), //onpress go here
            NavigationDestination(
              icon: Icon(Icons.work), 
              label: "Work",
              ),
            NavigationDestination(icon: Icon(Icons.calendar_month_rounded), label: 'Calender_gains'),
              
            ],
            ),

          body: <Widget> [
            Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                   color: randColor(),
                   height: 50,
                   width: 50,
                   child: Text('$count')),

            Stack(
              children: [
                ListView.builder(
                itemBuilder:(_,index){
                  return Container(
                    color: randColor(),
                    height: 100);
                } ),

                //display the gains text
                Expanded(
                  child: Container(child: Center(child: Text(userPost)),) 
                ,),

                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        //clear whats in the thing
                        _textController.clear();
                      },
                      icon: Icon(Icons.clear),
                      ),
                    hintText: 'keyboard gains'),
                ),
                MaterialButton(
                  onPressed: (){
                    //update the string 
                    setState(() {
                      userPost = _textController.text;
                    });
                    
                  },
                  color: Colors.blue,
                  child: const Text('Post', style: TextStyle(color: Colors.white))

                )

                ]
                          
                ),

                Container(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                  ),

                )

          ][_index],
           
          
      ),
    
    ) ;
  }
}
