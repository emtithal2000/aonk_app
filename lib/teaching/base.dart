import 'package:aonk_app/teaching/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Consumer<PageProvider>(
                builder: (context, provider, child) {
                  return AlertDialog(
                    title: const Text(
                      'Static Name',
                      textAlign: TextAlign.center,
                    ),
                    content: provider.pages[provider.pageIndex],
                    actionsAlignment: MainAxisAlignment.center,
                  );
                },
              ),
            ).whenComplete(() {
              if (context.mounted) {
                Provider.of<PageProvider>(context, listen: false).pageIndex = 0;
              }
            });
          },
          child: const Text(
            'Go',
            style: TextStyle(
              fontFamily: 'GrenzeGotisch',
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
