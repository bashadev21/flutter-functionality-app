import 'package:favconcept/controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyController _controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          centerTitle: true,
        ),
        body: Obx(
          () => _controller.favorites.length == 0
              ? Center(child: Text('Empty'))
              : ListView.builder(
                  itemCount: _controller.favorites.length,
                  itemBuilder: (context, index) {
                    final product = _controller.favorites[index];
                    final title = _controller.favorites[index].title.split(' ');
                    return _controller.favorites.length == 0
                        ? Text('Empty')
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  title: Text(title[0]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration: const Duration(
                                                milliseconds: 700),
                                            pageBuilder:
                                                (context, animation, ___) {
                                              return FadeTransition(
                                                  opacity: animation,
                                                  child: DetailsPage(
                                                    product: product,
                                                  ));
                                            }));
                                  },
                                  subtitle: Text(title[1]),
                                  leading: Hero(
                                      tag: _controller
                                          .favorites[index].thumbnailUrl,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                            _controller
                                                .favorites[index].thumbnailUrl),
                                      )),
                                  trailing: InkWell(
                                    onTap: () {
                                      _controller.favorites[index].isFavorite
                                          .toggle();
                                      _controller.favorites
                                          .remove(_controller.favorites[index]);
                                      // _controller.favorites[index].isFavorite.value?_controller.favorites.add(_controller.favorites[index]):_controller.favorites.remove(_controller.favorites[index]);
                                      //  print(con.favorites[0].title);
                                    },
                                    child: Container(
                                        child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )),
                                  )),
                            ),
                          );
                  }),
        ));
  }
}
