import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'TasbeehCounterScreen.dart';  // Ensure this import is present

class DhikrScreen extends StatelessWidget {
  final List<Map<String, String>> dhikrList = [
    {'english': 'Subhanallah', 'arabic': 'سبحان الله'},
    {'english': 'Alhamdulillah', 'arabic': 'الحمد لله'},
    {'english': 'Allahu Akbar', 'arabic': 'الله أكبر'},
    {'english': 'Astaghfirullah', 'arabic': 'أستغفر الله'},
    {'english': 'La ilaha illallah', 'arabic': 'لا إله إلا الله'},
    {
      'english': 'La hawla wa la quwwata illa billah',
      'arabic': 'لا حول ولا قوة إلا بالله'
    },
    {
      'english': '''La ilaha illa-Allah, wahdahu la sharika lah, lahu-l-mulk, 
  wa lahu-l-hamd, wa huwa ‘ala kulli shay’in qadir''',
      'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ، وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ، وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dhikrs', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TasbeehCounterScreen()),
            );
          },
        ),
        backgroundColor: Color(0xFF833ab4), // Ensure a contrasting color for the AppBar
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE9E0E0), Color(0xFFEDE5CB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/dhikrim.jpg'),  // Replace with your actual image path
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dhikrList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dhikrList[index]['english']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              dhikrList[index]['arabic']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ArabicFont',  // Use a suitable Arabic font if necessary
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
