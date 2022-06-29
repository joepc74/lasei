import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lasei/authentication.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiasPage extends StatelessWidget {
  const NoticiasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            const Text(
              "Noticias:",
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFFFFFFFF),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: auth.datos['noticias'].length,
                itemBuilder: (BuildContext context, int index) {
                  return _noticia(context, auth.datos['noticias'][index]);
                },
              ),
            )
          ],
        ));
  }

  Widget _noticia(context, Map item) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => _launchURL(item['url']),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 190.0,
              width: MediaQuery.of(context).size.width - 100.0,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(item['imagen']),
                      fit: BoxFit.fill)),
              child: Column(children: [
                Expanded(child: Container()),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    color: const Color.fromRGBO(255, 255, 255, 0.8),
                    child: Column(children: [
                      AutoSizeText(
                        item['titulo'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      AutoSizeText(
                        item['texto'],
                        textAlign: TextAlign.justify,
                      ),
                    ])),
              ]),
            )),
      ),
    );
  }

  void _launchURL(String url) async {
    if (url == '') return;
    final direccion = Uri.parse(url);
    if (await canLaunchUrl(direccion)) {}
    if (!await launchUrl(direccion)) throw 'Could not launch $url';
  }
}
