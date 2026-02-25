import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_ride/features/auth/screens/van_details_screen.dart';
import '../../../core/constants/app_colors.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  // To be replaced with a StreamBuilder from Firestore later
  final List<Map<String, dynamic>> _nearbyVans = [
    {
      "driverName": "Sunil Perera",
      "plate": "WP CAD-5566",
      "route": "Pannipitiya - Borella",
      "rating": 4.8,
      "availableSeats": 3,
    },
    {
      "driverName": "Aruna Silva",
      "plate": "WP LH-9900",
      "route": "Maharagama - Colpetty",
      "rating": 4.5,
      "availableSeats": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Find a Ride", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('vans').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text("Something went wrong"));
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final vans = snapshot.data!.docs;

                if (vans.isEmpty) {
                  return Center(
                    child: Text("No vans found on this route.", 
                    style: GoogleFonts.poppins(color: AppColors.secondary)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vans.length,
                  itemBuilder: (context, index) {
                    var vanData = vans[index].data() as Map<String, dynamic>;
                    var docId = vans[index].id;
                    return _buildVanCard(vanData, docId); // Pass the data and ID
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by School or Route...",
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildVanCard(Map<String, dynamic> van, String docId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                radius: 25,
                child: const Icon(Icons.person, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(van['driverName'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(van['route'], style: GoogleFonts.poppins(color: AppColors.secondary, fontSize: 13)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(" ${van['rating']}", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Text("${van['availableSeats']} seats left", style: GoogleFonts.poppins(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(van['plate'], style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppColors.secondary)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VanDetailsScreen(
                        vanData: van, // van is the map data from Firestore
                        vanId: docId, // docId is the document ID
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("View Details"),
              ),
            ],
          )
        ],
      ),
    );
  }
}