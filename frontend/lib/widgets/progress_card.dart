import 'package:flutter/material.dart';

class ProgressCard
    extends StatelessWidget {

  final int percentage;

  const ProgressCard({

    super.key,

    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(

              'Task Completion',

              style: TextStyle(

                fontSize: 18,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(

              value:
              percentage / 100,
            ),

            const SizedBox(height: 10),

            Text(
              '$percentage%',
            ),
          ],
        ),
      ),
    );
  }
}