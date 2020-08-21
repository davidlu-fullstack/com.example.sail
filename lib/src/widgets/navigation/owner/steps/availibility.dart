import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/blocs/schedule_bloc.dart';
import 'package:sail/src/models/schedule.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/widgets/navigation/owner/schedule_dialog.dart';

//! NEED TO INITIALIZE VALUES ESPECIALLY USERID!

class Availibility extends StatefulWidget {
  @override
  _AvailibilityState createState() => _AvailibilityState();
}

class _AvailibilityState extends State<Availibility> {
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    var scheduleBloc = Provider.of<ScheduleBloc>(context);
    scheduleBloc.changeUserId(authBloc.userId);

    return FutureBuilder<Schedule>(
      future: scheduleBloc.fetchSchedule(authBloc.userId),
      builder: (context, snapshot) {
        Schedule existingSchedule;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            existingSchedule = snapshot.data;
            initValues(scheduleBloc, existingSchedule, authBloc.userId);
          } else if (!snapshot.hasData) {
            initValues(scheduleBloc, existingSchedule, authBloc.userId);
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //TODO: When pressed, dialog box appears where user can pick time?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorStyle.logoGold,
                    boxShadow: BaseStyles.boxShadow),
                child: Center(
                  child: Text('Availability'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                decoration: BoxDecoration(boxShadow: BaseStyles.boxShadow),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Sunday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.sun,
                                streamMorning: scheduleBloc.sunMorning,
                                streamEvening: scheduleBloc.sunEvening,
                                changeEvening: scheduleBloc.changeSunEvening,
                                changeMorning: scheduleBloc.changeSunMorning,
                                save: scheduleBloc.saveSun,
                                cancel: scheduleBloc.cancelSun,
                              );
                            },
                          )
                        },
                        child: StreamBuilder<bool>(
                            stream: scheduleBloc.sun,
                            builder: (context, snapshot) {
                              return Container(
                                height: 100,
                                width: 100,
                                color: (snapshot.data == false)
                                    ? Colors.white
                                    : ColorStyle.complimentBlue,
                                child: Center(
                                  child: Text('Sun'),
                                ),
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Monday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.mon,
                                streamMorning: scheduleBloc.monMorning,
                                streamEvening: scheduleBloc.monEvening,
                                changeEvening: scheduleBloc.changeMonEvening,
                                changeMorning: scheduleBloc.changeMonMorning,
                                save: scheduleBloc.saveMon,
                                cancel: scheduleBloc.cancelMon,
                              );
                            },
                          )
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text('Mon'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Tuesday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.tue,
                                streamMorning: scheduleBloc.tueMorning,
                                streamEvening: scheduleBloc.tueEvening,
                                changeEvening: scheduleBloc.changeTueEvening,
                                changeMorning: scheduleBloc.changeTueMorning,
                                save: scheduleBloc.saveTue,
                                cancel: scheduleBloc.cancelTue,
                              );
                            },
                          )
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text('Tue'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Wednesday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.wed,
                                streamMorning: scheduleBloc.wedMorning,
                                streamEvening: scheduleBloc.wedEvening,
                                changeEvening: scheduleBloc.changeWedEvening,
                                changeMorning: scheduleBloc.changeWedMorning,
                                save: scheduleBloc.saveWed,
                                cancel: scheduleBloc.cancelWed,
                              );
                            },
                          )
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text('Wed'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Thursday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.thu,
                                streamMorning: scheduleBloc.thuMorning,
                                streamEvening: scheduleBloc.thuEvening,
                                changeEvening: scheduleBloc.changeThuEvening,
                                changeMorning: scheduleBloc.changeThuMorning,
                                save: scheduleBloc.saveThu,
                                cancel: scheduleBloc.cancelThu,
                              );
                            },
                          )
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text('Thu'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Friday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.fri,
                                streamMorning: scheduleBloc.friMorning,
                                streamEvening: scheduleBloc.friEvening,
                                changeEvening: scheduleBloc.changeFriEvening,
                                changeMorning: scheduleBloc.changeFriMorning,
                                save: scheduleBloc.saveFri,
                                cancel: scheduleBloc.cancelFri,
                              );
                            },
                          )
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text('Fri'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return ScheduleAlert(
                                day: 'Saturday',
                                scheduleBloc: scheduleBloc,
                                streamDay: scheduleBloc.sat,
                                streamMorning: scheduleBloc.satMorning,
                                streamEvening: scheduleBloc.satEvening,
                                changeEvening: scheduleBloc.changeSatEvening,
                                changeMorning: scheduleBloc.changeSatMorning,
                                save: scheduleBloc.saveSat,
                                cancel: scheduleBloc.cancelSat,
                              );
                            },
                          )
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text('Sat'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

initValues(ScheduleBloc scheduleBloc, Schedule schedule, String userId) {
  if (schedule != null) {
    scheduleBloc.changeSun(schedule.sun);
    scheduleBloc.changeSunMorning(schedule.sunMorning);
    scheduleBloc.changeSunEvening(schedule.sunEvening);
    scheduleBloc.changeMon(schedule.mon);
    scheduleBloc.changeMonMorning(schedule.monMorning);
    scheduleBloc.changeMonEvening(schedule.monEvening);
    scheduleBloc.changeTue(schedule.tue);
    scheduleBloc.changeTueMorning(schedule.tueMorning);
    scheduleBloc.changeTueEvening(schedule.tueEvening);
    scheduleBloc.changeWed(schedule.wed);
    scheduleBloc.changeWedMorning(schedule.wedMorning);
    scheduleBloc.changeWedEvening(schedule.wedEvening);
    scheduleBloc.changeThu(schedule.thu);
    scheduleBloc.changeThuMorning(schedule.thuMorning);
    scheduleBloc.changeThuEvening(schedule.thuEvening);
    scheduleBloc.changeFri(schedule.fri);
    scheduleBloc.changeFriMorning(schedule.friMorning);
    scheduleBloc.changeFriEvening(schedule.friEvening);
    scheduleBloc.changeSat(schedule.sat);
    scheduleBloc.changeSatMorning(schedule.satMorning);
    scheduleBloc.changeSatEvening(schedule.satEvening);
  } else {
    scheduleBloc.changeSun(false);
    scheduleBloc.changeSunMorning(false);
    scheduleBloc.changeSunEvening(false);
    scheduleBloc.changeMon(false);
    scheduleBloc.changeMonMorning(false);
    scheduleBloc.changeMonEvening(false);
    scheduleBloc.changeTue(false);
    scheduleBloc.changeTueMorning(false);
    scheduleBloc.changeTueEvening(false);
    scheduleBloc.changeWed(false);
    scheduleBloc.changeWedMorning(false);
    scheduleBloc.changeWedEvening(false);
    scheduleBloc.changeThu(false);
    scheduleBloc.changeThuMorning(false);
    scheduleBloc.changeThuEvening(false);
    scheduleBloc.changeFri(false);
    scheduleBloc.changeFriMorning(false);
    scheduleBloc.changeFriEvening(false);
    scheduleBloc.changeSat(false);
    scheduleBloc.changeSatMorning(false);
    scheduleBloc.changeSatEvening(false);
  }
}
