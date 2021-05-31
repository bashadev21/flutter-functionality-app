import 'package:favconcept/model.dart';
import 'package:favconcept/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyController extends GetxController {
  var postsList = <Products>[].obs;
  var favorites = <Products>[].obs;
  var cart = <Products>[].obs;
  var filterlist = <Products>[].obs;
  var pageController = PageController();
  var selectedPageIndex = 0.obs;
  var visible = false.obs;
  bool isLoading = true;
  final TextEditingController searchcontroller = TextEditingController();

  void filterproducts(value) {
    filterlist.value = postsList
        .where((country) =>
            country.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  @override
  void onInit() {
    PostsProvider().getPostsList(
      onSuccess: (posts) {
        postsList.addAll(posts);
        isLoading = false;
        //  print(postsList);
        update();
      },
      onError: (error) {
        isLoading = false;
        update();
        print("Error");
      },
    );
     List storedfav = GetStorage().read<List>('fav');
    if (!storedfav.isNull) {
      favorites = storedfav.map((e) => Products.fromJson(e)).toList().obs;
    }
    ever(favorites, (_) {
      GetStorage().write('fav', favorites.toList());
    });

    List storedCart = GetStorage().read<List>('cart');
    if (!storedCart.isNull) {
      cart = storedCart.map((e) => Products.fromJson(e)).toList().obs;
    }
    ever(cart, (_) {
      GetStorage().write('cart', cart.toList());
    });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
