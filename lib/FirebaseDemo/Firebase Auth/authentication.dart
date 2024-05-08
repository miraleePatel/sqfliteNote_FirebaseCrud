import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Constants/constants.dart';
import '../Screens/signin_page.dart';

class FirebaseServices{

  // Signup(String email,String password)async{
  //   try{
  //     var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  //     return response;
  //   }
  //   catch(e){
  //     return e.toString();
  //   }
  // }


  Signin(String email,String password)async{
    try{
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return response;
    }
    catch(e){
      return e.toString();
    }
  }
  // Future<User?> Signin(String email,String password)async{
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try{
  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  //
  //     user = userCredential.user;
  //     user = auth.currentUser;
  //     return user;
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }

 Future<User?> Signup({required String name, required String email, required String password,}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
     // FirebaseFirestore.instance.collection('users').doc(user!.uid).set({ 'userid': user!.uid, 'displayName': name});
      FireStoreController.inserUser({'userid': user!.uid, 'name': name,'email': email
      ,'password' : null,'contact':"9185632598",'dob' : null, 'image' : null
      },user.uid);
      await user.updateProfile(displayName: name,photoURL:null );
      await user.reload();
      user = auth.currentUser;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }


  }

  Googlelogin() async{
    try{
      GoogleSignIn _googleSignIn = GoogleSignIn();
      var response = await _googleSignIn.signIn();
      User? user;

      if(response != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await response.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken
        ,idToken: googleSignInAuthentication.idToken
        );
         final UserCredential userCredential =
         await FirebaseAuth.instance.signInWithCredential(credential);
         user = userCredential.user!;
        FireStoreController.inserUser({'userid': user!.uid, 'name': user.displayName,'email': user.email
          ,'password' : null,'contact':"9185632598",'dob' : null, 'image' : user.photoURL
        },user.uid);
      }
      return user;
    }catch(e){
      return e.toString();
    }
  }
  signInWithFacebook() async {
    try{
        final fb = FacebookLogin();
        // Log in
        final res = await fb.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]);
        User? user;
        if(res !=null){

              // Send access token to server for validation and auth
                final FacebookAccessToken? accessToken = res.accessToken;
                final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken!.token);
                final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

                user = userCredential.user!;
                FireStoreController.inserUser({'userid': user!.uid, 'name': user!.displayName,'email': user!.email
                  ,'password' : null,'contact':856024698,'dob' : null, 'image' : user!.photoURL
                },user!.uid);
                // Get profile data from facebook for use in the app
                final profile = await fb.getUserProfile();
                print('Hello, ${profile!.name}! You ID: ${profile.userId}');
                // Get user profile image url
                final imageUrl = await fb.getProfileImageUrl(width: 100);
                print('Your profile image: $imageUrl');
                // fetch user email
                final email = await fb.getUserEmail();
                // But user can decline permission
                if (email != null) print('And your email is $email');
        }
        return user;
    }catch(e){return e.toString();}
  }
  // signInWithFacebook() async {
  //   final fb = FacebookLogin();
  //   // Log in
  //   final res = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //
  //   // Check result status
  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //     // The user is suceessfully logged in
  //     // Send access token to server for validation and auth
  //       final FacebookAccessToken? accessToken = res.accessToken;
  //       final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken!.token);
  //       final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
  //
  //       user = userCredential.user!;
  //       FireStoreController.inserUser({'userid': user!.uid, 'name': user!.displayName,'email': user!.email
  //         ,'password' : null,'contact':856024698,'dob' : null, 'image' : user!.photoURL
  //       },user!.uid);
  //       // Get profile data from facebook for use in the app
  //       final profile = await fb.getUserProfile();
  //       print('Hello, ${profile!.name}! You ID: ${profile.userId}');
  //       // Get user profile image url
  //       final imageUrl = await fb.getProfileImageUrl(width: 100);
  //       print('Your profile image: $imageUrl');
  //       // fetch user email
  //       final email = await fb.getUserEmail();
  //       // But user can decline permission
  //       if (email != null) print('And your email is $email');
  //       break;
  //     case FacebookLoginStatus.cancel:
  //     // In case the user cancels the login process
  //       break;
  //     case FacebookLoginStatus.error:
  //     // Login procedure failed
  //       print('Error while log in: ${res.error}');
  //       break;
  //   }
  // }

  FirebaseAuth authentication = FirebaseAuth.instance;

  logOutCurrentUser(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    FacebookLogin fb = FacebookLogin();
    try {
      await _googleSignIn.signOut();
      await fb.logOut();
      authentication.signOut();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SigninPage()), (route) => false);
    }
    catch (e) {
      print(e.toString());
    }
  }

}

