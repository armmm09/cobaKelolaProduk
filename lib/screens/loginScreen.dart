// import 'package:cobaKelolaProduk/screens/productScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:lazyui/lazyui.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final notifier = LoginNotifier();

//     return Wrapper(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Textr('Login Page'),
//         ),
//         body: Padding(
//           padding:  Ei.sym(v:150),
//           child: Center(
            
//             child: LzListView(
//               scrollLimit: const [30],
//               padding: Ei.only(v: 35, h: 40),
//               onScroll: (controller) {},
//               children: [
//                 Column(
//                   crossAxisAlignment: Caa.center,
//                   children: [
//                     Textr('Welcome Back!', style: Gfont.bold.bold.fsize(24)),
//                     SizedBox(height: 15),
//                     Textr(
//                       'Login to continue',
//                       style: Gfont.grey.bold.fsize(16),
//                     ),
//                   ],
//                 ),
//                 LzFormGroup(
//                   bottomSpace: 10,
//                   children: [
//                     LzForm.input(
//                       label: 'Email',
//                       hint: 'Type your email',
//                       model: notifier.forms['email'],
//                     ),
//                     LzForm.input(
//                       label: 'Password',
//                       hint: 'Type your password',
//                       obsecureToggle: true,
//                       model: notifier.forms['password'],
//                     ),
//                   ],
//                 ),
//                 Textr(
//                   'Forgot Password',
//                   icon: Ti.lockBolt,
//                   style: Gfont.red,
//                   margin: Ei.only(b: 25),
//                 ),
//                 SizedBox(height: 20),
//                 LzButton(
//                     text: 'Login',
//                     onTap: (state) async {
//                       state.submit(); // set loading
//                       await Future.delayed(3.s); // simulasi request to server
        
//                       bool ok = await notifier.signin();
//                       state.abort(); // unset loading
        
//                       if (ok) {
//                         if (context.mounted) {
//                           context.pushAndRemoveUntil(ProductScreen());
//                         }
//                       } else {
//                         LzToast.show('Email atau password salah');
//                       }
//                     })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoginNotifier extends ChangeNotifier {
//   final forms = LzForm.make(['email', 'password']);

//   Future<bool> signin() async {
//     try {
//       final form = LzForm.validate(forms,
//           required: ['email', 'password'],
//           messages: FormMessages(required: {
//             'email': 'Alamat email tidak boleh kosong',
//             'password': 'Password tidak boleh kosong'
//           }));

//       if (form.ok) {
//         if (form.value['email'] == 'admin@gmail.com' &&
//             form.value['password'] == '12345') {
//           return true;
//         }
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }

//     return false;
//   }
// }
