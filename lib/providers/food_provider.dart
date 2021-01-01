import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/models/organization.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:intl/intl.dart';

class Foods with ChangeNotifier {
  final _timestamp = DateTime.now();

  List<Food> _foods = [];

  List<Food> get foods {
    return [..._foods];
  }

  // begin fetch user foods from firestore
  Future<void> fetchAndSetUserFoods() async {
    try {
      final docsCollection = await userFoodRef.get();
      final List<Food> loadedFoods = [];
      docsCollection.docs.forEach((fd) {
        loadedFoods.add(
          Food(
            id: fd['id'],
            name: fd['name'],
            available: fd['available'],
            expireTime: fd['expireTime'],
            imageUrl: fd['imageUrl'],
            organizationId: fd['organizationId'],
            organizationName: fd['organizationName'],
            organizationRating: int.tryParse(fd['organizationRating']) ?? 0,
            organizationAddress: fd['organizationAddress'],
          ),
        );
      });

      _foods = loadedFoods;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  // end fetch user foods from firestore

  // begin fetch organization foods from firestore
  Future<void> fetchAndSetOrganizationFoods({String organizationId}) async {
    try {
      final docsCollection = await organizationFoodRef
          .doc(organizationId)
          .collection('organizationFoods')
          .get();
      final List<Food> loadedFoods = [];
      docsCollection.docs.forEach((fd) {
        loadedFoods.add(
          Food(
            id: fd['id'],
            name: fd['name'],
            available: fd['available'],
            expireTime: fd['expireTime'],
            imageUrl: fd['imageUrl'],
            organizationId: fd['organizationId'],
            organizationName: fd['organizationName'],
            organizationRating: int.tryParse(fd['organizationRating']) ?? 0,
            organizationAddress: fd['organizationAddress'],
          ),
        );
      });

      _foods = loadedFoods;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  // end fetch organization foods from firestore

  // begin organization home screen
  bool isOrganizationRegistered(String id) {
    return _foods.any((fd) => fd.organizationId == id);
  }

  List<Food> organizationFood(String id) {
    return _foods.where((fd) => fd.organizationId == id).toList();
  }
  // end organization home screen

  Food findById(String id) {
    return _foods.firstWhere((fd) => fd.id == id);
  }

  Future<void> addFood({
    String id,
    String name,
    String imageUrl,
    String available,
    String expireTime,
    String organizationId,
  }) async {
    final organizationDoc = await organizationRef.doc(organizationId).get();
    Organization organization = Organization.fromDocument(organizationDoc);
    return organizationFoodRef
        .doc(organizationId)
        .collection('organizationFoods')
        .doc(id)
        .set({
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'available': available,
      'expireTime': expireTime,
      'organizationId': organizationId,
      'organizationAddress': organization.address,
      'organizationName': organization.name,
      'organizationRating': organization.rating.toString(),
      'createdAt': DateFormat('dd/MM/yyyy hh:mm a').format(_timestamp),
    }).then((_) {
      userFoodRef.doc(id).set({
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'available': available,
        'expireTime': expireTime,
        'organizationId': organizationId,
        'organizationAddress': organization.address,
        'organizationName': organization.name,
        'organizationRating': organization.rating.toString(),
        'createdAt': DateFormat('dd/MM/yyyy hh:mm a').format(_timestamp),
      }).catchError((error) {
        throw error;
      });
    });
  }

  // begin delete food data
  Future<void> deleteFood({String organizationId, String foodId}) {
    final _existingFoodIndex = _foods.indexWhere((fd) => fd.id == foodId);
    var _existingFood = _foods[_existingFoodIndex];
    _foods.removeAt(_existingFoodIndex);
    notifyListeners();

    return organizationFoodRef
        .doc(organizationId)
        .collection('organizationFoods')
        .doc(foodId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    }).then((_) {
      userFoodRef.doc(foodId).get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      }).then((_) {
        storageRef.child('foods/post_$foodId.jpg').delete().catchError((error) {
          throw error;
        });
      }).catchError((error) {
        _foods.insert(_existingFoodIndex, _existingFood);
        notifyListeners();
        throw error;
      }).then((_) {
        _existingFood = null;
      });
    }).catchError((error) {
      _foods.insert(_existingFoodIndex, _existingFood);
      notifyListeners();
      throw error;
    });
  }
  // end delete food data

  // begin update food data
  Future<void> updateFood({
    String foodId,
    String organizationId,
    String newName,
    String newCount,
    String newExpireTime,
  }) async {
    await organizationFoodRef
        .doc(organizationId)
        .collection('organizationFoods')
        .doc(foodId)
        .update({
      'name': newName,
      'available': newCount,
      'expireTime': newExpireTime,
    }).then((_) {
      userFoodRef.doc(foodId).update({
        'name': newName,
        'available': newCount,
        'expireTime': newExpireTime,
      }).catchError((error) {
        throw error;
      });
    });
  }
  // end update food data

}
