import 'package:verbat_iot_final/model/extension/assets.dart';
import 'package:verbat_iot_final/services/providers/firestore_service_provider.dart';
import 'package:verbat_iot_final/view/widget/customTextInput.dart';
import 'package:verbat_iot_final/view/widget/custom_app_bar.dart';
import 'package:verbat_iot_final/view/widget/save_button.dart';
import 'package:verbat_iot_final/view/widget/upload_photo.dart';
import 'package:verbat_iot_final/viewmodel/routes/routes.dart';

import '../../model/extension/config.dart';

final onlineStatusProvider = StateProvider<bool>((ref) => true);

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isOnline = ref.watch(onlineStatusProvider);
    final toggleOnlineStatus = () {
      ref.read(onlineStatusProvider.notifier).state = !_isOnline;
    };

    final TextEditingController nationalIdController = TextEditingController();
    final TextEditingController farmIdController = TextEditingController();
    final TextEditingController fatherNameController = TextEditingController();
    final TextEditingController coopIdController = TextEditingController();
    final TextEditingController coopNameController = TextEditingController();
    final TextEditingController dobController = TextEditingController();
    final TextEditingController genderController = TextEditingController();

    final isTablet = MediaQuery.of(context).size.width >= 600;

    Future<void> saveFormData(BuildContext context) async {
      try {
        // Collect the form data
        final nationalId = nationalIdController.text;
        final farmId = farmIdController.text;
        final fatherName = fatherNameController.text;
        final coopName = coopNameController.text;
        final coopId = coopIdController.text;
        final dob = dobController.text;
        final gender = genderController.text;

        // Assuming the photo URL is provided by the UploadFarmerPhotoWidget
        String photoUrl =
            "https://path-to-uploaded-photo.com"; // Replace with actual URL
// Replace this with actual URL from photo upload logic

        // Save data to Firestore
        final firestoreService = ref.read(firestoreServiceProvider);
        await firestoreService.saveRegistrationData(
          nationalId: nationalId,
          farmId: farmId,
          fatherName: fatherName,
          coopName: coopName,
          coopId: coopId,
          dob: dob,
          gender: gender,
          photoUrl: photoUrl,
        );

        // Optionally, show a success message or navigate elsewhere
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Registration saved successfully!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );

        // Navigate to the DashboardScreen
        Navigator.pushNamed(context, Routes.dashBoard);
      } catch (error) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to save registration. Please try again.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
          isOnline: _isOnline, toggleOnlineStatus: toggleOnlineStatus),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: "Farmer Registration" + Save Button
            Transform.translate(
              offset: const Offset(0, -20), // Move 20 units upwards
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Farmer Registration',
                        style: TextStyle(
                          fontFamily: 'Schyler',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SvgPicture.asset(
                          Svgpath.farmergroup,
                          height: 75,
                          width: 75,
                        ),
                      ),
                    ],
                  ),
                  // Save Button on the right side
                  SaveButton(
                    onPressed: () => saveFormData(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 95,
              color: Colors.green,
            ),
            const SizedBox(height: 20),

            // Form Fields - Dynamically adapt rows
            // First row
            if (isTablet)
              Row(
                children: [
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'National ID',
                      hintText: 'ID',
                      controller: nationalIdController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'Farm ID',
                      hintText: 'ID',
                      controller: farmIdController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'Father\'s Name',
                      hintText: 'Name',
                      controller: fatherNameController,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  CustomTextInput(
                    labelText: 'National ID',
                    hintText: 'ID',
                    controller: nationalIdController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextInput(
                    labelText: 'Farm ID',
                    hintText: 'ID',
                    controller: farmIdController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextInput(
                    labelText: 'Father\'s Name',
                    hintText: 'Name',
                    controller: fatherNameController,
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Second row
            if (isTablet)
              Row(
                children: [
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'Coop Name',
                      hintText: 'ID',
                      controller: coopNameController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'Coop ID',
                      hintText: 'Coop',
                      controller: coopIdController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'DOB',
                      hintText: 'M/D/Y',
                      controller: dobController,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today,
                            color: Colors.black),
                        onPressed: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Colors
                                      .blue, // Set the header color (month)
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors
                                        .blue, // Set the color for the selected date
                                    secondary:
                                        Colors.blue, // Accent color for buttons
                                    background: Colors
                                        .white, // Set the background color of the calendar
                                  ),
                                  textTheme: const TextTheme(
                                    bodyMedium: TextStyle(
                                        color: Colors
                                            .black), // Set the color for the day numbers
                                    titleLarge: TextStyle(
                                        color: Colors
                                            .black), // Set the color for month/year
                                  ),
                                  buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDate != null) {
                            // Format the selected date and set it in the controller's text
                            dobController.text =
                                "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year}";
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  CustomTextInput(
                    labelText: 'Coop Name',
                    hintText: 'ID',
                    controller: coopNameController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextInput(
                    labelText: 'Coop ID',
                    hintText: 'Coop',
                    controller: coopIdController,
                  ),
                  const SizedBox(height: 8),
                  CustomTextInput(
                    labelText: 'DOB',
                    hintText: 'M/D/Y',
                    controller: dobController,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          dobController.text =
                              "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
                        }
                      },
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Third row
            if (isTablet)
              Row(
                children: [
                  Expanded(
                    child: CustomTextInput(
                      labelText: 'Gender',
                      hintText: 'Male',
                      controller: genderController,
                      suffixIcon: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.black), // Down arrow icon
                        onSelected: (String selectedGender) {
                          genderController.text =
                              selectedGender; // Update the controller
                        },
                        itemBuilder: (BuildContext context) =>
                            const <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Male',
                            child: Text('Male',
                                style: TextStyle(
                                    color: Colors.black)), // Black text
                          ),
                          PopupMenuItem<String>(
                            value: 'Female',
                            child: Text('Female',
                                style: TextStyle(
                                    color: Colors.black)), // Black text
                          ),
                          PopupMenuItem<String>(
                            value: 'Others',
                            child: Text('Others',
                                style: TextStyle(
                                    color: Colors.black)), // Black text
                          ),
                        ],
                        color:
                            Colors.white, // White background for the dropdown
                        offset: Offset(0, 40), // Positioning below the arrow
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Container()), // Empty for alignment
                  const SizedBox(width: 8),
                  Expanded(child: Container()), // Empty for alignment
                ],
              )
            else
              CustomTextInput(
                labelText: 'Gender',
                hintText: 'Male',
                controller: genderController,
                suffixIcon: PopupMenuButton<String>(
                  icon: const Icon(Icons.arrow_downward,
                      color: Colors.black), // Down arrow icon
                  onSelected: (String selectedGender) {
                    genderController.text =
                        selectedGender; // Update the controller
                  },
                  itemBuilder: (BuildContext context) =>
                      const <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Male',
                      child: Text('Male',
                          style: TextStyle(color: Colors.black)), // Black text
                    ),
                    PopupMenuItem<String>(
                      value: 'Female',
                      child: Text('Female',
                          style: TextStyle(color: Colors.black)), // Black text
                    ),
                    PopupMenuItem<String>(
                      value: 'Others',
                      child: Text('Others',
                          style: TextStyle(color: Colors.black)), // Black text
                    ),
                  ],
                  color: Colors.white, // White background for the dropdown
                  offset: Offset(0, 40), // Positioning below the arrow
                ),
              ),

            const SizedBox(height: 30),

            // Upload Farmer Photo widget
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UploadFarmerPhotoWidget(),
              ],
            ),
            const SizedBox(height: 30),

            // Mobile-specific button below the upload widget
            if (!isTablet)
              Center(
                child: SaveButton(
                  onPressed: () => saveFormData(context),
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
