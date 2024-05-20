import 'package:flutter/material.dart';
import 'package:mongo_flutter/constant_route.dart';
import 'package:mongo_flutter/service/label_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Disease',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 30,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: LabelService.getList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  var dataListFromServer = snapshot.data ?? [];
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.deepPurple, thickness: 1),
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NamedRoute.detailLabelPageName,
                              arguments: dataListFromServer[index]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dataListFromServer[index].labelName ?? '',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: dataListFromServer.length,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NamedRoute.cameraPageName);
        },
        tooltip: 'load image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
