import 'package:flutter/material.dart';

enum Importance { yellow, orange, red, darkBlue, clear }

Color textColor = Colors.orange;

var date = DateTime.parse(DateTime.now().toString());

extension ParseToString on Importance {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

titleTextColor(Importance value) {
  switch (value.toShortString()) {
    case 'yellow':
      textColor = Colors.yellow;
      break;
    case 'orange':
      textColor = Colors.orange;
      break;
    case 'red':
      textColor = Colors.red;
      break;
    case 'darkBlue':
      textColor = Colors.blue.shade900;
      break;
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Importance? _chosenValue;
  List<Todo> resultList = [];

  List<Todo> myTodo = [
    Todo('Eat breakfast', 'Eat some healthy food with coffee', '16.09.2021',
        Importance.yellow),
    Todo('Play videogames', 'Complete one level', '16.09.2021', Importance.red),
    Todo('Talk to Liana', 'Discuss the latest news', '16.09.2021',
        Importance.orange),
    Todo('Talk to Dasha', 'Talk to Dasha about university problems',
        '16.09.2021', Importance.darkBlue),
  ];

  String newTitle = '';
  String newDescription = '';
  String newDate ='';
  Importance? newCategory;

  getNewList() {
    resultList.clear();
    for (var element in myTodo) {
      resultList.add(element);
    }
  }

  getFilteredList(Importance? value) {
    getNewList();
    if(value != Importance.clear){
    for (var element in myTodo) {
      if (value != null && element.importance != value) {
        setState(() {
          resultList.remove(element);
        });}
      }
    }else{
      _chosenValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getFilteredList(_chosenValue);
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: DropdownButton<Importance>(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.deepOrange,
                ),
                isExpanded: true,
                dropdownColor: Colors.white,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                value: _chosenValue,
                items: Importance.values.map((Importance value) {
                  return DropdownMenuItem<Importance>(
                    value: value,
                    child: Text(
                      value.toShortString(),
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  );
                }).toList(),
                onChanged: (Importance? value) {
                  setState(() {
                    _chosenValue = value;
                    // getNewList();
                    // getFilteredList(_chosenValue);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: resultList.length,
                    itemBuilder: (BuildContext context, int index) {
                      titleTextColor(resultList[index].importance);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          height: 400,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: textColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Text(
                                  resultList[index].title,
                                  style:
                                      TextStyle(color: textColor, fontSize: 30),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    resultList[index].description,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 20),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                              resultList[index].dateOfCreation),

                                          // Text(myTodo[index].importance),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            FloatingActionButton(onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {


                  // return StatefulBuilder(
                  //   builder:(context, setState) {
                      return AlertDialog(

                      title: const Text('Add new ToDo'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Enter title:'),
                            TextField(
                              onChanged: (String value) {
                                newTitle = value;
                              },
                            ),
                            Text('Enter description:'),
                            TextField(
                              onChanged: (String value) {
                                newDescription = value;
                                newDate = '${date.day}.0${date.month}.${date.year}';
                              },
                            ),
                             StatefulBuilder(
                              builder:(context, setState) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: DropdownButton<Importance>(
                                icon: Icon(
                                  Icons.filter_alt_outlined,
                                  color: Colors.deepOrange,
                                ),
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                value: newCategory,
                                items: Importance.values.map((Importance value) {

                                  return DropdownMenuItem<Importance>(
                                    value: value,
                                    child: Text(
                                      value.toShortString(),
                                      style: TextStyle(color: Colors.deepOrange),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Importance? value) {

                                  setState(() {
                                    newCategory = value;

                                  });
                                },
                              ),
                            );})


                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Approve', style: TextStyle(color: Colors.deepOrange),),
                          onPressed: () {
                            setState(() {
                              myTodo.add(Todo(newTitle, newDescription, newDate, newCategory!));
                              newTitle = '';
                              newDescription = '';
                              newDate ='';
                               newCategory = Importance.darkBlue;
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );}
                  );
              //   },
              // );
            })
          ],
        ),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;
  final String dateOfCreation;
  final Importance importance;

  Todo(this.title, this.description, this.dateOfCreation, this.importance);
}
