import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sail/src/models/schedule.dart';
import 'package:sail/src/services/firestore_services.dart';

class ScheduleBloc {
  final _listingId = BehaviorSubject<String>();
  final _userId = BehaviorSubject<String>();
  final _sun = BehaviorSubject<bool>();
  final _mon = BehaviorSubject<bool>();
  final _tue = BehaviorSubject<bool>();
  final _wed = BehaviorSubject<bool>();
  final _thu = BehaviorSubject<bool>();
  final _fri = BehaviorSubject<bool>();
  final _sat = BehaviorSubject<bool>();
  final _sunMorning = BehaviorSubject<bool>();
  final _monMorning = BehaviorSubject<bool>();
  final _tueMorning = BehaviorSubject<bool>();
  final _wedMorning = BehaviorSubject<bool>();
  final _thuMorning = BehaviorSubject<bool>();
  final _friMorning = BehaviorSubject<bool>();
  final _satMorning = BehaviorSubject<bool>();
  final _sunEvening = BehaviorSubject<bool>();
  final _monEvening = BehaviorSubject<bool>();
  final _tueEvening = BehaviorSubject<bool>();
  final _wedEvening = BehaviorSubject<bool>();
  final _thuEvening = BehaviorSubject<bool>();
  final _friEvening = BehaviorSubject<bool>();
  final _satEvening = BehaviorSubject<bool>();

  final _sunSave = BehaviorSubject<bool>();
  final _monSave = BehaviorSubject<bool>();
  final _tueSave = BehaviorSubject<bool>();
  final _wedSave = BehaviorSubject<bool>();
  final _thuSave = BehaviorSubject<bool>();
  final _friSave = BehaviorSubject<bool>();
  final _satSave = BehaviorSubject<bool>();

  final _db = FirestoreService();

  Stream<bool> get sun => _sun.stream;
  Stream<bool> get mon => _mon.stream;
  Stream<bool> get tue => _tue.stream;
  Stream<bool> get wed => _wed.stream;
  Stream<bool> get thu => _thu.stream;
  Stream<bool> get fri => _fri.stream;
  Stream<bool> get sat => _sat.stream;
  Stream<bool> get sunMorning => _sunMorning.stream;
  Stream<bool> get monMorning => _monMorning.stream;
  Stream<bool> get tueMorning => _tueMorning.stream;
  Stream<bool> get wedMorning => _wedMorning.stream;
  Stream<bool> get thuMorning => _thuMorning.stream;
  Stream<bool> get friMorning => _friMorning.stream;
  Stream<bool> get satMorning => _satMorning.stream;
  Stream<bool> get sunEvening => _sunEvening.stream;
  Stream<bool> get monEvening => _monEvening.stream;
  Stream<bool> get tueEvening => _tueEvening.stream;
  Stream<bool> get wedEvening => _wedEvening.stream;
  Stream<bool> get thuEvening => _thuEvening.stream;
  Stream<bool> get friEvening => _friEvening.stream;
  Stream<bool> get satEvening => _satEvening.stream;

  Stream<bool> get sunSave => _sunSave.stream;
  Stream<bool> get monSave => _monSave.stream;
  Stream<bool> get tueSave => _tueSave.stream;
  Stream<bool> get wedSave => _wedSave.stream;
  Stream<bool> get thuSave => _thuSave.stream;
  Stream<bool> get friSave => _friSave.stream;
  Stream<bool> get satSave => _satSave.stream;

  //*Get this by calling authBloc.userId
  Function(String) get changeUserId => _userId.sink.add;

  Function(bool) get changeSun => _sun.sink.add;
  Function(bool) get changeMon => _mon.sink.add;
  Function(bool) get changeTue => _tue.sink.add;
  Function(bool) get changeWed => _wed.sink.add;
  Function(bool) get changeThu => _thu.sink.add;
  Function(bool) get changeFri => _fri.sink.add;
  Function(bool) get changeSat => _sat.sink.add;
  Function(bool) get changeSunMorning => _sunMorning.sink.add;
  Function(bool) get changeMonMorning => _monMorning.sink.add;
  Function(bool) get changeTueMorning => _tueMorning.sink.add;
  Function(bool) get changeWedMorning => _wedMorning.sink.add;
  Function(bool) get changeThuMorning => _thuMorning.sink.add;
  Function(bool) get changeFriMorning => _friMorning.sink.add;
  Function(bool) get changeSatMorning => _satMorning.sink.add;
  Function(bool) get changeSunEvening => _sunEvening.sink.add;
  Function(bool) get changeMonEvening => _monEvening.sink.add;
  Function(bool) get changeTueEvening => _tueEvening.sink.add;
  Function(bool) get changeWedEvening => _wedEvening.sink.add;
  Function(bool) get changeThuEvening => _thuEvening.sink.add;
  Function(bool) get changeFriEvening => _friEvening.sink.add;
  Function(bool) get changeSatEvening => _satEvening.sink.add;

