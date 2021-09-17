import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Importance {
  yellow,
  orange,
  red,
  darkBlue
}




class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _chosenValue;

  _buildCircle(int index){

  }


  List<Todo> myTodo = [
    Todo('Eat breakfast', 'Eat some healthy food with coffee', '16.09.2021', Importance.yellow),
    Todo('Play videogames', 'Complete one level', '16.09.2021', Importance.red),
    Todo('Talk to Liana', 'Discuss the latest news', '16.09.2021', Importance.orange),
    Todo('Talk to Dasha', 'Talk to Dasha about university problems', '16.09.2021', Importance.darkBlue),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.deepPurple,
          Colors.purple
        ])
      ),
      child: SafeArea(
        child: Column(
          children: [
            Text('ToDoшка', style: GoogleFonts.lobster(color: Colors.white, fontSize: 40),),
            DropdownButton<Importance>(
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                value: _chosenValue,
                items: Importance.values.map((Importance value){
              return DropdownMenuItem<Importance>(
                value: value,
                child: Text(value.toString(), style: TextStyle(color: Colors.white),),
              );
            }).toList(),
            onChanged: (Importance? value){
                  setState(() {
                    _chosenValue = value;
                  });
            },),
            ListView.builder(
                itemCount: myTodo.length,
                itemBuilder: (BuildContext context, int index){
                return Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.orange,
                      Colors.purple
                    ])
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(myTodo[index].title),
                        Text(myTodo[index].description),
                        Row(
                          children: [
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
                            Text(myTodo[index].dateOfCreation),
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
            })
          ],
        ),
      ),
    );
  }
}

class Todo{
  final String title;
  final String description;
  final String dateOfCreation;
  final Importance importance;

  Todo(this.title, this.description, this.dateOfCreation, this.importance);



}
