import 'package:flutter/material.dart';
import 'package:mongo_flutter/model/label_model.dart';

class DetailLabelPage extends StatefulWidget {
  const DetailLabelPage({super.key, required this.labelModel});

  final LabelModel labelModel;

  @override
  State<DetailLabelPage> createState() => _DetailLabelPageState();
}

class _DetailLabelPageState extends State<DetailLabelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.labelModel.labelName ?? ''),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  widget.labelModel.labelName ?? '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                child: Text(
                  widget.labelModel.description ?? '',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
