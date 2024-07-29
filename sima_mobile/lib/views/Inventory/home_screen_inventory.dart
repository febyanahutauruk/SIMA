import 'package:flutter/material.dart';
import 'package:sima/controllers/dashboard/dashboard_controller.dart'; // Import your controller
import 'package:sima/models/dashboard/dashboard_model.dart';
import 'package:sima/models/dashboard/dashboard_param_model.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenInventory extends StatefulWidget {
  const HomeScreenInventory({super.key});
  State<HomeScreenInventory> createState() => _HomeScreenInventoryState();
}

class _HomeScreenInventoryState extends State<HomeScreenInventory> {
  late DashboardItemController _controller;
  DashboardItemData? _dashboardItemData;
  String _selectedFilter = 'All'; // Default value

  @override
  void initState() {
    super.initState();
    _controller = Provider.of<DashboardItemController>(context, listen: false);
    _fetchData(); // Fetch data when the widget initializes
  }

  Future<void> _fetchData() async {
    print('Fetching data for filter: $_selectedFilter...');
    if (_selectedFilter == 'All') {
      _controller.param = DashboardPaginationParamModel(warehouseName: "All"); // Access param through _controller
    } else {
      _controller.param = DashboardPaginationParamModel(warehouseName: _selectedFilter.toLowerCase()); // Access param through _controller
    }
    await _controller.getDashboardItem(); // Use getDashboardItem for both cases
    setState(() {
      _dashboardItemData = _controller.dashboardItemData; // Update the state with fetched data
    });
    print('State updated with data: $_dashboardItemData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.teal,),
          onPressed: () {
            Navigator.pushNamed(context, '/WelcomeScreen');
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color:Colors.teal),
                  ),
                  Text(
                    'Mobina Sadat',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Pertaminta Trans Kontinental',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report Stock',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.blueGrey.shade50,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedFilter, // Set the selected value
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(padding: EdgeInsets.all(8.0)),
                                Icon(Icons.home),
                                Text('    Warehouse List', style: GoogleFonts.poppins(color: Colors.black),),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedFilter = newValue; // Update the selected value
                                _fetchData(); // Fetch data for the new selection
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: Colors.white,
                          items: <String>['All', 'Gedung Barat', 'Gudang Timur']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_dashboardItemData == null) ...[
                    const Center(child: CircularProgressIndicator()) // Show loading indicator
                  ] else ...[
                    _buildStockItem(Icons.arrow_forward_outlined, 'Item', 'Item In', Colors.teal, _dashboardItemData!.itemIn),
                    _buildStockItem(Icons.warning_rounded, 'Item', 'Low Stock', Colors.orange, _dashboardItemData!.underMinQty),
                    _buildStockItem(Icons.arrow_back_rounded, 'Item', 'Item Out', Colors.red, _dashboardItemData!.itemOut),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Spacer(),
            const Text(
              'Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureItem(Icons.warehouse_rounded, 'Transaction', context, '/TransactionList'),
                _buildFeatureItem(Icons.map_rounded, 'Maps', context, '/Maps'),
                _buildFeatureItem(Icons.history_rounded, 'History', context, '/History'),
                _buildFeatureItem(Icons.save_rounded, 'Item', context, '/ItemListScreen'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockItem(IconData icon, String title, String subtitle, Color color, int itemCount) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Increase the border radius for more rounded corners
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(15.0), // Ensure the container also has rounded corners
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            '$itemCount $title',
            style: GoogleFonts.poppins(color: color, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle, style: GoogleFonts.poppins(color: Colors.black),),
        ),
      ),
    );
  }


  Widget _buildFeatureItem(IconData icon, String label, BuildContext context, String routename) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routename);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
