import 'package:flutter/material.dart';

import 'package:gaphql_example/extensions/strings.dart';
import 'package:gaphql_example/locator.dart';
// import 'package:gaphql_example/models/user.dart';
import 'package:gaphql_example/routes.dart';
import 'package:gaphql_example/services/graphql_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gaphql_example/viewmodels/auth_view_model.dart';
import 'package:gaphql_example/viewmodels/profile_view_model.dart';
// // import 'package:graphql/client.dart';
// // import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: appRoutes,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  // final _usernameFormKey = GlobalKey<FormState>();

  ProfileViewModel pvm = ProfileViewModel();
  AuthViewModel avm = AuthViewModel();
  final String? photoUrl = "";
  final bool isFile = false;

  @override
  Widget build(BuildContext context) {
    String title = "graphql";
    // ImageProvider<Object>? bgImage = (photoUrl != null
    //     ? isFile
    //         ? FileImage(File(photoUrl!))
    //         : CachedNetworkImageProvider(photoUrl!)
    //     : null) as ImageProvider<Object>?;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(title.uppercaseFirst()),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Column(
                  children: [
                    Text(
                      "Welcome to Places. Choose a username for your profile.",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.amber[800]),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // Center(
                    //   child: CircleAvatar(
                    //     radius: 50,
                    //     backgroundImage: bgImage,
                    //     backgroundColor: const Color(0xFFDBF2D8),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.0),
                          ),
                          label: Text(
                            "Username",
                            style: TextStyle(color: Colors.grey),
                          ),
                          hintText: "wasiuu",
                          hintStyle: TextStyle(color: Colors.grey)),
                      controller: avm.usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a username";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onSaved: (value) {
                        avm.authData['username'] = value;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   maxLines: 3,
                    //   decoration: const InputDecoration(
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Colors.greenAccent, width: 1.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.red, width: 1.0),
                    //     ),
                    //     label: Text(
                    //       "Bio",
                    //       style: TextStyle(color: Colors.grey),
                    //     ),
                    //     hintText: "About you",
                    //   ),
                    //   controller: pvm.bioController,
                    //   onFieldSubmitted: (_) {
                    //     FocusScope.of(context).requestFocus(FocusNode());
                    //   },
                    //   onChanged: (value) {},
                    // ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  avm.validateAndCallFunction(formKey: _formKey);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                  child: Text("Proceed"),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
