import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_wastage_management/models/food.dart';
import 'package:food_wastage_management/models/receiver.dart';
import 'package:food_wastage_management/models/request.dart';
import 'package:food_wastage_management/providers/food_provider.dart';
import 'package:food_wastage_management/providers/receiver_provider.dart';
import 'package:food_wastage_management/providers/request_provider.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_food_upload_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_profile_screen.dart';
import 'package:food_wastage_management/screens/home_screens/user_screens/organization_screens/organization_register_screen.dart';
import 'package:food_wastage_management/widgets/organization_widgets/organization_food_widget.dart';
import 'package:food_wastage_management/widgets/organization_widgets/organization_receiver_request_widget.dart';
import 'package:food_wastage_management/widgets/organization_widgets/organization_search_widget.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/show_dialog_alert_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrganizationHomeScreen extends StatefulWidget {
  static const routeName = '/organization_home_screen';

  @override
  _OrganizationHomeScreenState createState() => _OrganizationHomeScreenState();
}

class _OrganizationHomeScreenState extends State<OrganizationHomeScreen> {
  TextEditingController _searchReceiverController = TextEditingController();
  User _currentUser = FirebaseAuth.instance.currentUser;
  var _currentIndex = 0;
  var _isOrganization = false;
  final _picker = ImagePicker();

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchReceiverController.addListener(_onSearchChanged);
    _checkIsOrganization();
  }

  @override
  void dispose() {
    _searchReceiverController.removeListener(_onSearchChanged);
    _checkIsOrganization();
    super.dispose();
  }

  _onSearchChanged() {
    Provider.of<Receivers>(
      context,
      listen: false,
    ).addSearchString(_searchReceiverController.text.trim());
  }

  _checkIsOrganization() async {
    await organizationRef.doc(_currentUser.uid).get().then((doc) {
      if (doc.exists) {
        setState(() {
          _isOrganization = true;
        });
      } else {
        setState(() {
          _isOrganization = false;
        });
      }
    });
  }

  /* ********************************************************************* */

  _emptySearchScreen(isPotrait) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: isPotrait ? 150.0 : 30.0),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/images/search.svg',
                  height: isPotrait ? 200.0 : 180.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Text(
                  'Search Receivers',
                  style: TextStyle(
                    fontSize: isPotrait ? 30.0 : 25.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Arima',
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  _buildReceivers({receivers}) {
    List<Widget> receiversList = [];
    receivers.forEach((Receiver receiver) {
      receiversList.add(
        GestureDetector(
          onTap: () {},
          child: Container(
            child: OrganizationSearchWidget(receiver),
          ),
        ),
      );
    });
    return Column(
      children: receiversList,
    );
  }

  searchScreen(_isPotrait) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.fromLTRB(20.0, _isPotrait ? 80.0 : 50.0, 20.0, 20.0),
            child: TextField(
              controller: _searchReceiverController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: 'Search Receivers',
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchReceiverController.clear();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<Receivers>(
                  builder: (context, data, child) =>
                      _searchReceiverController.text.isEmpty
                          ? _emptySearchScreen(_isPotrait)
                          : Container(
                              child: _buildReceivers(
                                receivers: data.searchReceivers,
                              ),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ********************************************************************* */

  _emptyRequestScreen(isPotrait) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: isPotrait ? 120.0 : 50.0),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/images/no_requests.svg',
                  height: isPotrait ? 200.0 : 180.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Text(
                  'Currently No Requests',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontFamily: 'Arima',
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildOrganizationRequestScreen(requests) {
    List<Widget> _organizationRequestList = [];
    requests.forEach((Request request) {
      _organizationRequestList.add(
        OrganizationReceiverRequestWidget(request),
      );
    });
    return Column(
      children: _organizationRequestList,
    );
  }

  requestScreen(_isPotrait) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 10.0),
            child: Text(
              'Receivers Requests',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arima',
              ),
            ),
          ),
          Container(
            child: Consumer<Requests>(
              builder: (context, data, child) => data.requests.isNotEmpty
                  ? _buildOrganizationRequestScreen(data.requests)
                  : _emptyRequestScreen(_isPotrait),
            ),
          ),
        ],
      ),
    );
  }

  /* *********************************************************************** */

  _emptyFoodScreen(isPotrait) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: isPotrait ? 120.0 : 50.0),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Container(
                child: Lottie.asset(
                  'animations/empty_box.json',
                  height: isPotrait ? 200.0 : 180.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Text(
                  'Currently No Donates',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontFamily: 'Arima',
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildOrganizationFoodScreen(foods) {
    List<Widget> _organizationFoodList = [];
    foods.forEach((Food food) {
      _organizationFoodList.add(
        OrganizationFoodWidget(food: food),
      );
    });
    return Column(
      children: _organizationFoodList,
    );
  }

  homeScreen(_isPotrait) {
    return FutureBuilder(
      future: Provider.of<Foods>(context, listen: false)
          .fetchAndSetOrganizationFoods(organizationId: _currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return circularProgress();
        } else if (snapshot.hasError) {
          return showDialogAlertWidget(
            context: context,
            error: snapshot.error,
            title: 'Error Message!',
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(
                    20.0, _isPotrait ? 80.0 : 50.0, 20.0, 10.0),
                child: Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arima',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                    child: Text(
                      'My Donates',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arima',
                      ),
                    ),
                  ),
                  Container(
                    child: Consumer<Foods>(
                      builder: (context, data, child) => data.foods.isNotEmpty
                          ? _buildOrganizationFoodScreen(data.foods)
                          : _emptyFoodScreen(_isPotrait),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /* ***************************************************************** */

  Future _pickImage(ImageSource source) async {
    await _picker.getImage(source: source).then((pickedFile) {
      if (pickedFile != null) {
        Navigator.of(context).pushReplacementNamed(
          OrganizationFoodUploadScreen.routeName,
          arguments: pickedFile,
        );
      }
    }).catchError((error) {
      showDialogAlertWidget(
        context: context,
        error: error,
        title: 'Error Message!',
      );
    });
  }

  _buildCreatePostScreen(BuildContext context) {
    var alertStyle = AlertStyle(
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descTextAlign: TextAlign.center,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      titleStyle: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
      ),
    );

    return Alert(
      context: context,
      style: alertStyle,
      title: "Select Food Image",
      content: Column(
        children: <Widget>[
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.black54,
              ),
              FlatButton(
                child: Text(
                  'Capture with camera',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.folder,
                color: Colors.black54,
              ),
              FlatButton(
                child: Text(
                  'Select From Gallery',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
          Divider(),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  _buildAddFoodScreen(BuildContext context) async {
    final organizationDoc = await organizationRef.doc(_currentUser.uid).get();

    var alertStyle = AlertStyle(
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descTextAlign: TextAlign.center,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      titleStyle: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
      ),
    );

    if (organizationDoc.exists) {
      return _buildCreatePostScreen(context);
    } else {
      return Alert(
        context: context,
        style: alertStyle,
        type: AlertType.info,
        title: 'Alert Message!',
        desc: 'Please register your organization to create Posts',
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          ),
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(OrganizationRegisterScreen.routeName),
            width: 120,
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isPotrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: () => _buildAddFoodScreen(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: 0.2,
        currentIndex: _currentIndex,
        onTap: _changePage,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
        elevation: 10.0,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.indigo,
            ),
            title: Text('Home'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.access_time,
              color: Colors.deepPurple,
            ),
            title: Text('Requests'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.deepPurple,
            ),
            title: Text('Search'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text('Profile'),
          ),
        ],
      ),
      body: (_currentIndex == 0)
          ? homeScreen(_isPotrait)
          : (_currentIndex == 1)
              ? requestScreen(_isPotrait)
              : (_currentIndex == 2)
                  ? searchScreen(_isPotrait)
                  : OrganizationProfileScreen(
                      isOrganization: _isOrganization,
                      user: _currentUser,
                    ),
    );
  }
}
