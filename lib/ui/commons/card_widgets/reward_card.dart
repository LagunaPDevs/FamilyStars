import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:flutter/material.dart';

// Helper widget to create list of rewards
class RewardCard extends StatelessWidget {
  final Function()? onTap;
  final String name;
  final String stars;
  const RewardCard(
      {super.key, required this.name, required this.stars, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      ColorConstants.whiteColor,
                      ColorConstants.yellowColor,
                    ]),
                border:
                    Border.all(color: ColorConstants.yellowColor, width: 1.0),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      name,
                      style: TextStyle(
                          color: ColorConstants.greyColor,
                          fontSize: 16,
                          fontFamily: 'KristenITC',
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: GestureDetector(
                      onTap: onTap,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.simpleStar,
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            stars,
                            style: TextStyle(
                                color: ColorConstants.greyColor,
                                fontWeight: FontWeight.bold),
                          ),
                          //CustomButton(title: 'Solicitar', onPressed: () {  },)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
