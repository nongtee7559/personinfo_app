import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:person_info_assignment/model/PersonInfoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'person_info_event.dart';

part 'person_info_state.dart';

const PREF_INFO = "personInfo";

class PersonInfoBloc extends Bloc<PersonInfoEvent, PersonInfoState> {
  @override
  PersonInfoState get initialState => InitialPersonInfoState();

  @override
  Stream<PersonInfoState> mapEventToState(PersonInfoEvent event) async* {
    if (event is LoadInfo) {
      yield* _mapLoadInfoToState();
    } else if (event is AddInfo) {
      yield* _mapAddInfoToState(event);
    } else if (event is DeleteInfo) {
      yield* _mapDeleteInfoToState(event);
    }
  }

  Stream<PersonInfoState> _mapLoadInfoToState() async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var info = pref.getString(PREF_INFO);
    if (info == null) {
      yield LoadedPersonInfoState(new PersonInfoModel(personInfo: []));
    } else {
      var infoMap = json.decode(info);
      var data = PersonInfoModel.fromJson(infoMap);
      yield LoadedPersonInfoState(data);
    }
    yield LoadedPersonInfoState(new PersonInfoModel(personInfo: []));
  }

  Stream<PersonInfoState> _mapAddInfoToState(AddInfo event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var personInfoModel = (state as LoadedPersonInfoState).personInfoModel;
    personInfoModel.personInfo.add(new PersonInfo(
      firstName: event.personInfo.firstName,
      lastName: event.personInfo.lastName,
      mobile: event.personInfo.mobile,
      email: event.personInfo.email,
      address: event.personInfo.address
    ));
    pref.setString(PREF_INFO, json.encode(personInfoModel));
    yield LoadedPersonInfoState(personInfoModel);
  }

  Stream<PersonInfoState> _mapDeleteInfoToState(DeleteInfo event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var personInfoModel = (state as LoadedPersonInfoState).personInfoModel;
    personInfoModel.personInfo.removeAt(event.index);
    pref.setString(PREF_INFO, json.encode(personInfoModel));
    yield LoadedPersonInfoState(personInfoModel);
  }
}
