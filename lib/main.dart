import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ParentParam {
  final int page;
  final List<Param> params;

  ParentParam({
    this.page = 1,
    this.params = const [],
  });
}

class Param {
  final String id;
  final String name;
  final String description;

  Param({
    required this.id,
    required this.name,
    required this.description,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Param> _showedParam = const [];
  int _currentPage = 1;

  List<ParentParam> _parentParams = [
    ParentParam(
      page: 1,
      params: [
        Param(
          id: '1',
          name: 'Name 1',
          description: 'Description 1',
        ),
        Param(
          id: '2',
          name: 'Name 2',
          description: 'Description 2',
        ),
        Param(
          id: '3',
          name: 'Name 3',
          description: 'Description 3',
        ),
      ],
    ),
    ParentParam(
      page: 2,
      params: [
        Param(
          id: '4',
          name: 'Name 4',
          description: 'Description 4',
        ),
        Param(
          id: '5',
          name: 'Name 5',
          description: 'Description 5',
        ),
      ],
    ),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _showedParam = _parentParams[0].params;
    _scrollController.addListener(() {
      double pixels = _scrollController.position.pixels;
      double maxExtent = _scrollController.position.maxScrollExtent - 100;

      if (pixels >= maxExtent) {
        if (_parentParams.length != _currentPage) {
          setState(() {
            _currentPage++;
            _showedParam.addAll(_parentParams[_currentPage - 1].params);
          });
        }
        // load next..
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 160.0,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Hero Banner'),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(18.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.teal[100 * (index + 1 % 9)],
                              // child: Text('grid item $index'),
                            ),
                          ),
                        ),
                        Text('Icon $index'),
                      ],
                    );
                  },
                  childCount: 10,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(18.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Section 1',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                          color: Colors.yellow[100 * (index + 1 % 9)],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(18.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Section 2',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        color: Colors.pink[100 * (index + 1 % 9)],
                      ),
                    ),
                    title: Text(
                      'Product Name $index',
                    ),
                    subtitle: Text('Product Description $index'),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: Text('Buy Now'),
                    ),
                  ),
                ),
                childCount: 10,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3 / 4,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  margin: EdgeInsets.all(10.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Container(
                            color: Colors.purple[100 * (index + 1 % 9)],
                          ),
                        ),
                        Text(_showedParam[index].name),
                        Text(_showedParam[index].description),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Buy Again'),
                        ),
                      ],
                    ),
                  ),
                ),
                childCount: _showedParam.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
