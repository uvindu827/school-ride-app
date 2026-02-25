import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class VanDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> vanData;
  final String vanId;

  const VanDetailsScreen({super.key, required this.vanData, required this.vanId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vanData['modelName'])),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: AppColors.primary,
            child: Column(
              children: [
                const Icon(Icons.directions_bus, size: 80, color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  vanData['licensePlate'],
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // Info List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _infoTile(Icons.route, "Route", vanData['routeName']),
                _infoTile(Icons.event_seat, "Capacity", "${vanData['capacity']} Seats Total"),
                _infoTile(Icons.person, "Driver ID", vanData['driverId']), // Later we will fetch driver name
                const SizedBox(height: 40),
                
                // Request Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => _showRequestDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Request for my Child"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: GoogleFonts.poppins(fontSize: 14, color: AppColors.secondary)),
      subtitle: Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textMain)),
    );
  }

  void _showRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Request"),
        content: const Text("Do you want to send a seat request to this driver?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              // TODO: Logic to create a 'requests' collection in Firestore
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Sent!")));
            }, 
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}