import 'package:verbat_iot_final/model/extension/config.dart';
import 'package:verbat_iot_final/view/widget/custom_app_bar.dart';
import 'package:verbat_iot_final/view/widget/search_widget.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool isOnline = false;

  // Toggle online/offline status
  void toggleOnlineStatus() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          isOnline: isOnline, toggleOnlineStatus: toggleOnlineStatus),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SearchWidget(),
      ),
    );
  }
}
