import 'package:favconcept/controller.dart';
import 'package:favconcept/details_page.dart';
import 'package:favconcept/model.dart';
import 'package:favconcept/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_page.dart';
import 'favorites.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyController _controller = Get.put(MyController());
    return Scaffold(
      appBar: AppBar(
          title: Text('Produtcs'),
          centerTitle: true,
          leading: IconButton(onPressed: () {
            Get.to(()=>SearchPage());
          }, icon: Icon(Icons.search)),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Get.to(() => FavoritesPage());
                },
                icon: Icon(Icons.favorite_rounded)),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                onPressed: () {
                  Get.to(() => CartPage());
                },
                icon: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 26.0,
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 8,
                            child: Obx(
                              () => Text(
                                _controller.cart.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        _controller.cart.length > 9 ? 8 : 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            )))
                  ],
                ),
              ),
            ),
          ]),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: GetBuilder<MyController>(
            builder: (con) {
              return con.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                      itemCount: con.postsList.length,
                      itemBuilder: (context, index) {
                        var product = con.postsList[index];
                        var title = con.postsList[index].title.split(' ');
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 700),
                                    pageBuilder: (context, animation, ___) {
                                      return FadeTransition(
                                          opacity: animation,
                                          child: DetailsPage(
                                            product: product,
                                          ));
                                    }));
                          },
                          child: Transform.translate(
                            offset: Offset(0.0, index.isOdd ? 0 : 0.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(.5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipOval(
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Hero(
                                            tag: _controller
                                                .postsList[index].thumbnailUrl,
                                            child: Image.network(
                                              _controller.postsList[index]
                                                  .thumbnailUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Text(
                                          title[0],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          title[1],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    con.postsList[index]
                                                        .isFavorite
                                                        .toggle();
                                                    con.postsList[index]
                                                            .isFavorite.value
                                                        ? con.favorites.add(con
                                                            .postsList[index])
                                                        : con.favorites.remove(
                                                            con.postsList[
                                                                index]);
                                                    print(
                                                        con.favorites[0].title);
                                                  },
                                                  child: Obx(
                                                    () => Container(
                                                      child: con
                                                              .postsList[index]
                                                              .isFavorite
                                                              .value
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : Icon(Icons
                                                              .favorite_border_outlined),
                                                    ),
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    for (Products item
                                                        in con.cart) {
                                                      if (item.id ==
                                                          product.id) {
                                                        con.postsList[index]
                                                            .cartcount.value++;

                                                        return;
                                                      }
                                                    }
                                                    Get.snackbar('Product Added Succesfully', '${title[0]}',colorText: Colors.white,backgroundColor: Colors.black,snackPosition: SnackPosition.BOTTOM);

                                                    con.cart.add(
                                                        con.postsList[index]);
                                                    // print(con.cart);
                                                  },
                                                  icon: Icon(Icons
                                                      .add_shopping_cart_outlined)),
                                            ])
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
            },
          )),
    );
  }
}
