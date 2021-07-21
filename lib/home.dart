import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:panache/models/paintColor.dart';
import 'package:panache/themes/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: types.length + 1,
        itemBuilder: ((BuildContext context, int index) {
          if (index == 0)
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Panache",
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.w100),
                  ),
                  Text(
                    "Greens",
                    style:
                        TextStyle(fontSize: 80, fontWeight: FontWeight.normal),
                  ),
                  IconButton(
                    icon: Icon(currentTheme.isDarkTheme()
                        ? Icons.light_mode
                        : Icons.dark_mode),
                    onPressed: () {
                      currentTheme.toggleTheme();
                    },
                  ),
                ],
              ),
            );
          List<PaintColor> p = paints[index - 1];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        types[index - 1],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30,
                  ),
                  itemCount: p.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: PhysicalModel(
                              child: SizedBox(
                                width: 200,
                              ),
                              shape: BoxShape.rectangle,
                              // elevation: currentTheme.isDarkTheme() ? 0 : 7,
                              borderRadius: BorderRadius.circular(30.0),
                              color: p[i].color,
                              shadowColor: Colors.grey,
                            ),
                          ),
                          Text(
                            p[i].name,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
    /* return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // backgroundColor: Colors.red,
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              title: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.85,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsMainPage())); */
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            currentTheme.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 30,
                    ),
                    child: InkWell(
                      onTap: () async {
                        WidgetsFlutterBinding.ensureInitialized();
                        List<CameraDescription> cameras =
                            await availableCameras();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraPage(cameras)),
                        );
                      },
                      child: PhysicalModel(
                        child: SizedBox.fromSize(
                          size: const Size.fromHeight(150),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.photo_camera,
                                  ),
                                ),
                                Text(
                                  'Paint your walls',
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(
                                  'Try our visualizer tool now!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        shape: BoxShape.rectangle,
                        elevation: currentTheme.isDarkTheme() ? 0 : 7,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                        shadowColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 50),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                paints[index].type,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 30,
                          ),
                          itemCount: paints.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PhysicalModel(
                                child: SizedBox.fromSize(
                                  size: const Size.fromWidth(200.0),
                                ),
                                shape: BoxShape.rectangle,
                                elevation: currentTheme.isDarkTheme() ? 0 : 7,
                                borderRadius: BorderRadius.circular(30.0),
                                color: paints[i].color,
                                shadowColor: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                childCount: 5,
              ),
            ),
          ),
        ],
      ),
    ); */
  }
}
