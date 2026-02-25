import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_ride/features/auth/screens/driver_home.dart';
import 'package:school_ride/features/auth/screens/parent_home.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  String? _selectedRole; // Values: 'PARENT', 'DRIVER'
  bool _isLoading = false;

  void _completeRegistration() async {
    if (_nameController.text.isEmpty || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter name and select a role")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Call our Service
    // Note: In real app, get actual UID from FirebaseAuth.currentUser.uid
    await AuthService().createUserProfile(
      uid: "test_uid_123", 
      name: _nameController.text,
      role: _selectedRole!,
    );

    setState(() => _isLoading = false);
    
    // Navigate to driver home
    if (_selectedRole == 'DRIVER') {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DriverHomeScreen()),
      (route) => false, // Clears the navigation stack so user can't go back to registration
    );
  } else {
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const ParentHomeScreen()),
    (route) => false,
  );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textMain),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Profile",
                style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Tell us about yourself.",
                style: GoogleFonts.poppins(fontSize: 16, color: AppColors.secondary),
              ),
              const SizedBox(height: 32),

              // Name Input
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                "I am a...",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              // Role Selection Cards
              Row(
                children: [
                  Expanded(
                    child: _buildRoleCard(
                      label: "Parent",
                      icon: Icons.family_restroom,
                      value: "PARENT",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildRoleCard(
                      label: "Driver",
                      icon: Icons.directions_bus,
                      value: "DRIVER",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _isLoading ? null : _completeRegistration,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Complete Setup", style: GoogleFonts.poppins(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for Role Cards
  Widget _buildRoleCard({required String label, required IconData icon, required String value}) {
    final isSelected = _selectedRole == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = value),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isSelected ? AppColors.primary : AppColors.secondary),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}