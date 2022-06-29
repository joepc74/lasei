import 'package:flutter/material.dart';
import 'package:lasei/pages/noticias.dart';
import 'package:lasei/pages/perfil.dart';
import 'package:lasei/pages/videos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.none,
        image: AssetImage("assets/fondo.png"),
        repeat: ImageRepeat.repeat,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: PageView(
            controller: pageController,
            children: const [
              PerfilPage(),
              NoticiasPage(),
              VideosPage(),
            ],
            onPageChanged: (index) => _onPageChanged(index),
          ),
        ),
        bottomNavigationBar: barrabotones(),
      ),
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  BottomNavigationBar barrabotones() {
    return BottomNavigationBar(
      //backgroundColor: Color.fromRGBO(0, 0, 0, 0.05),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_rounded),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_rounded),
          label: 'Noticias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection_rounded),
          label: 'Videos',
        ),
      ],
      currentIndex: _selectedIndex,
      //selectedItemColor: Colors.amber[800],
      onTap: (index) => _onItemTapped(index),
    );
  }
}
