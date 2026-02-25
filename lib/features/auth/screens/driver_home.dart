import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  // Temporary list to simulate data from Firestore
  final List<Map<String, dynamic>> _myVans = [
    {
      "plate": "WP CAS-1234",
      "model": "Toyota Hiace KDH",
      "route": "Kottawa - Colombo 07",
      "passengers": 12,
      "capacity": 15
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("My Vans", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: AppColors.textMain)),
        ],
      ),
      body: _myVans.isEmpty ? _buildEmptyState() : _buildVanList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Add Van Screen
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text("Register Van", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_bus_outlined, size: 80, color: AppColors.secondary.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text("No vans registered yet", style: GoogleFonts.poppins(fontSize: 18, color: AppColors.secondary)),
        ],
      ),
    );
  }

  Widget _buildVanList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myVans.length,
      itemBuilder: (context, index) {
        final van = _myVans[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: InkWell(
            onTap: () {
              // TODO: Navigate to Van Details
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(van['plate'], style: GoogleFonts.poppins(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.people, size: 18, color: AppColors.secondary),
                          const SizedBox(width: 4),
                          Text("${van['passengers']}/${van['capacity']}", style: GoogleFonts.poppins(color: AppColors.secondary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(van['model'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textMain)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.route, size: 16, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(van['route'], style: GoogleFonts.poppins(color: AppColors.secondary)),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {}, child: const Text("View Students")),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        child: const Text("Start Trip"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}