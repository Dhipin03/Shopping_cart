import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/constants/color_constants.dart';
import 'package:shoppingcart/utils/constants/image_constants.dart';
import 'package:shoppingcart/view/discover_screen/discover_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(ImageConstants.onboardingscreenimg))),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: 80,
        color: ColorConstants.whitecolor,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiscoverScreen(),
                    )),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorConstants.blackcolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: ColorConstants.whitecolor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        size: 22,
                        Icons.arrow_forward,
                        color: ColorConstants.whitecolor,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
