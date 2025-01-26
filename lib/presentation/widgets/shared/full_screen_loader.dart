import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading movies',
      'Netflix and chill on progres..',
      'Loading cult movies... ok no',
      'Loading populars',
      'Calling bae',
      'Get some popcorn',
      'This is taking too long :(',
    ];

    return Stream.periodic(
      const Duration(milliseconds: 1200),
      (step) {
        return messages[step];
      },
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading..');

              return Text(snapshot.data ?? 'Loading...');
            },
          )
        ],
      ),
    );
  }
}
