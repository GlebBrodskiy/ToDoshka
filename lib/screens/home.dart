import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

enum Importance { yellow, purple, pink, blue, clear }
enum ImportanceDialog {
  yellow,
  purple,
  pink,
  blue,
}

const Color pinkColor = Color.fromRGBO(255, 238, 232, 1);
const Color yellowColor = Color.fromRGBO(253, 243, 222, 1);
const Color blueColor = Color.fromRGBO(213, 238, 255, 1);
const Color purpleColor = Color.fromRGBO(233, 223, 255, 1);
const Color buttonColor = Color.fromRGBO(24, 95, 255, 1);

Color textColor = Colors.black;
Color backColor = Colors.black;

var date = DateTime.parse(DateTime.now().toString());

extension ParseToString on Importance {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

titleTextColor(Importance value) {
  switch (value.toShortString()) {
    case 'yellow':
      backColor = yellowColor;

      break;
    case 'purple':
      backColor = purpleColor;
      break;
    case 'pink':
      backColor = pinkColor;
      break;
    case 'blue':
      backColor = blueColor;
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
    Todo('Eat breakfast', 'Eat some healthy food with coffee', null,
        Importance.yellow),
    Todo('Play videogames', 'Complete one level', null, Importance.pink),
    Todo('Talk to Liana', 'Discuss the latest news', null, Importance.purple),
    Todo('Talk to Dasha', 'Talk to Dasha about university problems', null,
        Importance.blue),
  ];

  String newTitle = '';
  String newDescription = '';
  DateTime? newDate;

  DateTime? neededDate;
  Importance? newCategory;

  getNewList() {
    resultList.clear();
    for (var element in myTodo) {
      resultList.add(element);
    }
  }

  getFilteredList(Importance? value) {
    getNewList();
    if (value != Importance.clear) {
      for (var element in myTodo) {
        if (value != null && element.importance != value) {
          setState(() {
            resultList.remove(element);
          });
        }
      }
    } else {
      _chosenValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getFilteredList(_chosenValue);
    });
    return Stack(
      children: [Container(
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
                    color: buttonColor,
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
                        style: TextStyle(color: buttonColor),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    // width: MediaQuery.of(context).size.width*0.8,
                    // height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: resultList.length,
                        itemBuilder: (BuildContext context, int index) {
                          titleTextColor(resultList[index].importance);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Card(
                                color: backColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: backColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 20),
                                        child: Text(
                                          resultList[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        resultList[index].description,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
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
                                                  '${resultList[index].dateOfCreation?.day}.0${resultList[index].dateOfCreation?.month}.${resultList[index].dateOfCreation?.year}  ${resultList[index].dateOfCreation?.hour}:${resultList[index].dateOfCreation?.minute}'),

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
              ),

            ],
          ),
        ),
      ),
        Padding(
          padding: const EdgeInsets.only(right: 40, bottom: 50),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                child: const Icon(Icons.add, color: Colors.white),
                backgroundColor: buttonColor,
                onPressed: () {
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
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.title),
                                    hintText: 'Title',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    )
                                  ),
                                  onChanged: (String value) {
                                    newTitle = value;
                                  },
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.description),
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30)
                                    )
                                  ),
                                  onChanged: (String value) {
                                    newDescription = value;
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          child: DropdownButton<Importance>(
                                            icon: Icon(
                                              Icons.filter_alt_outlined,
                                              color: buttonColor,
                                            ),
                                            isExpanded: true,
                                            dropdownColor: Colors.white,
                                            style: TextStyle(
                                                color: Colors.white),
                                            iconEnabledColor: Colors.black,
                                            value: newCategory,
                                            items: Importance.values
                                                .map((Importance value) {
                                              return DropdownMenuItem<
                                                  Importance>(
                                                value: value,
                                                child: Text(
                                                  value.toShortString(),
                                                  style: TextStyle(
                                                      color: buttonColor),
                                                ),
                                              );
                                            })
                                                .where((element) =>
                                            element.value !=
                                                Importance.clear)
                                                .toList(),
                                            onChanged: (Importance? value) {
                                              setState(() {
                                                newCategory = value;
                                              });
                                            },
                                          ),
                                        );
                                      }),
                                ),
                                TextButton(
                                    onPressed: () {
                                      DatePicker.showDateTimePicker(
                                          context,
                                          showTitleActions: true,
                                          minTime: DateTime(date.year,
                                              date.month, date.day),
                                          maxTime: DateTime(
                                              date.year + 3, 12, 31),
                                          onConfirm: (date) {
                                            print('confirm $date');
                                            newDate = date;
                                          },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: Text(
                                      'Choode date',
                                      style:
                                      TextStyle(color: Colors.blue),
                                    ))
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(color: buttonColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(color: buttonColor),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      myTodo.add(Todo(
                                          newTitle,
                                          newDescription,
                                          newDate,
                                          newCategory!));
                                      newTitle = newDescription = '';

                                      newCategory = Importance.blue;
                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                  //   },
                  // );
                }),
          ),
        )]
    );
  }
}

class Todo {
  final String title;
  final String description;
  final DateTime? dateOfCreation;
  final Importance importance;

  Todo(this.title, this.description, this.dateOfCreation, this.importance);
}
