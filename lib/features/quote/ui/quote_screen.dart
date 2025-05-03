import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motivate_me/core/theme_notifier.dart';
import 'package:motivate_me/features/quote/providers/quote_provider.dart';

class QuoteScreen extends ConsumerWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final quoteAsync = ref.watch(quoteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MotivateMe'),
        actions: [
          IconButton(
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          )
        ],
      ),
      body: Center(
        child: quoteAsync.when(
          data: (quote) => Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: ()=> ref.refresh(quoteProvider),icon: Icon(Icons.refresh),),
                Text(
                  '"${quote.content}"',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '- ${quote.author} -',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ), error: (e,_)=>Text('Error when loading quote: $e'),
          loading: ()=> const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
