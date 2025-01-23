import 'package:flutter/material.dart';

class RewardModule extends StatelessWidget {
  final int totalTokens;

  RewardModule({required this.totalTokens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Tokens Earned:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.yellow[700]),
              SizedBox(width: 8),
              Text(
                '$totalTokens',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
