import 'package:aonk_app/teaching/dialog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: set charityName in alert dialog title
//TODO: convert each page in dialog from class to method(Widget)
//TODO: Check design after convert and edit if needed
//TODO: repeat from first for each page shows in dialog
//TODO: create list of widgets and call each one in this list
//TODO: pass this list into alert dialog content

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Consumer<DialogProvider>(
                builder: (_, provider, __) {
                  return AlertDialog(
                    title: Text(provider.title[provider.currentIndex]),
                    // content: buildDialog(provider),
                    contentPadding: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (provider.currentIndex == 2) {
                            Navigator.pop(context);
                          } else {
                            provider.nextPage();
                          }
                        },
                        child: Text(provider.button),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
