import 'package:favconcept/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'details_page.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyController _controller = Get.find();
    _willPopCallback() async {
      _controller.visible.value = false;
      _controller.searchcontroller.clear();
      return true;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
              title: TextField(
            controller: _controller.searchcontroller,
            onChanged: (value) {
              if (_controller.searchcontroller.text.length == 0) {
                _controller.visible.value = true;
              }

              if (_controller.searchcontroller.text.length >= 3) {
                _controller.filterproducts(value);
                _controller.searchcontroller.text.length == 0
                    ? _controller.visible.value = false
                    : _controller.visible.value = true;
                _controller.visible.value = true;
              }
            },
            decoration: InputDecoration(hintText: 'Search Products..'),
          )),
          body: Obx(() => _controller.visible.value
              ? Visibility(
                  visible: _controller.visible.value,
                  child:_controller.filterlist.length==0?Center(child: Text('No Products')): ListView.builder(
                      itemCount: _controller.filterlist.length,
                      itemBuilder: (context, index) {
                        var product = _controller.filterlist[index];
                        final title =
                            _controller.filterlist[index].title.split(' ');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => DetailsPage(
                                    product: product,
                                  ));
                            },
                            title: Text(title[0]),
                            subtitle: Text(title[1]),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _controller.filterlist[index].thumbnailUrl),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      }))
              : Center(child: Text('Search Productsssss')))),
    );
  }
}
