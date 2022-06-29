import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lasei/authentication.dart';

const darkColor = Color(0xFF49535C);

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var montserrat = TextStyle(
    //   fontSize: 12,
    // );
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: AvatarClipper(),
                              child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: darkColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 11,
                              top: 50,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundImage: logo(
                                          auth.datos['datos']['logocirculo'])),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        auth.datos['datos']['nombre'],
                                        style: const TextStyle(
                                          fontSize: 32,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        auth.datos['datos']['circulo'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: darkColor,
                                        ),
                                      ),
                                      const SizedBox(height: 8)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }

  ImageProvider logo(String url) {
    if (url == '') {
      return const AssetImage('assets/sei.png');
    } else {
      return CachedNetworkImageProvider(auth.datos['datos']['logocirculo']);
    }
  }

  TextStyle buildMontserrat(
    Color color, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
