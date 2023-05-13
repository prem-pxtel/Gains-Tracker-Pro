import 'package:flutter/material.dart';
import 'randfuncs.dart';
// import 'api.dart';
// https://blog.codemagic.io/rest-api-in-flutter/

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});
  
  /* API fetching, inside StateFULL widget
    late List<Quote> _quoteList = [];
    void _getData() async {
      _quoteList = (await ApiService().getQuotes())!;
      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    }
    @override
    void initState() {
      super.initState();
      _getData();
    }
  */

  @override
  Widget build(BuildContext context) {
    // String quote = randQuote(_quoteList).text;
    String? quote = randQuote()["text"];
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Container(
            padding: const EdgeInsets.all(40),
            child: Text(
              '$quote\n\n\n\n\n\n\n\n',
              textAlign: TextAlign.center)
          )),
          const Center(child: Text('© 2023 Gains Corp.\n\n\n')),
          const Center(child: Text('San B. & Prem P.')),
          Container(
            alignment: Alignment.center,
            child: ListView.builder(
              itemBuilder: (_, index) {
                return Container(
                  color: randColor(),
                  width: 500,
                  height: 500,
                );
              },
            ),
          ),
        ]
      )
    );
  }
}

// alternatively:
// https://docs.flutter.dev/cookbook/persistence/reading-writing-files