part of 'person_info_bloc.dart';

@immutable
abstract class PersonInfoEvent {}

class LoadInfo extends PersonInfoEvent{
  @override
  String toString() => "LoadedInfo";
}

class AddInfo extends PersonInfoEvent{
  final PersonInfo personInfo;
  AddInfo(this.personInfo);
  @override
  String toString() => "AddInfo";
}


class DeleteInfo extends PersonInfoEvent{
  final int index;
  DeleteInfo(this.index);
  @override
  String toString() => "DeleteInfo";
}