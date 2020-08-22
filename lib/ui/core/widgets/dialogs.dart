import 'package:equilibra_mobile/di/controllers/data_controller.dart';
import 'package:equilibra_mobile/model/dto/filterable_list_item.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';

class SelectStateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<DataController>(context);
    return AlertDialog(
      content: Container(
        child: StreamBuilder<List<GovernmentDTO>>(
            stream: controller.fetchGovernments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FilterableList(snapshot.data);
              }

              return LoadingSpinner();
            }),
      ),
    );
  }
}

class SelectLgaDialog extends StatelessWidget {
  SelectLgaDialog(this.state);

  final String state;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<DataController>(context);
    return AlertDialog(
      content: Container(
        child: FutureBuilder<List<RoomDTO>>(
            future: controller.fetchLGA(state),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FilterableList(snapshot.data);
              }

              return LoadingSpinner();
            }),
      ),
    );
  }
}

class SelectSenatorialDialog extends StatelessWidget {
  SelectSenatorialDialog(this.state);

  final String state;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<DataController>(context);
    return AlertDialog(
      content: Container(
        child: FutureBuilder<List<RoomDTO>>(
            future: controller.fetchSenateRooms(state),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FilterableList(snapshot.data);
              }

              return LoadingSpinner();
            }),
      ),
    );
  }
}

class SelectFederalConstituencyDialog extends StatelessWidget {
  SelectFederalConstituencyDialog(this.state);

  final String state;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<DataController>(context);
    return AlertDialog(
      content: Container(
        child: FutureBuilder<List<RoomDTO>>(
            future: controller.fetchHouseOfRep(state),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FilterableList(snapshot.data);
              }

              return LoadingSpinner();
            }),
      ),
    );
  }
}

class SelectStateConstituencyDialog extends StatelessWidget {
  SelectStateConstituencyDialog(this.state);

  final String state;
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<DataController>(context);
    return AlertDialog(
      content: Container(
        child: FutureBuilder<List<RoomDTO>>(
            future: controller.fetchHouseOfAssembly(state),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FilterableList(snapshot.data);
              }

              return LoadingSpinner();
            }),
      ),
    );
  }
}

class FilterableList extends StatefulWidget {
  FilterableList(this.list);
  final List<FilterableListItem> list;

  @override
  _FilterableListState createState() => _FilterableListState();
}

class _FilterableListState extends State<FilterableList> {
  String searchedText = "";
  List<FilterableListItem> filteredList = [];

  @override
  Widget build(BuildContext context) {
    filteredList.clear();
    filteredList
        .addAll(widget.list.where((sta) => sta.name.contains(searchedText)));
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Search"),
            onChanged: (value) {
              setState(() {
                searchedText = value.toLowerCase();
              });
            },
          ),
          EmptySpace(),
          Expanded(
            child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  var name = filteredList[index].name;
                  name = StringUtils.toTitleCase(filteredList[index].name);
                  return ListTile(
                    title: Text(name),
                    onTap: () => Navigator.pop(context, filteredList[index]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
