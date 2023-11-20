import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'quote_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String quote = '';
  List<Map<String, dynamic>> quotesData = [];
  List<String> quotes = [];
  int n = 0;

  @override
  void initState() {
    super.initState();
    initQuotesData();
  }

  void initQuotesData() async {
    await getQuotesData();
  }

  Future<void> getQuotesData() async {
    const apiUrl = 'https://zenquotes.io/api/quotes';

    final response = await http.get(Uri.tryParse(apiUrl)!);

    if (response.statusCode == 200) {
      quotesData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      quotes = quotesData.map<String>((quote) => quote['q']).toList();
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }

    print(quotes.length);
  }

  void nextQuote() async {
    if (quotes.isEmpty || n >= 50) {
      n = 0;
      await getQuotesData();
    }

    setState(() {
      quote = quotes[n++];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Random Quoter'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Your Quote',
                  style: TextStyle(fontSize: 24),
                ),
                QuoteViewer(quote: quote),
                const SizedBox(height: 32),
                CupertinoButton.filled(
                  onPressed: () {
                    nextQuote();
                  },
                  child: const Text('Next Quote'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
