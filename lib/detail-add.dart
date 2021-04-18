import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_info_assignment/model/PersonInfoModel.dart';
import 'package:person_info_assignment/bloc/person_info/person_info_bloc.dart';

class DetailAddPage extends StatefulWidget {
  final PersonInfo personInfo;

  DetailAddPage({Key key, this.personInfo}) : super(key: key);

  @override
  _DetailAddPageState createState() => _DetailAddPageState();
}

class _DetailAddPageState extends State<DetailAddPage> {
  var item = PersonInfo();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var phoneNo = TextEditingController();
  var address = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    firstName.clear();
    lastName.clear();
    email.clear();
    phoneNo.clear();
    address.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final PersonInfoBloc _personInfoBloc =
        BlocProvider.of<PersonInfoBloc>(context);
    return BlocBuilder(
        bloc: _personInfoBloc,
        builder: (BuildContext context, PersonInfoState state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  title: Text(
                widget.personInfo == null
                    ? 'Add Person Info'
                    : 'Detail Person Info',
              )),
              body: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: widget.personInfo == null
                      ? buildWidget()
                      : buildPersonInfoDetail()),
              floatingActionButton: new Visibility(
                  visible: widget.personInfo == null,
                  child: FloatingActionButton(
                    child: Icon(Icons.save),
                    onPressed: () {
                      item = PersonInfo(
                          address: address.text,
                          email: email.text,
                          mobile: phoneNo.text,
                          lastName: lastName.text,
                          firstName: firstName.text);
                      _personInfoBloc.add(AddInfo(item));
                      Navigator.of(context).pop();
                    },
                  )));
        });
  }

  Widget buildWidget() {
    return Column(
      children: <Widget>[
        buildFirstNameInput(),
        buildLastNameInput(),
        buildPhoneNumberInput(),
        buildEmailInput(),
        buildAddressInput()
      ],
    );
  }

  Widget buildFirstNameInput() {
    return Card(
      elevation: 8.0,
      child: TextField(
        controller: firstName,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            hintText: 'First Name',
            labelText: 'First Name'),
      ),
    );
  }

  Widget buildLastNameInput() {
    return Card(
      elevation: 8.0,
      child: TextField(
        controller: lastName,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            hintText: 'Last Name',
            labelText: 'Last Name'),
      ),
    );
  }

  Widget buildPhoneNumberInput() {
    return Card(
      elevation: 8.0,
      child: TextField(
        controller: phoneNo,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            hintText: 'Phone Number',
            labelText: 'Phone Number'),
      ),
    );
  }

  Widget buildEmailInput() {
    return Card(
      elevation: 8.0,
      child: TextField(
        controller: email,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            hintText: 'Email',
            labelText: 'Email'),
      ),
    );
  }

  Widget buildAddressInput() {
    return Card(
      elevation: 8.0,
      child: TextField(
        controller: address,
        minLines: 3,
        maxLines: 3,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            hintText: 'Address',
            labelText: 'Address'),
      ),
    );
  }

  Widget buildPersonInfoDetail() {
    return ListView(
      children: <Widget>[
        listTile("${widget.personInfo.firstName} ${widget.personInfo.lastName}",
            Icons.account_circle),
        listTile(widget.personInfo.mobile, Icons.phone),
        listTile(widget.personInfo.email, Icons.email),
        listTile(widget.personInfo.address, Icons.location_on),
      ],
    );
  }

  Widget listTile(String text, IconData icon) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text(
            text,
            style: new TextStyle(
              color: Colors.blueGrey[400],
              fontSize: 20.0,
            ),
          ),
          leading: new Icon(
            icon,
            color: Colors.blue[400],
          ),
        ),
        new Container(
          height: 0.3,
          color: Colors.blueGrey[400],
        )
      ],
    );
  }
}
