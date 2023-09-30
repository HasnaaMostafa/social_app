import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/BoardingModel.dart';
import '../../shared/network/local/cache_helper.dart';
import '../Login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: const Image(
        image: AssetImage("assets/images/find.png"),
      ),
      fit: BoxFit.cover,
      title: "WELCOME",
      body:
          "Hey! I think you'd love our app even more! It has some really unique features."
          " Want to give it a try together?",
    ),
    BoardingModel(
        image: const Image(
          image: AssetImage("assets/images/share.png"),
        ),
        fit: BoxFit.cover,
        title: "SHARE FILES",
        body:
            "Hey there! I'm always on the lookout for interesting content to share on my social media."
            " If you have anything cool to share, send it my way"),
    BoardingModel(
      image: const Image(
        image: AssetImage("assets/images/message.png"),
        height: 400,
      ),
      title: "FIND NEW FRIENDS",
      body: "Hey there! I noticed we share some similar interests."
          " I'm always looking to connect with new people who share my passions."
          " Want to chat and see if we can be friends?",
    )
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: "OnBoarding", value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SocialLoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: HexColor("#0E6655")),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                        debugPrint("last");
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    itemBuilder: (context, index) =>
                        buildBoardItem(boarding[index]),
                    itemCount: boarding.length),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: HexColor("#0E6655"),
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: model.image.image,
              fit: model.image.fit,
            ),
          ),
          Center(
            child: Text(
              model.title,
              style: TextStyle(
                  fontSize: 25.0,
                  color: HexColor("#0E6655"),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 15.0, color: HexColor("#B7950B")),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );
}
