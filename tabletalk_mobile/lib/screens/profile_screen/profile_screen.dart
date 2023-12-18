// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:tabletalk_mobile/models/profile_model.dart';
import 'package:tabletalk_mobile/providers/auth_provider.dart';
import 'package:tabletalk_mobile/services/user_profile_service.dart';
import 'package:tabletalk_mobile/widgets/custom_elevated_button.dart';
import 'package:tabletalk_mobile/widgets/custom_text_form_field.dart';
import 'package:country_list_pick/country_list_pick.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  bool _isLoading = true;
  late UserProfile userProfile;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _favoriteMealsController =
      TextEditingController();
  final TextEditingController _hateMealsController = TextEditingController();
  final TextEditingController _eatingHabitsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile().then((_) {
      setState(() => _isLoading = false);
    });
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user profile: ${e}')),
      );
    }
  }

  String getImageFromAuthProvider() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.credentials?.user.pictureUrl.toString() ?? '';
  }

  void _updateTextControllers() {
    _fullNameController.text = userProfile.fullName;
    _addressController.text = userProfile.address ?? '';
    _nationalityController.text = userProfile.nationality ?? '';
    _countryController.text = userProfile.country ?? '';
    _bioController.text = userProfile.bio ?? '';
    _favoriteMealsController.text = userProfile.favoriteMeals ?? '';
    _hateMealsController.text = userProfile.hateMeals ?? '';
    _eatingHabitsController.text = userProfile.eatingHabits.toString();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _nationalityController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    _favoriteMealsController.dispose();
    _hateMealsController.dispose();
    _eatingHabitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: Color(0xFFFD637C),
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: _isLoading ? _buildShimmerEffect() : _buildProfileScreen(),
        ),
      ),
    );
  }

  Widget _buildProfileScreen() {
    bool isProMember = userProfile.membership == "pro";

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(isProMember),
              const SizedBox(height: 20),
              if (isProMember)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildGradientIcon(),
                    const SizedBox(width: 4),
                    _buildProText(),
                    const SizedBox(width: 4),
                    _buildGradientIcon(),
                  ],
                ),
              if (!isProMember) _buildSubscribeButton(),
              const SizedBox(height: 20),
              _buildProfileField("Full Name", _fullNameController),
              _buildProfileField("Address", _addressController),
              _buildProfileField("Nationality", _nationalityController),
              _buildProfileField("Country", _countryController,
                  isDropList: true),
              _buildProfileField("Bio", _bioController),
              _buildProfileField("Favorite Meals", _favoriteMealsController),
              _buildProfileField("Hate Meals", _hateMealsController),
              _buildProfileField("Eating Habits", _eatingHabitsController,
                  isDropList: true),
              const SizedBox(height: 20),
              // Save/Edit and Logout Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_isEditing)
                    CustomElevatedButton(
                      height: 50,
                      width: 100,
                      text: "Cancel",
                      buttonTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                      buttonStyle: CustomButtonStyles.none,
                      decoration: CustomButtonStyles
                          .gradientPrimaryToOnPrimaryContainerDecoration,
                      onPressed: _cancelEdit,
                    ),
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
    );
  }

  Widget _buildShimmerEffect() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Container(
              height: 20,
              width: 200,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Container(
              height: 20,
              width: 150,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(bool isProMember) {
    return Stack(
      alignment: Alignment.center,
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
    );
  }

  Widget _buildProText() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color.fromARGB(255, 242, 7, 7),
          Color.fromARGB(255, 255, 120, 2)
        ],
      ).createShader(bounds),
      child: const Text(
        'PRO',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGradientIcon() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color.fromARGB(255, 242, 7, 7),
          Color.fromARGB(255, 255, 120, 2)
        ],
      ).createShader(bounds),
      child: const Icon(Icons.auto_awesome, color: Colors.white, size: 35),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller,
      {bool isDropList = false}) {
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
        if (!isDropList || !_isEditing)
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
            enabled: _isEditing,
          ),
        if (isDropList && _isEditing)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: label == "Country"
                    ? _buildCountryDropdown(controller)
                    : _buildEatingHabitsDropdown(controller),
              ),
            ],
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCountryDropdown(TextEditingController controller) {
    return CountryListPick(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Choose a country'),
      ),
      theme: CountryTheme(
        isShowFlag: true,
        isShowTitle: true,
        isShowCode: false,
        isDownIcon: true,
        showEnglishName: true,
      ),
      initialSelection: controller.text,
      onChanged: (CountryCode? code) {
        if (code != null) {
          controller.text = code.name!;
        }
      },
    );
  }

  Widget _buildEatingHabitsDropdown(TextEditingController controller) {
    return DropdownButton<String>(
      value: controller.text,
      items: List<DropdownMenuItem<String>>.generate(
        9,
        (index) => DropdownMenuItem(
          value: (index).toString(),
          child: Text((index).toString()),
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          controller.text = newValue!;
        });
      },
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
            colors: [
              Color.fromARGB(255, 242, 7, 7),
              Color.fromARGB(255, 255, 120, 2)
            ],
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
        country: _countryController.text,
        bio: _bioController.text,
        favoriteMeals: _favoriteMealsController.text,
        hateMeals: _hateMealsController.text,
        eatingHabits: _eatingHabitsController.text,
        membership: userProfile.membership,
        searchCount: userProfile.searchCount,
      );

      print(updatedProfile.country);
      print(updatedProfile.eatingHabits);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.credentials == null) {
        authProvider.loginAction(context);
        return;
      }
      final String accessToken = authProvider.credentials!.accessToken;

      UserProfileService userProfileService =
          UserProfileService(accessToken: accessToken);
      await userProfileService.updateProfile(userProfile.id, updatedProfile);

      setState(() {
        userProfile = updatedProfile;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user profile: $e');
      }
    } finally {
      setState(() {
        _isEditing = false;
      });
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

  void _cancelEdit() {
    setState(() {
      _updateTextControllers();
      _isEditing = false;
    });
  }
}
