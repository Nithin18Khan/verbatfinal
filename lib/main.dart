import 'package:firebase_core/firebase_core.dart';
import 'package:verbat_iot_final/firebase_options.dart';
import 'package:verbat_iot_final/model/extension/colors.dart';
import 'package:verbat_iot_final/model/extension/config.dart';
import 'package:verbat_iot_final/viewmodel/routes/routes.dart';
import 'package:verbat_iot_final/viewmodel/styles/app_scroll_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MainColors mainColors = MainColors();

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: MaterialApp(
      theme: mainColors.toThemeData(),
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: RouteGen.generateRoute,
    ));
  }

  String get initialRoute => Routes.loginScreen;
}
