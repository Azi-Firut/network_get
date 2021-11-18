import 'dart:developer';
import 'package:flutter/material.dart';
import 'data.dart';
import 'func.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  String title = 'network';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<ChuckJoke> getStart;
  //late String joke;
  @override
  void initState() {
    super.initState();
    getStart = getJokeFromUrl();
  }

  var icon_url = 'https://picsum.photos/250?image=9';
  dynamic joke = '';
  var id = '';
  var url = '';

  void getJokeAndUpdate() async {
    var chuckJoke = await getJokeFromUrl();
    setState(() {
      icon_url = chuckJoke.icon_url;
      joke = chuckJoke.joke;
      id = chuckJoke.id;
      url = chuckJoke.url;
      log('getJokeAndUpdate()');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: FutureBuilderWidget(),
            ),
            Image.network(
              icon_url,
              scale: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$joke',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'id: $id',
            //     style: Theme.of(context).textTheme.headline6,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'Url: $url',
            //     style: Theme.of(context).textTheme.headline6,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getJokeAndUpdate();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

///  FutureBuilder(slower)
class FutureBuilderWidget extends StatefulWidget {
  const FutureBuilderWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  get getStart => getJokeFromUrl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChuckJoke>(
      future: getStart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.joke,
              style: Theme.of(context).textTheme.headline6);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
