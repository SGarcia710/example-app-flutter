import 'package:dart_app/src/api/api.dart';
import 'package:dart_app/src/models/photo.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final API api = API();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: api.getPhotos(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Photo>> snapshot,
        ) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(snapshot.data[index].url),
                    ),
                    title: Text(snapshot.data[index].id.toString()),
                    subtitle: Text(
                        "Número del album ${snapshot.data[index].albumId}."),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: CustomGradientButton(
//           text: Text(
//             "Colombia",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           width: 150,
//           height: 40,
//           gradientColors: [
//             Colors.yellowAccent,
//             Colors.blueAccent,
//             Colors.redAccent
//           ],
//           initialPosition: Alignment.centerLeft,
//           finalPosition: Alignment.centerRight,
//           function: () => print("Hola desde colombia"),
//           leadingIcon: Icon(Icons.star, color: Colors.white),
//           finalIcon: Icon(Icons.star, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   // Widget customContainer() => Container(
//   //       width: double.infinity,
//   //       height: double.infinity,
//   //       padding: EdgeInsets.all(10),
//   //       margin: EdgeInsets.all(10),
//   //       alignment: Alignment.center,
//   //       child: Text("Platzi".toUpperCase()),
//   //       decoration: BoxDecoration(
//   //         color: Colors.grey,
//   //         border: Border.all(
//   //           color: Colors.black,
//   //           width: 5,
//   //         ),
//   //       ),
//   //       transform: Matrix4.rotationZ(.05),
//   //       constraints: BoxConstraints(maxWidth: 100),
//   //     );
// }

class CustomGradientButton extends StatelessWidget {
  final Text text;
  final double width;
  final double height;
  final List<Color> gradientColors;
  final Alignment initialPosition;
  final Alignment finalPosition;
  final Function function;
  final Icon leadingIcon;
  final Icon finalIcon;

  const CustomGradientButton(
      {Key key,
      @required this.text,
      @required this.width,
      @required this.height,
      @required this.gradientColors,
      @required this.initialPosition,
      @required this.finalPosition,
      @required this.function,
      this.leadingIcon,
      this.finalIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height / 2)),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: initialPosition,
              end: finalPosition,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: height * .15,
                spreadRadius: 1,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            leadingIcon ?? Container(),
            text,
            finalIcon ?? Offstage(),
          ],
        ),
      ),
    );
  }
}
