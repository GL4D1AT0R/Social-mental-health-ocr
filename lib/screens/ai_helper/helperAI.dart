import 'package:string_similarity/string_similarity.dart';
import 'dart:math';

class Ai {
  double opening(int whenInConvo, String lastWords) {
    List opening = [
      "Hello",
      "Hi",
      "Hey",
      "How are you",
      "How are you doing",
      "What good",
      "Hows your day going",
      "How are you doing today",
      "What is your name",
      "how old are you",
      "what is your age",
    ];
    List bulk = [
      "I'm doing this",
      "I picked up",
      "Nice, but did you",
      "Good, Did you see",
      "summer is",
      "cool, but what do you",
    ];
    double lastScore = 0;
    late List currentlist;
    late String currentCompare;
    switch (whenInConvo) {
      case 0:
        currentlist = opening;
        for (int i = 0; i < currentlist.length; i++) {
          currentCompare = currentlist[i];
          if (currentCompare.similarityTo(lastWords) > lastScore) {
            lastScore = currentCompare.similarityTo(lastWords);
          }
        }
        break;
      case 1:
        currentlist = bulk;
        for (int i = 0; i < currentlist.length; i++) {
          currentCompare = currentlist[i];
          if (currentCompare.similarityTo(lastWords) > lastScore) {
            lastScore = currentCompare.similarityTo(lastWords);
          }
        }
        break;
      default:
        throw "Invalid whenInConvo error please only use 0,1 and do not go any higher or it will break, K?";
    }
    return lastScore *= 10;
  }

  double body(int whenInConvo, String lastWords) {
    List opening = [
      "Hello",
      "Hi",
      "Hey",
      "How are you",
      "How are you doing",
      "What good",
      "Hows your day going",
      "How are you doing today",
      "What is your name",
      "how old are you",
      "what is your age",
    ];
    List bulk = [
      "I'm doing this",
      "I picked up",
      "Nice, but did you",
      "Good, Did you see",
      "summer is",
      "cool, but what do you",
    ];
    double lastScore = 0;
    late List currentlist;
    late String currentCompare;
    switch (whenInConvo) {
      case 0:
        currentlist = opening;
        for (int i = 0; i < currentlist.length; i++) {
          currentCompare = currentlist[i];
          if (currentCompare.similarityTo(lastWords) > lastScore) {
            lastScore = currentCompare.similarityTo(lastWords);
          }
        }
        break;
      case 1:
        currentlist = bulk;
        for (int i = 0; i < currentlist.length; i++) {
          currentCompare = currentlist[i];
          if (currentCompare.similarityTo(lastWords) > lastScore) {
            lastScore = currentCompare.similarityTo(lastWords);
          }
        }
        break;
      default:
        throw "Invalid whenInConvo error please only use 0,1 and do not go any higher or it will break, K?";
    }
    return lastScore *= 10;
  }

  String respond() {
    List responses = [
      "I'm good how about you",
      "I'm good, I picked up cars",
      "Nice, but did you see the game?",
      "Good, Did you see the game?",
      "Not good summer is boring",
      "cool, but what do you",
    ];
    int what = Random().nextInt(responses.length);

    return responses[what];
  }
}
