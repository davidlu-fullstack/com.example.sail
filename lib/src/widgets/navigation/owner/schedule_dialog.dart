import 'package:flutter/material.dart';
import 'package:sail/src/blocs/schedule_bloc.dart';
import 'package:sail/src/styles/colors.dart';

class ScheduleAlert extends StatelessWidget {
  final ScheduleBloc scheduleBloc;
  final Stream<bool> streamDay;
  final Stream<bool> streamMorning;
  final Stream<bool> streamEvening;
  final String day;
  dynamic Function(bool) changeMorning;
  dynamic Function(bool) changeEvening;
  final void Function() save;
  final void Function() cancel;
  ScheduleAlert(
      {@required this.scheduleBloc,
      @required this.streamDay,
      @required this.streamMorning,
      @required this.streamEvening,
      @required this.day,
      @required this.changeMorning,
      @required this.changeEvening,
      @required this.save,
      @required this.cancel});

  @override
  Widget build(BuildContext context) {
    bool morning = false;
    bool evening = false;
    return AlertDialog(
      title: Center(
        child: Text('$day'), //! passed in value
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            StreamBuilder<bool>(
              stream: streamDay, //! passed in value
              builder: (context, snapshot) {
                return (snapshot.data == false)
                    ? ListBody(
                        children: <Widget>[
                          StreamBuilder<bool>(
                              stream: streamMorning, //!passed in value
                              builder: (context, snapshot) {
                                return RaisedButton(
                                  color: (snapshot.data == false)
                                      ? ColorStyle.logoGold
                                      : ColorStyle.greenConfirm,
                                  child: Text('Morning'),
                                  onPressed: () {
                                    morning = !morning;
                                    changeMorning(
                                        morning); //!passed in function
                                  },
                                );
                              }),
                          StreamBuilder<bool>(
                              stream: streamEvening, //!passed in value
                              builder: (context, snapshot) {
                                return RaisedButton(
                                  color: (snapshot.data == false)
                                      ? ColorStyle.logoGold
                                      : ColorStyle.greenConfirm,
                                  child: Text('Evening'),
                                  onPressed: () {
                                    evening = !evening;
                                    changeEvening(evening); //!passed in value
                                  },
                                );
                              }),
                          RaisedButton(
                            color: ColorStyle.logoGold,
                            child: Text('Save'),
                            onPressed: () {
                              save(); //!passed in value
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    : (snapshot.data == true)
                        ? Column(
                            children: <Widget>[
                              RaisedButton(
                                color: ColorStyle.error,
                                child: Text('Cancel'),
                                onPressed: () {
                                  morning = false;
                                  evening = false;
                                  cancel(); //!passed in value
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        : CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
