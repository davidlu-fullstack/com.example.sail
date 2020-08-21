import 'package:flutter/foundation.dart';

class Schedule {
  final String listingId;
  final String userId;
  final bool sun;
  final bool mon;
  final bool tue;
  final bool wed;
  final bool thu;
  final bool fri;
  final bool sat;
  final bool sunMorning;
  final bool monMorning;
  final bool tueMorning;
  final bool wedMorning;
  final bool thuMorning;
  final bool friMorning;
  final bool satMorning;
  final bool sunEvening;
  final bool monEvening;
  final bool tueEvening;
  final bool wedEvening;
  final bool thuEvening;
  final bool friEvening;
  final bool satEvening;

  Schedule(
      {this.listingId,
      this.userId,
      this.fri,
      this.friEvening,
      this.friMorning,
      this.mon,
      this.monEvening,
      this.monMorning,
      this.sat,
      this.satEvening,
      this.satMorning,
      this.sun,
      this.sunEvening,
      this.sunMorning,
      this.thu,
      this.thuEvening,
      this.thuMorning,
      this.tue,
      this.tueEvening,
      this.tueMorning,
      this.wed,
      this.wedEvening,
      this.wedMorning});

  Map<String, dynamic> toMap() {
    return {
      'listingId': listingId,
      'userId': userId,
      'sun': sun,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sunMorning': sunMorning,
      'monMorning': monMorning,
      'tueMorning': tueMorning,
      'wedMorning': wedMorning,
      'thuMorning': thuMorning,
      'friMorning': friMorning,
      'satMorning': satMorning,
      'sunEvening': sunEvening,
      'monEvening': monEvening,
      'tueEvening': tueEvening,
      'wedEvening': wedEvening,
      'thuEvening': thuEvening,
      'friEvening': friEvening,
      'satEvening': satEvening,
    };
  }

  Schedule.fromFirestore(Map<String, dynamic> firestore)
      : listingId = firestore['listingId'],
        userId = firestore['userId'],
        sun = firestore['sun'],
        mon = firestore['mon'],
        tue = firestore['tue'],
        wed = firestore['wed'],
        thu = firestore['thu'],
        fri = firestore['fri'],
        sat = firestore['sat'],
        sunMorning = firestore['sunMorning'],
        monMorning = firestore['monMorning'],
        tueMorning = firestore['tueMorning'],
        wedMorning = firestore['wedMorning'],
        thuMorning = firestore['thuMorning'],
        friMorning = firestore['friMorning'],
        satMorning = firestore['satMorning'],
        sunEvening = firestore['sunEvening'],
        monEvening = firestore['monEvening'],
        tueEvening = firestore['tueEvening'],
        wedEvening = firestore['wedEvening'],
        thuEvening = firestore['thuEvening'],
        friEvening = firestore['friEvening'],
        satEvening = firestore['satEvening'];
}
