import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math';
import 'dart:typed_data';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}


final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,  0x50,  0x4E,  0x47,  0x0D,  0x0A,  0x1A,  0x0A,  0x00,  0x00,  0x00,  0x0D,
  0x49,  0x48,  0x44,  0x52,  0x00,  0x00,  0x00,  0x01,  0x00,  0x00,  0x00,  0x01,
  0x08,  0x06,  0x00,  0x00,  0x00,  0x1F,  0x15,  0xC4,  0x89,  0x00,  0x00,  0x00,
  0x0A,  0x49,  0x44,  0x41,  0x54,  0x78,  0x9C,  0x63,  0x00,  0x01,  0x00,  0x00,
  0x05,  0x00,  0x01,  0x0D,  0x0A,  0x2D,  0xB4,  0x00,  0x00,  0x00,  0x00,  0x49,
  0x45,  0x4E,  0x44,  0xAE,
]);

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(count,
          (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

class MyHomePage extends StatelessWidget {
  MyHomePage() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 1000;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Say::Project"),
            floating: true,
            snap: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverStaggeredGrid(
                delegate: SliverVariableSizeChildBuilderDelegate(
                        (context, index) => new _Tile(index, _sizes[index])
                ),
                gridDelegate: SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100.0,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 8.0,
                    staggeredTileBuilder: (index) => new StaggeredTile.fit(2)
                ),
            ),
          )
        ],
      ),
    );
  }
}


class Example08 extends StatelessWidget {
  Example08() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 1000;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('random dynamic tile sizes'),
      ),
      body: new StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (context, index) => new _Tile(index, _sizes[index]),
        staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
      ),
    );
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Card(
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  //new Center(child: new CircularProgressIndicator()),
                  new Center(
                    child: new FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: 'https://picsum.photos/${size.width}/${size.height}/',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 30.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                  data: IconThemeData(
                      color: Colors.red,
                      opacity: 0.7,
                      size: 12.0
                  ),
                  child: Icon(Icons.favorite)
              ),
              SizedBox(width: 5.0,),
              Text("$index", style: TextStyle(fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.bold),),
              SizedBox(width: 10.0,),
              IconTheme(
                  data: IconThemeData(
                      color: Colors.grey,
                      opacity: 0.7,
                      size: 12.0
                  ),
                  child: Icon(Icons.chat)
              ),
              SizedBox(width: 5.0,),
              Text("$index", style: TextStyle(fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.bold),),
            ],
          ),
        )
      ]
    );
  }
}