import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/shoe.dart';

class ShoeTile extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? goToDetails;
  final Shoe shoe;
  const ShoeTile({
    super.key,
    required this.shoe,
    this.onTap,
    this.goToDetails,
  });

  @override
  Widget build(BuildContext context) {
    //screen size
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: goToDetails,
      child: Container(
        margin: EdgeInsets.only(left: 25),
        width: 280,
        height: size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //shoe pic
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 150,
                width: size.height * 0.5,
                child: Image.asset(
                  shoe.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                shoe.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            //price +details
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //shoe name
                      Text(
                        shoe.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 5),

                      //price
                      Text(
                        'R\$${shoe.price}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  //plus buttom
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //button to add to cart
          ],
        ),
      ),
    );
  }
}
