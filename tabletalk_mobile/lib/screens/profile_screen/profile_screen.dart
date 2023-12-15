import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/profile_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userProfile}) : super(key: key);

  final UserProfile userProfile;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
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
                    // Profile Image
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_isEditing) {
                              _selectProfilePicture(context);
                            }
                          },
                          child: Container(
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
                                image: _selectedImage != null
                                    ? FileImage(File(_selectedImage!.path))
                                        as ImageProvider<Object>
                                    : NetworkImage(widget.userProfile.imageUrl),
                              ),
                            ),
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFD637C),
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  _selectProfilePicture(context);
                                },
                                splashRadius: 24,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                padding: const EdgeInsets.all(8),
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
                    _buildProfileField("Email", widget.userProfile.email),
                    _buildProfileField(
                        "Full Name", widget.userProfile.fullName),
                    _buildProfileField("Address", widget.userProfile.address),
                    _buildProfileField(
                        "Nationality", widget.userProfile.nationality),
                    _buildProfileField("Bio", widget.userProfile.bio),
                    _buildProfileField(
                        "Favorite Meals", widget.userProfile.favoriteMeals),
                    _buildProfileField(
                        "Hate Meals", widget.userProfile.hateMeals),
                    _buildProfileField("Eating Habit",
                        widget.userProfile.eatingHabit.toString()),

                    const SizedBox(height: 20),

                    // Third Row: Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Save/Edit Button
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

                        // Logout Button
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

  Widget _buildProfileField(String label, String value) {
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
          hintText: value,
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

  void _saveProfileChanges(BuildContext context) {
    // Add logic to save
    // Update the UserProfile model with the new values from the text fields.
    // call API update
    // After saving disable editing again.
    _toggleEditing();
  }

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logoutAction();

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, AppRoutes.startScreen);
  }

  void _selectProfilePicture(BuildContext context) async {
    if (_isEditing) {
      XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (selectedImage != null) {
        setState(() {
          _selectedImage = selectedImage;
        });
      }
    }
  }

  void _toggleEditing() {
    // Toggle editing
    setState(() {
      _isEditing = !_isEditing;
    });
  }
}
