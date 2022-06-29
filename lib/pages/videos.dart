import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lasei/authentication.dart';
import 'package:pod_player/pod_player.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage>
    with AutomaticKeepAliveClientMixin<VideosPage> {
  late final PodPlayerController _controller = PodPlayerController(
      playVideoFrom:
          PlayVideoFrom.youtube('https://www.youtube.com/watch?v=bZwSpjfFVyg'),
      podPlayerConfig: const PodPlayerConfig(autoPlay: false))
    ..initialise();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 5.0),
            SizedBox(
                height: (MediaQuery.of(context).size.width * 9.0 / 16.0) >
                        (MediaQuery.of(context).size.height - 100)
                    ? MediaQuery.of(context).size.height - 100
                    : MediaQuery.of(context).size.width * 9.0 / 16.0,
                child: PodVideoPlayer(controller: _controller)),
            const SizedBox(
              height: 5.0,
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: auth.datos['videos'].length,
              itemBuilder: (context, item) =>
                  _video(auth.datos['videos'][item]),
            ),
          ],
        ));
  }

  Widget _video(item) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => setState(() {
          _controller.changeVideo(
              playVideoFrom:
                  PlayVideoFrom.youtube('https://youtu.be/${item['video']}'));
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(250, 169, 213, 248),
                Color.fromARGB(200, 255, 0, 0),
              ],
            ),
            //color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
          width: double.infinity,
          child: Row(
            children: [
              Image(
                image: CachedNetworkImageProvider(
                    'https://img.youtube.com/vi/${item['video']}/default.jpg'),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: AutoSizeText(
                  item['titulo'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(100, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
