import 'lottie.dart';

final List<MyBoardModel> onBoardData = [
  MyBoardModel(
    title: "Registration",
    description: "Get yourself registered with Salary Now app",
    imgUrl: MyLottie.registrationLottie,
  ),
  MyBoardModel(
    title: "Instant Approval",
    description: "Get your application approved instantly after verifying your documents",
    imgUrl: MyLottie.approvedLottie,
  ),
  MyBoardModel(
    title: "Instant Disbursal",
    description: "Get the disbursal within 10 minutes of mandate sign",
    imgUrl: MyLottie.disburseLottie,
  ),
];

class MyBoardModel {
  final String title;
  final String description;
  final String imgUrl;

  MyBoardModel({
    required this.title,
    required this.description,
    required this.imgUrl,
  });
}
