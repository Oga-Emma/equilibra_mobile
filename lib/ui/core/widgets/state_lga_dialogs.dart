//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//
//class SelectLgaDialog extends StatelessWidget {
//  SelectLgaDialog(this.stateGovernmentID);
//
//  String stateGovernmentID;
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      content: Container(
//        child: Query(
//          options: QueryOptions(
//            context: <String, dynamic>{
//              'headers': <String, String>{
//                'Authorization': 'Bearer ${appState.token}',
//              },
//            },
//            document: GovernmentQueryMutations
//                .localGovernments(), // this is the query string you just created
//            variables: {
//              'stateGovernmentID': stateGovernmentID,
//            },
//          ),
//          // Just like in apollo refetch() could be used to manually trigger a refetch
//          // while fetchMore() can be used for pagination purpose
//          builder: (QueryResult result,
//              {VoidCallback refetch, FetchMore fetchMore}) {
//            if (result.data != null) {
////           print("list => ${(result.data as LazyCacheMap).data['state']}");
////
////           states.clear();
//              List<TitleId> lgas = [];
//              List listOfState = (result.data as LazyCacheMap).data['state'];
//              for (var lga in listOfState) {
//                lgas.add(TitleId.fromMap(lga));
//              }
//
////            if(listOfState.isNotEmpty){
////              Future.delayed(Duration.zero, (){
////                setState(() {
////                  start = states.length;
////                });
////              });
////            }
//
//              return FilterableList(lgas);
//            }
//
////            if (result.exception.toString() != null) {
////              if (result.exception
////                  .toString()
////                  .toString()
////                  .contains("Failed host")) {
////                return Center(
////                  child: Text("No internet connection"),
////                );
////              }
////
////              print("Error => ${result.exception.toString()}");
//////                return Text(result.exception.toString().toString());
////              return Center(
////                  child: Text("Error fetching data, please try again"));
////            }
//
////            if (result.loading) {
////            }
//
//            if (result.hasException) {
//              print("Error => ${result.exception.toString()}");
//              return Center(
//                  child: Text("Error fetching data, please try again"));
//            }
//            return Center(child: CircularProgressIndicator());
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class SelectSenatorialDialog extends StatelessWidget {
//  SelectSenatorialDialog(this.stateGovernmentID);
//
//  String stateGovernmentID;
//  AppStateProvider appState;
//  @override
//  Widget build(BuildContext context) {
//    appState = Provider.of<AppStateProvider>(context);
//    return AlertDialog(
//      content: Container(
//        child: Query(
//          options: QueryOptions(
//            context: <String, dynamic>{
//              'headers': <String, String>{
//                'Authorization': 'Bearer ${appState.token}',
//              },
//            },
//            document: GovernmentQueryMutations
//                .fetchConstituency(), // this is the query string you just created
//            variables: {
//              'stateGovernmentID': stateGovernmentID,
//              'roomType': 'SENATE'
//            },
//          ),
//          builder: (QueryResult result,
//              {VoidCallback refetch, FetchMore fetchMore}) {
//            if (result.data != null) {
//              print("list => ${(result.data as LazyCacheMap).data['state']}");
//
//              List<TitleId> lgas = [];
//              List listOfState = (result.data as LazyCacheMap).data['state'];
//              for (var lga in listOfState) {
//                lgas.add(TitleId.fromMap(lga));
//              }
//
//              return FilterableList(lgas);
//            }
//
////            if (result.exception.toString() != null) {
////              if (result.exception
////                  .toString()
////                  .toString()
////                  .contains("Failed host")) {
////                return Center(
////                  child: Text("No internet connection"),
////                );
////              }
////
////              print("Error => ${result.exception.toString()}");
//////                return Text(result.exception.toString().toString());
////              return Center(
////                  child: Text("Error fetching data, please try again"));
////            }
//
////            if (result.loading) {
////            }
//
//            if (result.hasException) {
//              print("Error => ${result.exception.toString()}");
//              return Center(
//                  child: Text("Error fetching data, please try again"));
//            }
//
//            return Center(child: CircularProgressIndicator());
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class SelectFederalConstituencyDialog extends StatelessWidget {
//  SelectFederalConstituencyDialog(this.stateGovernmentID);
//
//  String stateGovernmentID;
//  AppStateProvider appState;
//  @override
//  Widget build(BuildContext context) {
//    appState = Provider.of<AppStateProvider>(context);
//    return AlertDialog(
//      content: Container(
//        child: Query(
//          options: QueryOptions(
//            context: <String, dynamic>{
//              'headers': <String, String>{
//                'Authorization': 'Bearer ${appState.token}',
//              },
//            },
//            document: GovernmentQueryMutations
//                .fetchConstituency(), // this is the query string you just created
//            variables: {
//              'stateGovernmentID': stateGovernmentID,
//              'roomType': 'HOUSE_OF_REPRESENTATIVE'
//            },
//          ),
//          // Just like in apollo refetch() could be used to manually trigger a refetch
//          // while fetchMore() can be used for pagination purpose
//          builder: (QueryResult result,
//              {VoidCallback refetch, FetchMore fetchMore}) {
//            if (result.data != null) {
////           print("list => ${(result.data as LazyCacheMap).data['state']}");
//
//              List<TitleId> lgas = [];
//              List listOfState = (result.data as LazyCacheMap).data['state'];
//              for (var lga in listOfState) {
//                lgas.add(TitleId.fromMap(lga));
//              }
//
//              return FilterableList(lgas);
//            }
////            if (result.exception.toString() != null) {
////              if (result.exception
////                  .toString()
////                  .toString()
////                  .contains("Failed host")) {
////                return Center(
////                  child: Text("No internet connection"),
////                );
////              }
////
////              print("Error => ${result.exception.toString()}");
//////                return Text(result.exception.toString().toString());
////              return Center(
////                  child: Text("Error fetching data, please try again"));
////            }
////
////            if (result.loading) {
////            }
//
//            if (result.hasException) {
//              print("Error => ${result.exception.toString()}");
//              return Center(
//                  child: Text("Error fetching data, please try again"));
//            }
//
//            return Center(child: CircularProgressIndicator());
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class SelectStateConstituencyDialog extends StatelessWidget {
//  SelectStateConstituencyDialog(this.stateGovernmentID);
//
//  String stateGovernmentID;
//  AppStateProvider appState;
//  @override
//  Widget build(BuildContext context) {
//    appState = Provider.of<AppStateProvider>(context);
//    return AlertDialog(
//      content: Container(
//        child: Query(
//          options: QueryOptions(
//            context: <String, dynamic>{
//              'headers': <String, String>{
//                'Authorization': 'Bearer ${appState.token}',
//              },
//            },
//            document: GovernmentQueryMutations
//                .fetchConstituency(), // this is the query string you just created
//            variables: {
//              'stateGovernmentID': stateGovernmentID,
//              'roomType': 'HOUSE_OF_ASSEMBLY'
//            },
//          ),
//          // Just like in apollo refetch() could be used to manually trigger a refetch
//          // while fetchMore() can be used for pagination purpose
//          builder: (QueryResult result,
//              {VoidCallback refetch, FetchMore fetchMore}) {
//            if (result.data != null) {
////           print("list => ${(result.data as LazyCacheMap).data['state']}");
//
//              List<TitleId> lgas = [];
//              List listOfState = (result.data as LazyCacheMap).data['state'];
//              for (var lga in listOfState) {
//                lgas.add(TitleId.fromMap(lga));
//              }
//
//              return FilterableList(lgas);
//            }
////            if (result.exception.toString() != null) {
//
////              if (result.exception
////                  .toString()
////                  .toString()
////                  .contains("Failed host")) {
////                return Center(
////                  child: Text("No internet connection"),
////                );
////              }
////
////              print("Error => ${result.exception.toString()}");
//////                return Text(result.exception.toString().toString());
////              return Center(
////                  child: Text("Error fetching data, please try again"));
////            }
////
////            if (result.loading) {
////            }
//
//            if (result.hasException) {
//              print("Error => ${result.exception.toString()}");
//              return Center(
//                  child: Text("Error fetching data, please try again"));
//            }
//
//            return Center(child: CircularProgressIndicator());
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class FilterableList extends StatefulWidget {
//  FilterableList(this.list);
//  final List<TitleId> list;
//
//  @override
//  _FilterableListState createState() => _FilterableListState();
//}
//
//class _FilterableListState extends State<FilterableList> {
//  String searchedText = "";
//  List<TitleId> filteredList = [];
//
//  @override
//  Widget build(BuildContext context) {
//    filteredList.clear();
//    filteredList
//        .addAll(widget.list.where((sta) => sta.name.contains(searchedText)));
//    return Container(
//      height: MediaQuery.of(context).size.height / 2,
//      width: double.maxFinite,
//      child: Column(
//        children: <Widget>[
//          TextField(
//            decoration: InputDecoration(hintText: "Search"),
//            onChanged: (value) {
//              setState(() {
//                searchedText = value.toLowerCase();
//              });
//            },
//          ),
//          emptySpace(),
//          Expanded(
//            child: ListView.builder(
//                itemCount: filteredList.length,
//                itemBuilder: (context, index) {
//                  var name = filteredList[index].name;
//                  name = StringUtils.toTitleCase(filteredList[index].name);
//                  return ListTile(
//                    title: Text(name),
//                    onTap: () => Navigator.pop(context, filteredList[index]),
//                  );
//                }),
//          ),
//        ],
//      ),
//    );
//  }
//}
