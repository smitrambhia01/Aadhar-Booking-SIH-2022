import 'package:aapka_aadhaar/authentication/guest.dart';
import 'package:aapka_aadhaar/authentication/otp.dart';
import 'package:aapka_aadhaar/authentication/register_page.dart';
import 'package:aapka_aadhaar/pages/home_page.dart';
import 'package:aapka_aadhaar/services/otp_verification.dart';
import 'package:aapka_aadhaar/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:form_field_validator/form_field_validator.dart';

class LoginAsGuest extends StatefulWidget {
  const LoginAsGuest({Key? key}) : super(key: key);

  @override
  State<LoginAsGuest> createState() => _LoginAsGuestState();
}

class _LoginAsGuestState extends State<LoginAsGuest> {
 
 final FirebaseAuth _auth = FirebaseAuth.instance;
 SignInAsGuest()async{
  try{
    UserCredential result = await _auth.signInAnonymously();
    User? user = result.user;
     return user;
  }catch(e){
    print(e.toString());
    return null;
  }
}
 



//void onCreate(){
 //FirebaseAuth mAuth;
  //mAuth = FirebaseAuth.getInstance();
//}



  // final mobileValidator = MultiValidator([
  //   RequiredValidator(errorText: 'Please enter a mobile number!!'),
  //   PatternValidator(r'^[6-9]\d{9}$',
  //       errorText: 'Please Enter a valid 10 digit Mobile Number')
  // ]);

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  // OTPVerification otpVerification = OTPVerification();
  // TextEditingController phone = TextEditingController();
  // bool phone_exists = false;

  // check_phone_exists(phoneNumber) async {
  //   final databaseReference = FirebaseDatabase.instance.ref();
  //   DatabaseEvent event = await databaseReference.once();
  //   Map<dynamic, dynamic> databaseData = event.snapshot.value as Map;
  //   if (databaseData['users'] != null) {
  //     dynamic keys_list = databaseData['users'].keys.toList();
  //     for (int i = 0; i < keys_list.length; i++) {
  //       if (databaseData['users'][keys_list[i]].containsValue(phoneNumber)) {
  //         phone_exists = true;
  //       }
  //     }
  //   }
  // }

  // showSnackBar() {
  //   final snackBar = SnackBar(
  //     content: const Text(
  //       'Account not registered!',
  //       style: TextStyle(
  //         fontFamily: 'Poppins',
  //         fontSize: 16,
  //       ),
  //     ),
  //   );

  //   // Find the ScaffoldMessenger in the widget tree
  //   // and use it to show a SnackBar.
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  reqPermission() async {
    Map<ph.Permission, ph.PermissionStatus> statuses =
        await [ph.Permission.location].request();
    print(statuses[ph.Permission.location]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reqPermission();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFBF9F6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/user_app_logo.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Login As Guest',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                     var result = await SignInAsGuest();
                     if(result == null) {
                      Text('error');
                     }
                     else{
                      return navigateToRegister();
                     }
                  }
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   "Enter your phone number, we will send you OTP to verify",
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black38,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // child: Form(
                  //   key: formKey,
                  //   child: Column(
                  //     children: [
                  //       TextFormField(
                  //           autovalidateMode:
                  //               AutovalidateMode.onUserInteraction,
                  //           keyboardType: TextInputType.phone,
                  //           maxLength: 10,
                  //           style: TextStyle(
                  //             fontFamily: 'Poppins',
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           cursorColor: Colors.black,
                  //           controller: phone,
                  //           decoration: InputDecoration(
                  //             label: Text('Mobile'),
                  //             labelStyle: TextStyle(
                  //               color: Colors.grey.shade700,
                  //             ),
                  //             errorBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Colors.red),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             focusedErrorBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Colors.red),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Colors.black12),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             focusedBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: Colors.black12),
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             prefix: Padding(
                  //               padding: EdgeInsets.symmetric(horizontal: 8),
                  //               child: Text(
                  //                 '(+91)',
                  //                 style: TextStyle(
                  //                   fontFamily: 'Poppins',
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ),
                  //             // suffixIcon: Icon(
                  //             //   Icons.check_circle,
                  //             //   color: Colors.green,
                  //             //   size: 32,
                  //             // ),
                  //           ),
                  //           validator: mobileValidator),
                  //       SizedBox(
                  //         height: 22,
                  //       ),
                  //       SizedBox(
                  //         width: double.infinity,
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             if (formKey.currentState!.validate()) {
                  //               check_phone_exists(phone.text).whenComplete(() {
                  //                 phone_exists
                  //                     ? otpVerification
                  //                         .verifyPhone(phone.text)
                  //                         .whenComplete(() {
                  //                         Navigator.of(context).pushReplacement(
                  //                           MaterialPageRoute(
                  //                             builder: (context) => Otp(),
                  //                             settings:
                  //                                 RouteSettings(arguments: []),
                  //                           ),
                  //                         );
                  //                       })
                  //                     : showSnackBar();
                  //               });
                  //             }
                  //             // showDialog(
                  //             //     context: context,
                  //             //     barrierDismissible: false,
                  //             //     builder: (BuildContext c) {
                  //             //       return ProgressDialog(
                  //             //           message: 'Processing',);
                  //             //     });
                  //           },
                  //           style: ButtonStyle(
                  //             foregroundColor: MaterialStateProperty.all<Color>(
                  //                 Colors.white),
                  //             backgroundColor:
                  //                 MaterialStateProperty.all(Color(0xFFF23F44)),
                  //             shape: MaterialStateProperty.all<
                  //                 RoundedRectangleBorder>(
                  //               RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(24.0),
                  //               ),
                  //             ),
                  //           ),
                  //           child: Padding(
                  //             padding: EdgeInsets.all(14.0),
                  //             child: Text(
                  //               'Send',
                  //               style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontFamily: 'Poppins',
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 18,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'New user? ',
                  //             style: TextStyle(
                  //               fontFamily: 'Poppins',
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xFF000000),
                  //             ),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //           GestureDetector(
                  //             onTap: navigateToRegister,
                  //             child: Text(
                  //               'Register now',
                  //               style: TextStyle(
                  //                 fontFamily: 'Poppins',
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Color(0xFFF23F44),
                  //               ),
                  //               textAlign: TextAlign.center,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //         MaterialPageRoute(
                        //             builder: ((context) => HomePage())));
                        //   },
                        //   child: Text(
                        //     'Home Page',
                        //     style: TextStyle(
                        //       fontFamily: 'Poppins',
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color(0xFFF23F44),
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
    //                   ],
    //                 ),
    //               ),
             ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
