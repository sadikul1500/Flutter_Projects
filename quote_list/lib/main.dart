import 'package:flutter/material.dart';
import 'quote_card.dart';
import 'quote.dart';

void main() {
  runApp(MaterialApp(
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote('You are stronger than you think', 'IIT'),
    Quote('Never stop praying', 'Muhammad(S)'),
    Quote('Don\'t work hard, work smart', 'Unknown'),
    Quote('Trust in Allah', 'Al-Quran'),
    Quote('Allah\'s help is very close', 'Al-Quran'),
  ];

  // Widget quoteTemplate(quote) {
  //   return QuoteTemplate(quote);
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[400],
        title: Text('Awesome Quotes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // children: quotes.map((quote) {
          //   return Text(quote);
          // }).toList(),
          children: quotes
              .map((quote) => QuoteCard(
                  //quoteTemplate(quote)
                  quote: quote,
                  delete: () {
                    setState(() {
                      quotes.remove(quote);
                    });
                  })) //Text('${quote.text} -> ${quote.author}'))
              .toList(),
        ),
      ),
    );
  }
}
