import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmath/models/modelKelas.dart';
import 'package:smartmath/models/modelMateri.dart';
import 'package:smartmath/pages/DetailPage.dart';
import 'package:smartmath/pages/info.dart';
import 'package:smartmath/pages/kategorilatihan.dart';
import 'package:http/http.dart' as http;
import 'package:smartmath/utils/session_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _PageBottomBarState();
}

class _PageBottomBarState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomePage(),
          KategoriLatihan(),
          Info(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20), bottom: Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TabBar(
            isScrollable: true,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.home_outlined),
              ),
              Tab(
                icon: Icon(Icons.school),
              ),
              Tab(
                icon: Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Datum> classData = [];
  List<MateriDatum> materiData = [];
  List<MateriDatum> filteredMateriData = [];
  int? selectedClassIndex;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sessionManager.getSession().then((_) {
      setState(() {}); // Update UI once data is loaded
    });
    fetchKelas(); // Fetch classes when the page first loads after login
    searchController.addListener(_filterMateriData);
  }

  Future<void> fetchKelas() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.101/smartmath_server/kelas.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final modelKelas = ModelKelas.fromJson(data);

        setState(() {
          classData = modelKelas.data;
          // Fetch all materials by default after fetching classes
          fetchMateri();
        });
      } else {
        throw Exception('Failed to load classes');
      }
    } catch (e) {
      print('Error fetching classes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching classes')),
      );
    }
  }

  Future<void> fetchMateri({String? idKelas}) async {
    try {
      String url = idKelas == null
          ? 'http://192.168.0.101/smartmath_server/materi.php'
          : 'http://192.168.0.101/smartmath_server/materi.php?id_kelas=$idKelas';
      print('Fetching materials from URL: $url'); // Debug log
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final modelMateri = ModelMateri.fromJson(data);

        setState(() {
          materiData = modelMateri.data;
          _filterMateriData(); // Initial filtering based on selectedClassIndex
        });
      } else {
        throw Exception('Failed to load materials');
      }
    } catch (e) {
      print('Error fetching materials: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching materials')),
      );
    }
  }

  void _onClassButtonPressed(int? index) {
    setState(() {
      selectedClassIndex = index;
      // Filter materiData based on selectedClassIndex
      _filterMateriData();
    });
  }

  void _filterMateriData() {
    setState(() {
      String searchQuery = searchController.text.toLowerCase();

      if (selectedClassIndex == null) {
        // Filter berdasarkan pencarian jika tidak ada kelas yang dipilih
        filteredMateriData = materiData
            .where((materi) =>
        materi.title.toLowerCase().contains(searchQuery) ||
            materi.content.toLowerCase().contains(searchQuery))
            .toList();
      } else {
        // Filter berdasarkan kelas dan pencarian
        Datum selectedClass = classData[selectedClassIndex!];
        filteredMateriData = materiData
            .where((materi) =>
        materi.id_kelas == selectedClass.idKelas &&
            (materi.title.toLowerCase().contains(searchQuery) ||
                materi.content.toLowerCase().contains(searchQuery)))
            .toList();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'SmartMath',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green[800]),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${sessionManager.fullname}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'What do you want to learn?',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search Data",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(5, 107, 15, 0.86),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Course',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildClassButton('All', null),
                      ...classData
                          .asMap()
                          .entries
                          .map((entry) => _buildClassButton(
                          entry.value.namaKelas, entry.key))
                          .toList(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildMateriList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClassButton(String text, int? index) {
    bool isSelected = selectedClassIndex == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () => _onClassButtonPressed(index),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget buildMateriList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredMateriData.length,
      itemBuilder: (context, index) {
        final materi = filteredMateriData[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(materi: materi),
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Icon(Icons.book, size: 30, color: Colors.green),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          materi.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          materi.content,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            SizedBox(width: 5),
                            Text(
                              '5.0', // Placeholder for rating
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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