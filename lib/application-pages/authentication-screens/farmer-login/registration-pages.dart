import 'dart:convert';
import 'dart:io';
import 'package:agriteck_user/common-functions/helper-functions.dart';
import 'package:agriteck_user/commonly-used-widget/dailog-box.dart';
import 'package:agriteck_user/commonly-used-widget/round_button.dart';
import 'package:agriteck_user/commonly-used-widget/shape-painter.dart';
import 'package:agriteck_user/commonly-used-widget/textField.dart';
import 'package:agriteck_user/pojo-classes/users.dart';
import 'package:agriteck_user/services/sharedPrefs.dart';
import 'package:agriteck_user/services/user-services.dart';
import 'package:agriteck_user/styles/app-colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../main-page.dart';

class FarmerRegistrationForm extends StatefulWidget {
  final String phoneNumber;

  FarmerRegistrationForm(this.phoneNumber);

  @override
  _FarmerRegistrationFormState createState() => _FarmerRegistrationFormState();
}

class _FarmerRegistrationFormState extends State<FarmerRegistrationForm> {
  String _name ;
  DateTime backButtonPressTime;
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _dateTime;
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

//when a user attempt going back this dialog is shown to warn the user
  Future<bool> _onBackPressed() async {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'Leave !',
                descriptions: 'Are you Sure you want to leave this page ?',
                btn1Text: 'No',
                btn2Text: 'Yes',
                img: 'assets/images/warning.png',
                btn1Press: () {
                  Navigator.pop(context);
                },
                btn2Press: () async {
                  await FirebaseAuth.instance.signOut();
                 
                },
              );
            }) ??
        false;
  }

//=============================================================================
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
          title: Text(
            'Complete Registration',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Container(
            height: _height,
            width: _width,
            child: CustomPaint(
              painter:
                  ShapePainter(), //this is the Image-like design on the backgroun
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white.withOpacity(.6),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Container(
                              child: Column(
                                children: [
                                  _imageChooser(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                                   
                                  InputTextField(
                                    withDecoration: true,
                                    onSave: (value) {
                                      setState(() {
                                        _name = value;
                                      
                                      });
                                    },
                                    type: TextInputType.text,
                                    label: 'Full Name',
                                    validation: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter your Name';
                                      } else
                                        return null;
                                    },
                                    prefixIcon: Icon(
                                      Icons.drive_file_rename_outline,
                                      color: primary,
                                    ),
                                    isPassword: false,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                               
                      
                                  SizedBox(
                                      width: 200,
                                      child: RoundedButton(
                                          isLoading: isLoading,
                                          text: 'SUBMIT',
                                          color: primaryDark,
                                          press: isLoading ? null : saveData)),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

 
  Widget _imageChooser() {
    return Center(
      child: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white,
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    _image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(50)),
                  width: 150,
                  height: 150,
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black38,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 25),
                        child: Text(
                          'Take photo',
                          style: TextStyle(color: primaryDark),
                        ),
                      ),
                    )
                  ]),
                ),
        ),
      ),
    );
  }

 
  getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      await showSnackBar('No image selected.', _scaffoldKey.currentState);
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          getImageFromGallery();
                          Navigator.of(context).pop();
                        });
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      setState(() {
                        getImageFromCamera();
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  saveData() async {
    if (_formKey.currentState.validate()) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
   
        try {
          User user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            print('Firebaser User ${user.uid}');
            String photoUrl;
            if (_image != null) {
              //photoUrl = await UserServices.uploadPic(_image, user.uid);
            }
            Users farmers =  Users(
              id: user.uid,
              phone: user.phoneNumber,
              createdOn: DateTime.now().toUtc().millisecondsSinceEpoch,
              image: photoUrl,
                name: _name,
               );
            //await UserServices.saveUserInfo('Farmers', user.uid, farmers);
            await SharedPrefs.setUserData(json.encode(farmers.toJson()));
            await FirebaseAuth.instance.currentUser.updateDisplayName( _name);
              await FirebaseAuth.instance.currentUser.updatePhotoURL(photoUrl);
            isLoading = false;
            await showToast(
                context, fToast, Icons.check, primaryDark, "User data Saved");
            sendToPage(
                context,
                MainPage(
                  initPage: BottomButtons.Home,
                ));
          }
        } catch (error) {
          setState(() {         
            isLoading = false;
            print('[$error]');          
          });
        }  
    if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
