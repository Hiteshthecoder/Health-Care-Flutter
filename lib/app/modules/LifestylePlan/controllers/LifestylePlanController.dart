import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ui_x/ui_x.dart';

import '../../../shared/controllers/AppController.dart';

class LifestylePlanController extends AppController {
  static LifestylePlanController get to => Get.find();

  GetStorage box = GetStorage();

  /// Observables
  var _choices = RxList<int>([0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

  /// Getters
  List<int> get choices => _choices;

  /// setters

  void updateChoices({int? index, int? value}) {
    if (index != null && value != null && index < _choices.length) {
      _choices[index] = value;
      update();
    }
  }

  bool get allSelected => !choices.contains(0);

  int get score =>
      choices.fold(0, (previousValue, element) => previousValue + element * 10);

  /// constants
  final List<Question> questions = [
    Question(
        question: "1) What is your current activity level ?",
        option1: "Highly active (intense exercise or training most days)",
        option2: "Moderately active (regular exercise a few times a week)",
        option3: "Sedentary (little to no exercise)"),
    Question(
        question: "2) How many hours of sleep do you typically get each night?",
        option1: "More than 8 hours",
        option2: "6-8 hours",
        option3: "Less than 6 hours"),
    Question(
        question: "3) What is your dietary pattern?",
        option1: "Balanced diet",
        option2: "Mostly healthy with occasional indulgences",
        option3: "Poor diet with unhealthy choices"),
    Question(
        question:
            "4) How many meals and snacks do you typically have in a day?",
        option1: "3 or more meals, regular snacking",
        option2: "2 meals, occasional snacking",
        option3: "Irregular meals, no snacking"),
    Question(
        question: "5) How much water do you consume daily?",
        option1: "2 liters or more",
        option2: "1-2 liters",
        option3: "Less than 1 liter"),
    Question(
        question:
            "6) Are there any medical conditions or allergies I should be aware of?",
        option1: "No medical conditions or allergies",
        option2: "Food allergies",
        option3: "Diabetes/ hypertension/ Heart problems"),
    Question(
        question:
            "7) Do you have any existing exercise routines or fitness preferences?",
        option1: "Cardiovascular exercises",
        option2: "Strength training/ Yoga",
        option3: "No or minimal exercise"),
    Question(
        question: "8) What is your stress level on a typical day?",
        option1: "Low stress, effective coping mechanisms",
        option2: "Moderate stress, some coping strategies",
        option3: "High stress, no effective coping mechanisms"),
    Question(
        question:
            "9) Do you engage in any relaxation or mindfulness practices?",
        option1: "Meditation",
        option2: "Deep breathing exercises",
        option3: "None of the above"),
    Question(
        question: "10) Screen time",
        option1: "Limited use, relaxation without excessive screen time",
        option2: "Moderate screen time with breaks",
        option3: "Excessive screen time without breaks"),
  ];

  String getRes() {
    if (score >= 250) {
      return "Health and Wellness Champions~Congratulations on achieving a score between 250 to 300! You should feel incredibly proud of yourself for maintaining such a high level of commitment to your health and well-being. Your dedication to leading a balanced lifestyle is truly commendable.\nBy consistently engaging in intense exercise or training, prioritizing quality sleep, following a balanced diet, consuming an adequate amount of water, managing stress effectively, incorporating exercise routines, practicing relaxation and mindfulness techniques, and limiting screen time, you have shown exceptional discipline and commitment to your overall well-being.\nYour high score reflects your conscious efforts to prioritize your health and make positive choices in various aspects of your lifestyle. Not only are you taking care of your physical health, but you are also nurturing your mental and emotional well-being through stress management and relaxation practices.\nYour exceptional score serves as a testament to your strong determination, self-discipline, and focus on leading a healthy and balanced life. Keep up the great work and continue to inspire others with your positive habits and choices.\nRemember, your commitment to a healthy lifestyle is an ongoing journey. Stay motivated, seek new ways to challenge yourself, and remain open to learning and incorporating even more healthy habits into your daily routine.\nOnce again, congratulations on your outstanding achievement, and keep up the excellent work on your path to optimal health and well-being!";
    } else if (score < 250 && score >= 200) {
      return "Balanced Lifestyle~Congratulations on achieving a strong score in our Health and Wellness Assessment! You're already on a great path towards a healthier lifestyle. With a little extra effort and focus, you have the potential to join the esteemed group of Health and Wellness Champions who score above 250. Keep up the excellent work, stay committed to your goals, and you'll soon witness even greater improvements in your overall well-being. You're just a few steps away from reaching new heights, and we're here to support you every step of the way! \n\nA score in the range of 200-250 indicates a balanced lifestyle with healthy habits and practices. Users in this category are actively engaged in regular exercise, have a balanced diet, adequate sleep, good stress management techniques, and engage in relaxation or mindfulness practices. They maintain a healthy activity level, prioritize sleep, consume sufficient water, and have minimal or controlled screen time. These individuals are taking positive steps towards maintaining their overall well-being and are on the right track to a healthy lifestyle. \n\n";
    } else if (score < 200 && score >= 100) {
      return "Need improvement~Congratulations on completing our Health and Wellness Assessment! Your score reflects a good foundation for a healthier lifestyle. While there's room for improvement, remember that progress is a journey. Stay motivated and committed to making positive changes in your daily routine. Small steps can lead to significant transformations. Keep pushing forward, stay consistent, and you'll gradually elevate your score and overall well-being. We believe in you! \n\nA score in the range of 100-199 suggests that there is room for improvement in certain aspects of the user's lifestyle. Users falling into this category may have inconsistencies or areas of weakness in their activity level, diet, sleep duration, stress management, relaxation practices, water consumption, exercise routines, or screen time. They may need to make adjustments to their current habits and focus on developing healthier habits to improve their overall well-being.";
    }
    return "Unhealthy Lifestyle~Thank you for taking our Health and Wellness Assessment! Your score indicates that there are areas where you can make positive changes to improve your overall health and well-being. Don't be discouraged by the score. Every journey begins with a single step, and the important thing is that you've taken the first step towards a healthier lifestyle. Remember, it's never too late to make positive changes. Start by setting achievable goals and implementing small, sustainable changes in your daily routine. With dedication and perseverance, you can gradually increase your score and make significant improvements to your health. We're here to support and guide you on your journey to a healthier, happier you! \n\nA score below 100 indicates an unhealthy lifestyle with several areas that require attention and improvement. Users in this category may have sedentary lifestyles, poor dietary choices, inadequate sleep, high stress levels, lack of relaxation or mindfulness practices, low water intake, minimal or no exercise routines, and excessive screen time. It is crucial for individuals in this category to make significant changes in their lifestyle habits and seek professional guidance to address their health concerns and improve their overall well-being. ";
  }

  List<String> advice() {
    List<List<String>> responses = [
      [
        "It's important to incorporate physical activity into your daily routine. ",
        "Maintain your consistency and consider increasing the intensity or frequency of your workouts.",
        "It's great that you have a high activity level. Keep up the good work!",
      ],
      [
        "It's important to prioritize sleep and aim for at least 6-8 hours each night. You can try following ",
        "Your sleep duration is within the recommended range. Aim to maintain a consistent sleep schedule for optimal rest.",
        "You're getting sufficient sleep, which is beneficial for recovery and overall well-being. Keep it up!",
      ],
      [
        "Make gradual improvements to your diet",
        "It's good to have occasional indulgences, but ensure that the majority of your diet consists of healthy choices.",
        "Congratulations on maintaining a balanced diet! Continue incorporating a variety of nutrient-dense foods for optimal health.",
      ],
      [
        "Establishing a regular meal pattern is important for maintaining energy levels and supporting overall health. ",
        "Aim for more consistent meal patterns and consider incorporating healthy snacks for sustained energy.",
        "Having regular meals and snacks promotes a steady energy level throughout the day. Ensure that your choices are balanced and nutritious.",
      ],
      [
        "It's important to prioritize hydration. Make a conscious effort to increase your water intake for better overall health.",
        "Aim to increase your water intake to reach the recommended 2 liters or more per day.",
        "Great job on staying hydrated! Continue to drink an adequate amount of water throughout the day to support your body's functions.",
      ],
      [
        "It's important to manage these conditions with the help of healthcare professionals. ",
        "Take necessary precautions and ensure you avoid triggering foods. Consult a healthcare professional or registered dietitian for personalized guidance.",
        "That's fantastic! Be mindful of maintaining a healthy lifestyle to prevent future health issues.",
      ],
      [
        "It's important to start incorporating regular exercise into your routine. ",
        "Cardiovascular exercises are great for cardiovascular health and calorie burn. ",
        "Consider incorporating strength training and flexibility exercises for a well-rounded routine.",
      ],
      [
        "It's crucial to prioritize stress management. ",
        "Consider exploring additional techniques such as mindfulness or seeking support if needed.",
        "Well done on managing stress effectively! Continue practicing stress-reducing techniques and maintaining a healthy work-life balance.",
      ],
      [
        "Consider exploring different relaxation techniques such as yoga, mindfulness, or engaging in hobbies that promote relaxation and stress reduction.",
        "Deep breathing exercises are beneficial for relaxation and reducing stress. Incorporate them into your daily routine.",
        "Excellent choice! Continue practicing meditation regularly to enhance relaxation, focus, and overall well-being.",
      ],
      [
        "Try to reduce your screen time and take regular breaks. Engage in activities that don't involve screens for better overall health.",
        "It's good to take breaks during screen time. Consider incorporating more non-screen activities into your daily routine to achieve a better balance.",
        "You're practicing a healthy balance. Continue to limit your screen time and engage in other activities for relaxation and well-being.",
      ],
    ];

    return responses
        .map((e) => "${e[choices[responses.indexOf(e)] - 1]}\n")
        .toList();
  }

  List<FaIcon> get adviceIcons => [
        FaIcon(
          FontAwesomeIcons.personRunning,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.bed,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.bowlFood,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.bowlRice,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.bottleWater,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.handDots,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.dumbbell,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.brain,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.basketball,
          color: kcPrimary,
          size: 25,
        ),
        FaIcon(
          FontAwesomeIcons.mobile,
          color: kcPrimary,
          size: 25,
        ),
      ];

  String getResEmoji() {
    if (score >= 250) {
      return "😃";
    } else if (score < 250 && score >= 200) {
      return "🙂";
    } else if (score < 200 && score >= 100) {
      return "😕";
    }
    return "😢";
  }

  @override
  void onInit() {
    super.onInit();
    if (box.read('choices') != null) {
      _choices =
          RxList<int>(jsonDecode(box.read('choices')).cast<int>().toList());
    }
    // box.remove('choices');
  }
}

class Question {
  final String question;
  final String option1;
  final String option2;
  final String option3;

  Question(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.option3});
}
