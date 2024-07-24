import 'package:flutter/material.dart';
import 'package:sima/controllers/dashboard/dashboard_controller.dart'; // Import your controller
import 'package:sima/models/dashboard/dashboard_model.dart';
import 'package:sima/models/dashboard/dashboard_param_model.dart';
import 'package:provider/provider.dart';

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
    print('Fetching data for filter: $_selectedFilter...');if (_selectedFilter == 'All') {
      _controller.param = DashboardPaginationParamModel(warehouseName: "All"); // Access param through _controller
    } else {
      _controller.param = DashboardPaginationParamModel(warehouseName: _selectedFilter.toLowerCase()); // Access param through _controller
    }
    await _controller.getDashboardItem(); // Use getDashboardItem for both cases
    setState(() {
      _dashboardItemData = _controller.dashboardItemData; // Update the state with fetched data
    });
    print('State updated with data: $_dashboardItemData');}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/WelcomeScreen');
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Mobina Sadat',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Bogor Warehouse',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report Stock',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedFilter, // Set the selected value
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Padding(padding: EdgeInsets.all(8.0)),
                                Icon(Icons.home),
                                Text('    Warehouse List'),
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
                    const SizedBox(height: 16),
                    if (_dashboardItemData == null) ...[
                      const Center(child: CircularProgressIndicator()) // Show loading indicator
                    ] else ...[
                      _buildStockItem(Icons.arrow_forward, 'Item', 'Item In', Colors.teal, _dashboardItemData!.itemIn),
                      _buildStockItem(Icons.warning, 'Item', 'Low Stock', Colors.orange, _dashboardItemData!.underMinQty),
                      _buildStockItem(Icons.arrow_back, 'Item', 'Item Out', Colors.red, _dashboardItemData!.itemOut),
                    ],
                  ],
                ),
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
                _buildFeatureItem(Icons.list, 'Daftar Barang', context, '/TransactionList'),
                _buildFeatureItem(Icons.map, 'Maps', context, '/Maps'),
                _buildFeatureItem(Icons.history, 'History', context, '/History'),
                _buildFeatureItem(Icons.save, 'Item', context, '/ItemListScreen'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockItem(IconData icon, String title, String subtitle, Color color, int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            '$itemCount $title',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
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
