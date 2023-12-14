import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/profile_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/services/user_profile_service.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  late UserProfile userProfile;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _favoriteMealsController =
      TextEditingController();
  final TextEditingController _hateMealsController = TextEditingController();
  final TextEditingController _eatingHabitsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.credentials == null) {
        authProvider.loginAction(context);
      }
      final String accessToken = authProvider.credentials!.accessToken;

      UserProfileService userProfileService =
          UserProfileService(accessToken: accessToken);
      userProfile = await userProfileService.getProfile();
      _updateTextControllers();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user profile: $e');
      }
    }
  }

  String getImageFromAuthProvider() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.credentials?.user.pictureUrl.toString() ?? '';
  }

  void _updateTextControllers() {
    _fullNameController.text = userProfile.fullName;
    _addressController.text = userProfile.address;
    _nationalityController.text = userProfile.nationality;
    _bioController.text = userProfile.bio;
    _favoriteMealsController.text = userProfile.favoriteMeals;
    _hateMealsController.text = userProfile.hateMeals;
    _eatingHabitsController.text = userProfile.eatingHabits;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _nationalityController.dispose();
    _bioController.dispose();
    _favoriteMealsController.dispose();
    _hateMealsController.dispose();
    _eatingHabitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Color(0xFFFD637C),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: appTheme.blueGray100,
                              width: 2,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(getImageFromAuthProvider()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Subscription Button
                    _buildSubscribeButton(),
                    const SizedBox(height: 20),
                    // Profile Fields
                    _buildProfileField("Full Name", _fullNameController),
                    _buildProfileField("Address", _addressController),
                    _buildProfileField("Nationality", _nationalityController),
                    _buildProfileField("Bio", _bioController),
                    _buildProfileField(
                        "Favorite Meals", _favoriteMealsController),
                    _buildProfileField("Hate Meals", _hateMealsController),
                    _buildProfileField(
                        "Eating Habits", _eatingHabitsController),
                    const SizedBox(height: 20),
                    // Save/Edit and Logout Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomElevatedButton(
                          height: 50,
                          width: 100,
                          text: _isEditing ? "Save" : "Edit",
                          buttonTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                          ),
                          buttonStyle: CustomButtonStyles.none,
                          decoration: CustomButtonStyles
                              .gradientPrimaryToOnPrimaryContainerDecoration,
                          onPressed: () {
                            if (_isEditing) {
                              _saveProfileChanges(context);
                            } else {
                              _toggleEditing();
                            }
                          },
                        ),
                        CustomElevatedButton(
                          height: 50,
                          width: 100,
                          text: "Logout",
                          buttonTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                          ),
                          buttonStyle: CustomButtonStyles.none,
                          decoration: CustomButtonStyles
                              .gradientPrimaryToOnPrimaryContainerDecoration,
                          onPressed: () {
                            _logout(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEatingHabits(String? value) {
    if (value == null || value.isEmpty) {
      return 'Eating habit cannot be empty';
    }
    final number = int.tryParse(value);
    if (number == null || number < 1 || number > 8) {
      return 'Enter a number between 1 and 8';
    }
    return null;
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFFD637C),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: controller,
          hintText: controller.text,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderDecoration: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: appTheme.blueGray100,
              width: 2,
            ),
          ),
          enabled: _isEditing && label != "Email",
          validator: label == "Eating Habits" ? _validateEatingHabits : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSubscribeButton() {
    return GestureDetector(
      onTap: () {
        // Add logic for subscription
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange, Colors.red],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.loop_sharp, color: Colors.white),
            Text(
              'Subscribe to TableTalk',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_forward_rounded, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfileChanges(BuildContext context) async {
    try {
      UserProfile updatedProfile = UserProfile(
        id: userProfile.id,
        accountId: userProfile.accountId,
        fullName: _fullNameController.text,
        email: userProfile.email,
        phone: userProfile.phone,
        address: _addressController.text,
        nationality: _nationalityController.text,
        country: userProfile.country,
        bio: _bioController.text,
        favoriteMeals: _favoriteMealsController.text,
        hateMeals: _hateMealsController.text,
        eatingHabits: _eatingHabitsController.text,
        membership: userProfile.membership,
        searchCount: userProfile.searchCount,
      );

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.credentials == null) {
        authProvider.loginAction(context);
      }
      final String accessToken = authProvider.credentials!.accessToken;

      UserProfileService userProfileService =
          UserProfileService(accessToken: accessToken);

      await userProfileService.updateProfile(userProfile.id, updatedProfile);

      // Update local user profile with new data
      userProfile = updatedProfile;
      _toggleEditing();
    } catch (e) {
      // Handle error
      print('Error updating user profile: $e');
    }
  }

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logoutAction();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, AppRoutes.startScreen);
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }
}
