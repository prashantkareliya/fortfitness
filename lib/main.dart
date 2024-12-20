import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortfitness/screens/auth/auth_selection.dart';
import 'package:fortfitness/utils/app_colors.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/progress_indicator.dart';
import 'constants/strings.dart';
import 'screens/dashboard/dashboard_screen.dart';
//https://www.figma.com/design/tkmMOGlfPmEGW1z5Iasp35/FortFitness-App?node-id=0-1&node-type=canvas&t=aL3Qf0hxzLNZVQL3-0
///api/lock/:lockid/unlock
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyDd7t_fZ9Nx39WHjxK93uZsYiGGssrxIvE",
      appId: "1:141538630694:android:29342b5d815960145f1ae7",
      messagingSenderId: "141538630694", projectId: "fortfitnessapp"));
  await SentryFlutter.init(
        (options) {
          options.dsn = 'https://3dba6b0b270aa0d1403382feef922c48@o4508421010030592.ingest.us.sentry.io/4508455997800448';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        title: 'Fort Fitness',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          useMaterial3: true,
          fontFamily: 'Work Sans',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          scaffoldBackgroundColor: AppColors.whiteColor,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: AppColors.primaryColor, secondary: AppColors.whiteColor),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double padValue = 0.0;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(microseconds: 1));
    FlutterNativeSplash.remove();

    setState(() {
      padValue = 25.sp;
    });
    Timer(const Duration(seconds: 3), () => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  Future checkFirstSeen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString(PreferenceString.accessToken) != null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen(from: "main")));
    } else {
      Navigator.pushAndRemoveUntil(
          context, FadePageRoute(builder: (context) => const AuthSelectionScreen()), (_) => false);
    }

  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: query.height,
        width: query.width,
        decoration:  const BoxDecoration(
            image: DecorationImage(image: AssetImage(ImageString.imgSplash), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: query.height * 0.23),
              AnimatedPadding(
                duration: const Duration(seconds: 1),
                padding: EdgeInsets.symmetric(vertical: padValue),
                curve: Curves.easeInOut,
                child: Image.asset(ImageString.imgLogo, fit: BoxFit.fill, width: 0.6.sw),
              ),
              const Spacer(),
              AnimatedPadding(
                duration: const Duration(seconds: 1),
                padding: EdgeInsets.symmetric(vertical: padValue),
                curve: Curves.easeInOut,
                child: SpinKitCircle(
                  color: AppColors.whiteColor,
                  size: 80.0,
                )
              ),
              SizedBox(height: query.height * 0.03,),
            ],
          ),
        ),
      ),
    );
  }
}

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1200);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    if (settings.name == "/auth") {
      return child;
    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

