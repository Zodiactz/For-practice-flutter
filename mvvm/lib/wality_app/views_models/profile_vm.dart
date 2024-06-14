import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wality_application/wality_app/services/firebase_auth_service.dart';
import 'package:wality_application/wality_app/models/user.dart';

class ProfileViewModel extends ChangeNotifier {
  final FireBaseAuthService _authService = FireBaseAuthService();
  final currentUser = FirebaseAuth.instance.currentUser;
  String username =
      FirebaseAuth.instance.currentUser?.displayName ?? "UserName";

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }


  getUserInfo(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots().listen((event) {
    
      notifyListeners();
    });
  }

  Divider buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
      indent: 2,
      endIndent: 16,
    );
  }


  Flexible buildProfileOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6D8093).withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                icon,
                size: 44,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 28),
              child: Icon(Icons.chevron_right, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
