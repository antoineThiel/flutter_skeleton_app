import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_skeleton_app/components/custom_slider.dart';
import 'package:flutter_skeleton_app/components/custom_spinner.dart';
import 'package:flutter_skeleton_app/components/get_widget_example.dart';
import 'package:flutter_skeleton_app/components/images/images_example.dart';
import 'package:flutter_skeleton_app/components/row_with_slider.dart';
import 'package:flutter_skeleton_app/pages/signup_page.dart';
import 'package:flutter_skeleton_app/services/graphql/graphql_api.dart';
import 'package:flutter_skeleton_app/services/http_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'services/states/authentication_state.dart';

void main() async {
  //You need this
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  //For Mobile App SplashScreen -> show while app is loading
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  //Hive & GraphQL
  await initHiveForFlutter();

  //Hive Open a box
  await Hive.openBox("HomePage");

  //Using Provider without GraphQL
  // runApp(
  //   MultiProvider(
  //     //List Providers here
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => AuthenticationState(), builder: ,)
  //     ],
  //     child: const MyApp(),
  //     ),
  //   );

  //Default or GraphQl
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    //Using Get package for routes ? else use Default
    // return GetMaterialApp(
    //   title: 'Flutter Skeleton',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(),
    // );

    //GraphQl with Auth -> no Auth is less complicated
    return ChangeNotifierProvider(
      create: (context) => AuthenticationState(),
      builder: ((context, child) {
        final AuthenticationState authenticationState =
            Provider.of<AuthenticationState>(context);
        Link link;
        final HttpLink httpLink = HttpLink(GraphQLApi.baseLink);
        if (authenticationState.authenticationToken != null &&
            authenticationState.authenticationToken.isNotEmpty) {
          final AuthLink authLink = AuthLink(
            getToken: () =>
                'Bearer ${authenticationState.authenticationToken[0]}',
          );
          link = authLink.concat(httpLink);
        } else {
          link = httpLink;
        }
        ValueNotifier<GraphQLClient> client = ValueNotifier(
          GraphQLClient(
            cache: GraphQLCache(store: HiveStore()),
            link: link,
          ),
        );
        return GraphQLProvider(
          client: client,
          child: MaterialApp(
            debugShowCheckedModeBanner: true,
            title: "Flutter Demo",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(),
          )
        );
      }),
    );

    //Default
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var box = Hive.box("HomePage");

  @override
  void initState() {
    box.put("key", "I come from a box");
    super.initState();
  }

  // Using SharedPreferences ?
  // void writeAndReadInSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("Key", "I've been written in shared preferences");
  //   final String? writtenString = prefs.getString("Key");
  //   debugPrint(writtenString);
  // }

  //Using permission ? How To Read
  void getPermissionStatus() async {
    final PermissionStatus status = await Permission.camera.status;
    debugPrint(status.toString());
  }

  //Using permissionn ? How to get => add permission required in android/app/src/AndroidManifest.xml (Camera Example)
  void getPermission() async {
    await Permission.camera.request();
  }

  //Using Hive ?
  void printFromHiveBox() {
    debugPrint(box.get('key'));
  }

  @override
  Widget build(BuildContext context) {
    //Provider get auth status
    // bool authentified = Provider.of<AuthenticationState>(context).isAuthenticated();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Skeleton"),
        automaticallyImplyLeading: false,
      ),
      //SingleChildScrollView to be able to scroll in all page
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SharedPreferences ? (Only mobile)
              // ElevatedButton(
              //   onPressed: writeAndReadInSharedPreferences,
              //   child: const Text("Write in shared Preferences"),
              // ),

              //Provider display auth status
              // Text("Provider Authen State value : ${authentified.toString()}")

              //GetWidget : https://docs.getwidget.dev/introduction/ && permissionExample (Only mobile)
              GetWidgetExample(btn1Fn: getPermissionStatus, btn2Fn: getPermissionStatus,),

              //GetWidgetExemple
              //network Images
              const ImagesExample(),

              //Flutter row slider
              const RowWithSlider(),

              //Flutter SVG
              const Text("SVG :"),
              SvgPicture.asset("assets/svgs/exemple.svg"),

              //Http & Hive
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Button to test Http API - Pokémon Api file : lib/services/http_api.dart
                  ElevatedButton(
                      onPressed: () {
                        HttpApi().getCharmanderDetails();
                      },
                      child: const Text("Print charmander\n details http api")),
                  //Print Hive Box
                  ElevatedButton(
                      onPressed: () {
                        printFromHiveBox();
                      },
                      child: const Text("print phrase from hive")),
                ],
              ),

              //Carousel Slider
              const CustomSlider(),

              //Custom Spinner
              const CustomSpinner(),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignupPage();
                  }));
                }, 
                child: Text("Tester GraphQl - connecté ? ${Provider.of<AuthenticationState>(context).isAuthenticated()}")
              ),

              //flutter launcher icon config file => fluter_launcher_icons.yaml then run "flutter pub run flutter_launcher_icons:main"
              //flutter splash screen config file => fluter_native_splash.yaml then run "flutter pub run flutter_native_splash:create"
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
