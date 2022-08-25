import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  //variables
  var _user;
  var _userEntity;
  var _type  = 'guest';

  //getters 
  get user => _user;
  get userImage => _user.photoURL; 
  get userFullName => _user.displayName;
  get userUID => _user.uid;

  get userEntity => _userEntity;
  get type => _type;

  void setUser(user) {
    _user = user;
    notifyListeners();
  }

  void setUserInfo(fireStoreUserData) {
    //getting firestore data everytime a profile lands
    print('called setuserInfo, not needed anymore though');
    // _firstname = fireStoreUserData['firstname'];
    // _isActive = fireStoreUserData['isActive'];
    // _address = fireStoreUserData['address'];
    // _created_at = fireStoreUserData['created_at'];
    // _phone_number = fireStoreUserData['phone_number'];
    // _type = fireStoreUserData['type'];
    // _email = fireStoreUserData['email'];
    notifyListeners();
  }

  bool isAuthenticated() {
    return (type == 'guest') ? false : true;
  }

  void clearAuth() {
    _user = null;
    _userEntity = null;
    _type = 'guest';
    notifyListeners();
  }

  void setUserInfoRegistered(user) {
    // _firstname = user['firstname'];
    // _lastname = user['firstname'];
    // _isActive = user['isActive'];
    // _address = user['address'];
    // _created_at = user['created_at'];
    // _phone_number = user['phone_number'];
    // _type = user['type'];
    // _email = user['email'];
    _userEntity = user;
    _type = user['type'];
    notifyListeners();
  }
}
