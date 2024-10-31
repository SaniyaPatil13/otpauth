import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp/otpscreen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneContoller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: phoneContoller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Phone Number",
              suffixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24)
              )
            ),
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(onPressed: ()async{
          await FirebaseAuth.instance.verifyPhoneNumber(
              verificationCompleted: (PhoneAuthCredential credential){},
              verificationFailed: (FirebaseAuthException ex){},
              codeSent: (String verificationid,int? resendtoken){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(verificationid: verificationid,)));
              },
              codeAutoRetrievalTimeout: (String verificationId){},
              phoneNumber: phoneContoller.text.toString());
        },
            child: Text("Verify Phone Number"))
      ],),
    );
  }
}
