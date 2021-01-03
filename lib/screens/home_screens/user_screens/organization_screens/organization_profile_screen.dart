import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_wastage_management/providers/auth_provider.dart';
import 'package:food_wastage_management/screens/auth_screens/auth_screen.dart';
import 'package:food_wastage_management/screens/home_screen.dart';
import 'package:food_wastage_management/widgets/clipper_widgets/profile_clipper.dart';
import 'package:food_wastage_management/widgets/progress_widget.dart';
import 'package:food_wastage_management/widgets/rating_stars_widget.dart';
import 'package:provider/provider.dart';

class OrganizationProfileScreen extends StatefulWidget {
  final bool isOrganization;
  final User user;
  OrganizationProfileScreen({this.user, this.isOrganization});

  @override
  _OrganizationProfileScreenState createState() =>
      _OrganizationProfileScreenState();
}

class _OrganizationProfileScreenState extends State<OrganizationProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<Authentication>(context, listen: false)
                  .signOut()
                  .then((_) {
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.routeName);
              });
            },
          ),
        ],
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: widget.isOrganization
            ? organizationRef.doc(widget.user.uid).get()
            : userRef.doc(widget.user.uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress();
          }
          final data = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipPath(
                      clipper: ProfileClipper(),
                      child: Container(
                        height: _isPortrait ? 300.0 : 200.0,
                        width: double.infinity,
                        color: Colors.indigo,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                          border: Border.all(
                            width: 5.0,
                            color: Colors.blue,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.indigo,
                          backgroundImage: NetworkImage(
                            widget.isOrganization
                                ? data['imageUrl']
                                : data['userProfileUrl'],
                          ),
                          radius: 65.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  child: Text(
                    widget.isOrganization ? data['name'] : data['userName'],
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                if (widget.isOrganization &&
                    int.tryParse(data['rating']) != null)
                  RatingStars(int.tryParse(data['rating']) ?? 0, 18.0),
                if (widget.isOrganization &&
                    int.tryParse(data['rating']) != null)
                  SizedBox(height: 5.0),
                if (!widget.isOrganization)
                  Padding(
                    padding: EdgeInsets.only(
                        right: widget.isOrganization ? 10.0 : 0.0),
                    child: Text(
                      data['userRole'],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: widget.isOrganization ? 5.0 : 10.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(
                            Icons.location_city,
                            size: 40.0,
                            color: Colors.indigo,
                          ),
                          title: Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            widget.isOrganization
                                ? data['address']
                                : 'Currently organization not registered',
                            style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  widget.isOrganization ? null : Colors.green,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(
                            Icons.email,
                            size: 40.0,
                            color: Colors.indigo,
                          ),
                          title: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            widget.isOrganization
                                ? data['email']
                                : data['userEmail'],
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(
                            Icons.confirmation_num,
                            size: 40.0,
                            color: Colors.indigo,
                          ),
                          title: Text(
                            'Register Number',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            widget.isOrganization
                                ? data['registrationNo']
                                : 'Currently organization not registered',
                            style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  widget.isOrganization ? null : Colors.green,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            size: 40.0,
                            color: Colors.indigo,
                          ),
                          title: Text(
                            'Contact Number',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            widget.isOrganization
                                ? data['contactNo']
                                : 'Currently organization not registered',
                            style: TextStyle(
                              fontSize: 16.0,
                              color:
                                  widget.isOrganization ? null : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
