import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuoteViewer extends StatelessWidget {
  final String quote;

  const QuoteViewer({super.key, required this.quote});

  // Function to stylize the quote
  RichText stylizeQuote(String quote, BuildContext context) {
    List<String> words = quote.split(' ');

    // Get the default text style from the current context
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;

    // First word is bold, rest are normal
    TextSpan firstWord = TextSpan(
      text: words[0].toUpperCase(),
      style:
          defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
    );

    TextSpan restOfQuote = TextSpan(
      text: ' ${words.sublist(1).join(' ')}',
      style: defaultTextStyle.copyWith(fontSize: 24),
    );

    return RichText(
      text: TextSpan(
        children: [firstWord, restOfQuote],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine theme brightness
    Brightness? themeBrightness = CupertinoTheme.of(context).brightness;

    // Set the card color based on theme brightness
    Color cardColor = themeBrightness == Brightness.light
        ? const Color(0xffdfbbff) // Light theme color
        : const Color(0xff9f73cc); // Dark theme color

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(16.0),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeInOutCubicEmphasized,
          child: stylizeQuote(quote, context),
        ),
      ),
    );
  }
}
