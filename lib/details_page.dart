import 'package:favconcept/controller.dart';
import 'package:favconcept/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_page.dart';
import 'favorites.dart';

class DetailsPage extends StatelessWidget {
  final Products product;
  DetailsPage({this.product});
  @override
  Widget build(BuildContext context) {
    final MyController _controller = Get.find();
    _willPopCallback() async {
      _controller.selectedPageIndex.value = 0;

      return true;
    }

    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text('Details Page'),
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
                      Get.to(()=>CartPage());
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
                                        fontSize: _controller.cart.length > 9
                                            ? 8
                                            : 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              ]),
          body: ListView(children: [
            Stack(
              children: [
                Container(
                  child: PageView.builder(
                      controller: _controller.pageController,
                      onPageChanged: _controller.selectedPageIndex,
                      physics: BouncingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.dialog(Dialog(
                              child: Container(
                                  height: 300,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InteractiveViewer(
                                        panEnabled: false,
                                        boundaryMargin: EdgeInsets.all(20),
                                        minScale: 0.5,
                                        maxScale: 8,
                                        child: Image.network(
                                          product.thumbnailUrl,
                                          fit: BoxFit.cover,
                                        )),
                                  )),
                            ));
                          },
                          child: Hero(
                              tag: index == 0
                                  ? product.thumbnailUrl
                                  : product.thumbnailUrl + '',
                              child: InteractiveViewer(
                                panEnabled: false,
                                boundaryMargin: EdgeInsets.all(20),
                                minScale: 0.5,
                                maxScale: 8,
                                child: Image.network(
                                  product.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        );
                      }),
                  height: 250,
                ),
                Positioned(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Obx(() {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.decelerate,
                          margin: const EdgeInsets.all(4),
                          width: _controller.selectedPageIndex.value == index
                              ? 25
                              : 6,
                          height: _controller.selectedPageIndex.value == index
                              ? 10
                              : 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _controller.selectedPageIndex.value == index
                                ? Colors.black
                                : Colors.grey,
                            shape: BoxShape.rectangle,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(product.title),
              leading: Text(product.id.toString()),
              trailing: InkWell(
                  onTap: () {
                    product.isFavorite.toggle();
                    product.isFavorite.value
                        ? _controller.favorites.add(product)
                        : _controller.favorites.remove(product);
                    //   print(con.favorites[0].title);
                  },
                  child: Obx(
                    () => Container(
                      child: product.isFavorite.value
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_border_outlined),
                    ),
                  )),
            )
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: Text('Add to Cart'),
            onPressed: () {
           final title=   product.title.split(' ');
              for (Products item in _controller.cart) {
                if (item.id == product.id) {
                  product.cartcount.value++;

                  return;
                }
              }

              _controller.cart.add(product);
              Get.snackbar('Product Added Succesfully', '${title[0]}',colorText: Colors.white,backgroundColor: Colors.black,snackPosition: SnackPosition.BOTTOM);
            },
          ),
        ));
  }
}
