import 'package:flutter/material.dart';
import 'package:food_wastage_management/models/food.dart';

class Foods with ChangeNotifier {
  List<Food> _foods = [
    Food(
      id: 'f1',
      name: 'Fright Rice',
      imageUrl: 'https://i.ytimg.com/vi/PNpVCrIlnPg/maxresdefault.jpg',
      available: '20',
      organizationId: 'd1',
      organizationName: 'US Hotels',
      organizationRating: 5,
      organizationLocation: 'Jaffna',
    ),
    Food(
      id: 'f2',
      name: 'Noodles',
      imageUrl:
          'https://1.bp.blogspot.com/-VHvXydZxFmA/XpFd73m4GjI/AAAAAAAARKA/FkiRpKMnAVodpITwKXED8DIfkMPcrQFowCLcBGAsYHQ/s1600/Teriyaki-Noodles-1.jpg',
      available: '38',
      organizationId: 'd2',
      organizationName: 'Rolex',
      organizationRating: 3,
      organizationLocation: 'Colombo',
    ),
    Food(
      id: 'f3',
      name: 'Pasta',
      imageUrl: 'https://sparkpeo.hs.llnwd.net/e4/nw/7/9/l790811918.jpg',
      available: '15',
      organizationId: 'd1',
      organizationName: 'Green Grass',
      organizationRating: 4,
      organizationLocation: 'Jaffna',
    ),
    Food(
      id: 'f4',
      name: 'Rice and Curry',
      imageUrl:
          'https://www.knorr.lk/Images/2809/2809-863142-the-art-of-sri-lankan-cooking-580x326.jpg',
      available: '25',
      organizationId: 'd2',
      organizationName: 'Selva Restaurant',
      organizationRating: 2,
      organizationLocation: 'Kokuvil',
    ),
  ];

  List<Food> get foods {
    return [..._foods];
  }

  Food findById(String id){
    return _foods.firstWhere((fd) => fd.id == id);
  }

  addFood() {
    // add new food
    notifyListeners();
  }
}
