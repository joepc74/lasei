import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NoticiaRender extends StatefulWidget {
  final Map? item;
  const NoticiaRender({Key? key, this.item}) : super(key: key);

  @override
  State<NoticiaRender> createState() => _NoticiaRenderState();
}

class _NoticiaRenderState extends State<NoticiaRender> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.item.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item!['titulo']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HtmlWidget(
          widget.item!['contenido'],
        ),
      ),
    );
  }
}
