import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_repository/model/model.dart';

class ApiProvider {
  Future<List<ProductModel>> myFun() async {
    final Uri url = Uri.parse('https://fakestoreapi.com/products');

    try {
      http.Response myResponse = await http.get(url);

      //body of response:It is The body of the response as a string.
      String myBody = myResponse.body;

      // if the respone of the call is list of objects, we
      //have two options
      // option 1 -----------------------------
      //jsonDecode parses the string and returns the resulting Json object.
      List<dynamic> myJson = jsonDecode(myBody);

      List<ProductModel> productList =
          myJson.map((e) => ProductModel.fromJson(e)).toList();

      return productList;
      // print('length: ${productList.length}');
      // print('----------------------------------');
      // print('example: ${productList[0].title}');
      // option 2 -----------------------------
      // List<ProductModel> productList2 = productModelFromJson(myBody);

      // print('length: ${productList2.length}');
      // print('----------------------------------');
      // print('example: ${productList2[0].title}');
    } catch (e) {
      throw Future.error(e);
    }
  }
}

class JsonProvider {
  Future<List<ProductModel>> myFun() async {
    try {
      String myString = await rootBundle.loadString('assets/products.json');
      List<dynamic> result = jsonDecode(myString);
      List<ProductModel> products =
          result.map((e) => ProductModel.fromJson(e)).toList();
      return products;
    } catch (e) {
      throw Future.error(e);
    }
  }
}

class DummyProvider {
  Future<List<ProductModel>> myFun() async {
    Map<String, dynamic> myMap = {
      "id": 1,
      "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
      "price": 109.95,
      "description":
          "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      "rating": {"rate": 3.9, "count": 120}
    };

    ProductModel product = ProductModel.fromJson(myMap);
    //this return one product
    List<ProductModel> myList = [product];
    return Future.value(myList);

    //this return no product
    //List<ProductModel> myList2 = [];
    //return Future.value(myList2);
  }
}

class MyProvider {
  //ApiProvider repo = ApiProvider();
  // JsonProvider repo = JsonProvider();
  DummyProvider repo = DummyProvider();
  myFun() {
    return repo.myFun();
  }
}
