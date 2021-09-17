import 'package:flutter/material.dart';

enum Importance { yellow, orange, red, darkBlue }

extension ParseToString on Importance {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

Color textColor = Colors.orange;

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
  var _chosenValue;

  List<Todo> myTodo = [
    Todo('Eat breakfast', 'Eat some healthy food with coffee', '16.09.2021',
        Importance.yellow),
    Todo('Play videogames', 'Complete one level', '16.09.2021', Importance.red),
    Todo('Talk to Liana', 'Discuss the latest news', '16.09.2021',
        Importance.orange),
    Todo('Talk to Dasha', 'Talk to Dasha about university problems',
        '16.09.2021', Importance.darkBlue),
  ];

  @override
  Widget build(BuildContext context) {
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
                dropdownColor: Colors.black,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                value: _chosenValue,
                items: Importance.values.map((Importance value) {
                  return DropdownMenuItem<Importance>(
                    value: value,
                    child: Text(
                      value.toShortString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (Importance? value) {
                  setState(() {
                    _chosenValue = value;
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
                    itemCount: myTodo.length,
                    itemBuilder: (BuildContext context, int index) {
                      titleTextColor(myTodo[index].importance);
                      return SizedBox(
                        width: 300,
                        height: 400,
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                myTodo[index].title,
                                style: TextStyle(color: textColor),
                              ),
                              Text(myTodo[index].description),
                              Row(
                                children: [
                                  Text(myTodo[index].dateOfCreation),
                                  Text(myTodo[index].dateOfCreation),
                                  Text(myTodo[index].dateOfCreation),

                                  // Text(myTodo[index].importance),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
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
