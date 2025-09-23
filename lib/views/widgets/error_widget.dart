import 'package:flutter/material.dart';

class InterNetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const InterNetExceptionWidget({super.key, required this.onPress});

  @override
  State<InterNetExceptionWidget> createState() => _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height * .15),
            const Icon(Icons.cloud_off, color: Colors.red, size: 50),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  'We’re unable to show results.\nPlease check your WIFI\nconnection.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: widget.onPress, child: Center(child: Text('RETRY', style: Theme.of(context).textTheme.bodyLarge))),
          ],
        ),
      ],
    );
  }
}
