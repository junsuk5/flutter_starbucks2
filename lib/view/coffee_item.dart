import 'package:flutter/material.dart';
import 'package:flutter_starbucks/models/coffee.dart';

class CoffeeItem extends StatelessWidget {
  final Coffee coffee;

  CoffeeItem(this.coffee);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print(coffee);
      },
      leading: SizedBox(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1072007868%2F960x0.jpg%3Ffit%3Dscale'),
        ),
      ),
      title: Row(
        children: <Widget>[
          Text(coffee.name),
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 30,
            height: 30,
            child: CircleAvatar(
              backgroundColor: Colors.grey[600],
              child: Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text('${coffee.price}원'),
    );
  }
}