  Function(bool) get changeSunSave => _sunSave.sink.add;
  Function(bool) get changeMonSave => _monSave.sink.add;
  Function(bool) get changeTueSave => _tueSave.sink.add;
  Function(bool) get changeWedSave => _wedSave.sink.add;
  Function(bool) get changeThuSave => _thuSave.sink.add;
  Function(bool) get changeFriSave => _friSave.sink.add;
  Function(bool) get changeSatSave => _satSave.sink.add;

  dispose() {
    _listingId.close();
    _userId.close();
    _sun.close();
    _mon.close();
    _tue.close();
    _wed.close();
    _thu.close();
    _fri.close();
    _sat.close();
    _sunMorning.close();
    _monMorning.close();
    _tueMorning.close();
    _wedMorning.close();
    _thuMorning.close();
    _friMorning.close();
    _satMorning.close();
    _sunEvening.close();
    _monEvening.close();
    _tueEvening.close();
    _wedEvening.close();
    _thuEvening.close();
    _friEvening.close();
    _satEvening.close();

    _sunSave.close();
    _monSave.close();
    _tueSave.close();
    _wedSave.close();
    _thuSave.close();
    _friSave.close();
    _satSave.close();
  }

  Future<Schedule> fetchSchedule(String userId) => _db.fetchSchedule(userId);

  Future<void> saveMon() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: true,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _thu.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _mon.sink.add(true))
        .catchError((onError) => _mon.sink.add(false));
  }

  Future<void> saveTue() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: true,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _thu.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _tue.sink.add(true))
        .catchError((onError) => _tue.sink.add(false));
  }

  Future<void> saveWed() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: true,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _thu.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _wed.sink.add(true))
        .catchError((onError) => _wed.sink.add(false));
  }

  Future<void> saveThu() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: true,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _thu.sink.add(true))
        .catchError((onError) => _thu.sink.add(false));
  }

  Future<void> saveFri() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _fri.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: true,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _fri.sink.add(true))
        .catchError((onError) => _fri.sink.add(false));
  }

  Future<void> saveSat() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _fri.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _sat.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: true,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _sat.sink.add(true))
        .catchError((onError) => _sat.sink.add(false));
  }

  Future<void> saveSun() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _fri.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _sat.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: true,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => _sun.sink.add(true))
        .catchError((onError) => _sun.sink.add(false));
  }

  Future<void> cancelMon() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: false,
      monMorning: false,
      monEvening: false,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _thu.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => {
              _mon.sink.add(false),
              _monMorning.sink.add(false),
              _monEvening.sink.add(false),
            })
        .catchError((onError) => _mon.sink.add(false));
  }

  Future<void> cancelTue() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: false,
      tueMorning: false,
      tueEvening: false,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _thu.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => {
              _tue.sink.add(false),
              _tueMorning.sink.add(false),
              _tueEvening.sink.add(false),
            })
        .catchError((onError) => _tueSave.sink.add(false));
  }

  Future<void> cancelWed() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: false,
      wedMorning: false,
      wedEvening: false,
      thu: _thu.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => {
              _wed.sink.add(false),
              _wedMorning.sink.add(false),
              _wedEvening.sink.add(false),
            })
        .catchError((onError) => _wedSave.sink.add(false));
  }

  Future<void> cancelThu() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: false,
      thuMorning: false,
      thuEvening: false,
      fri: _fri.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => {
              _thu.sink.add(false),
              _thuMorning.sink.add(false),
              _thuEvening.sink.add(false),
            })
        .catchError((onError) => _thuSave.sink.add(false));
  }

  Future<void> cancelFri() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _fri.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: false,
      friMorning: false,
      friEvening: false,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => {
              _fri.sink.add(false),
              _friMorning.sink.add(false),
              _friEvening.sink.add(false),
            })
        .catchError((onError) => _friSave.sink.add(false));
  }

  Future<void> cancelSat() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _fri.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _sat.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: false,
      satMorning: false,
      satEvening: false,
      sun: _sun.value,
      sunMorning: _sunMorning.value,
      sunEvening: _sunEvening.value,
    );

    return _db
        .setSchedule(schedule)
        .then((value) => {
              _sat.sink.add(false),
              _satMorning.sink.add(false),
              _satEvening.sink.add(false),
            })
        .catchError((onError) => _satSave.sink.add(false));
  }

  Future<void> cancelSun() async {
    var schedule = Schedule(
      userId: _userId.value,
      mon: _mon.value,
      monMorning: _monMorning.value,
      monEvening: _monEvening.value,
      tue: _tue.value,
      tueMorning: _tueMorning.value,
      tueEvening: _tueEvening.value,
      wed: _wed.value,
      wedMorning: _wedMorning.value,
      wedEvening: _wedEvening.value,
      thu: _fri.value,
      thuMorning: _thuMorning.value,
      thuEvening: _thuEvening.value,
      fri: _sat.value,
      friMorning: _friMorning.value,
      friEvening: _friEvening.value,
      sat: _sat.value,
      satMorning: _satMorning.value,
      satEvening: _satEvening.value,
      sun: false,
      sunMorning: false,
      sunEvening: false,
    );

    return _db.setSchedule(schedule).then((value) {
      _sun.sink.add(false);
      _sunMorning.sink.add(false);
      _sunEvening.sink.add(false);
    }).catchError((onError) => _sun.sink.add(false));
  }
}
