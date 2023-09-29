import 'package:flutter/material.dart';
import 'package:flutter_debounce/debounce.dart';

void main() => runApp(const FlutterDebounce());

class FlutterDebounce extends StatelessWidget {
  const FlutterDebounce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Debounce',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? text;

  final debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() {
    debounce.cancel();

    super.dispose();
  }

  void onChanged(String value) {
    debounce(() {
      setState(() {
        text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.blue[900]!, width: 3),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Debounce'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: onChanged,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                fillColor: Colors.grey[50],
                filled: true,
                hintText: 'Digite algo...',
                hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 18),
              ),
              autocorrect: false,
              enableSuggestions: false,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'O texto digitado foi: ${text ?? ''}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
