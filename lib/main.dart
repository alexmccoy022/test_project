import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'firebase_options.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51MVKzaFMHgIHiJBNooTKPwCXUrrxXM7mF4N7XriQ183oi32aQqnw9mqr8cFHNqMNQ5Hj9Kgw0CgwhvndJn2frhaj003yMax83e";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // ... other providers
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    late final providers = [EmailAuthProvider()];

    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                // if (!state.user!.emailVerified) {
                //   Navigator.pushNamed(context, '/verify-email');
                // } else {
                Navigator.pushReplacementNamed(context, '/home');
                // }
              }),
            ],
          );
        },
        '/home': (context) => MyImageLoader(),
        '/profile': (context) {
          return ProfileScreen(
            appBar: AppBar(
              title: const Text('Profile'),
              leading: BackButton(),
            ),
            providers: providers,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: CircleAvatar(
                  // backgroundImage: NetworkImage(
                  //   FirebaseAuth.instance.currentUser!.photoURL!,
                  // ),
                  ),
            ),
          ],
        ),
        body: Column(children: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter prompt',
                  ),
                )),
          ),
          // Center(
          //   child: MyImageWidget(
          //       imageUrl:
          //           'https://oaidalleapiprodscus.blob.core.windows.net/private/org-FiNMDzQ2wfMXbIf3QNIlepEo/user-zXR963WDduBmLDrhjgJFreyL/img-JIgCI4nxj6isnjjfo4V5tYOx.png?st=2023-03-01T03%3A55%3A48Z&se=2023-03-01T05%3A55%3A48Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-03-01T02%3A11%3A08Z&ske=2023-03-02T02%3A11%3A08Z&sks=b&skv=2021-08-06&sig=m%2B6duVUCj7bRwvYBtuoDXhJuLVG0N/oICYkrNwZBbDE%3D'),
          // )
        ]));
  }
}

class MyImageLoader extends StatefulWidget {
  @override
  _MyImageLoaderState createState() => _MyImageLoaderState();
}

class _MyImageLoaderState extends State<MyImageLoader> {
  String imageUrl = '';
  bool showPayButton = false;
  bool isLoading = false;

  Future<void> _loadImage() async {
    try {
      final result =
          await FirebaseFunctions.instance.httpsCallable('createImages').call();
      final url = result.data;
      // return 'https://oaidalleapiprodscus.blob.core.windows.net/private/org-FiNMDzQ2wfMXbIf3QNIlepEo/user-zXR963WDduBmLDrhjgJFreyL/img-jyAOuzSgAXEXZ1wY1MFCrxLR.png?st=2023-03-03T02%3A20%3A22Z&se=2023-03-03T04%3A20%3A22Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-03-03T00%3A13%3A18Z&ske=2023-03-04T00%3A13%3A18Z&sks=b&skv=2021-08-06&sig=50KpHNCeXCI9Pii0z6ypGEjIJALYg0o7YfN6c6vk/kk%3D';
      setState(() {
        imageUrl = url;
        showPayButton = true;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        // showPayButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
          Padding(
            padding: new EdgeInsets.all(25.0),
            child: isLoading
                ? CircularProgressIndicator()
                : imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )
                    : Text('Press the button to load the image'),
          ),
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => {
            setState(() {
              isLoading = true;
            }),
            await _loadImage(),
            setState(() {
              isLoading = false;
            })
          },
          child: Icon(Icons.image),
        ));
  }
}

// createImageUrl() async {
//   final result =
//       await FirebaseFunctions.instance.httpsCallable('createImages').call();
//   final image = result.data;
//   // return 'https://oaidalleapiprodscus.blob.core.windows.net/private/org-FiNMDzQ2wfMXbIf3QNIlepEo/user-zXR963WDduBmLDrhjgJFreyL/img-jyAOuzSgAXEXZ1wY1MFCrxLR.png?st=2023-03-03T02%3A20%3A22Z&se=2023-03-03T04%3A20%3A22Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-03-03T00%3A13%3A18Z&ske=2023-03-04T00%3A13%3A18Z&sks=b&skv=2021-08-06&sig=50KpHNCeXCI9Pii0z6ypGEjIJALYg0o7YfN6c6vk/kk%3D';
//   return image;
// }
