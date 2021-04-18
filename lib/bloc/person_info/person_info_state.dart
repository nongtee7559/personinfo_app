part of 'person_info_bloc.dart';

@immutable
abstract class PersonInfoState {}

class InitialPersonInfoState extends PersonInfoState {}

class LoadedPersonInfoState extends PersonInfoState{
  final PersonInfoModel personInfoModel;
  LoadedPersonInfoState(this.personInfoModel);
}