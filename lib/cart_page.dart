import 'package:favconcept/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyController _controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          // actions: [
          //   _controller.cart.length == 0
          //       ? SizedBox()
          //       : IconButton(
          //           onPressed: () {
          //             Get.defaultDialog(
          //                 title: 'Delete Cart',
          //                 middleText: 'Are you sure want to delete your cart?',
          //                 onCancel: () {},
          //                 onConfirm: () {
                            
          //                   _controller.cart.clear();
          //                   _controller.postsList.refresh();
          //                   Get.back();
          //                 });
          //           },
          //           icon: Icon(Icons.delete))
          // ],
          centerTitle: true,
        ),
        body: Obx(
          () => _controller.cart.length == 0
              ? Center(child: Text('Your cart is empty'))
              : ListView.builder(
                  itemCount: _controller.cart.length,
                  itemBuilder: (context, i) {
                    final title = _controller.cart[i].title.split(' ');
                    return Card(
                      child: ListTile(
                        title: Text(title[0]),
                        trailing: Container(
                          width: 150,
                          height: 30,
                          child: Row(children: [
                            InkWell(
                                onTap: () {
                                  if (_controller.cart[i].cartcount.value ==
                                      1) {
                                    _controller.cart
                                        .remove(_controller.cart[i]);
                                  } else {
                                    _controller.cart[i].cartcount.value--;
                                  }
                                },
                                child: Icon(Icons.remove)),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                  _controller.cart[i].cartcount.toString()),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () {
                                  _controller.cart[i].cartcount.value++;
                                },
                                child: Icon(Icons.add)),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: () {
                                  _controller.cart[i].cartcount.value = 1;
                                  _controller.cart.remove(_controller.cart[i]);
                                },
                                child: Icon(Icons.clear))
                          ]),
                        ),
                        subtitle: Text(title[1]),
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              NetworkImage(_controller.cart[i].thumbnailUrl),
                        ),
                      ),
                    );
                  }),
        ));
  }
}
