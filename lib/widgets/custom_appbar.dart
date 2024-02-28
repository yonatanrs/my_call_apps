import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Membuat Column mengambil ruang sesuai isinya
          children: [
            Text(
              'Lead Management',
              style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6,),
            Text(
              'Students are interested in your coaching! Get ',
              style: TextStyle(
                fontSize: 15.0, color: Colors.grey,
              ),
            ),
            Text(
              'back to them!',
              style: TextStyle(
                fontSize: 15.0, color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      toolbarHeight: preferredSize.height, // Tinggi AppBar menggunakan preferredSize
      backgroundColor: Colors.white, // Warna latar AppBar
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0); // Tinggi AppBar disesuaikan jika diperlukan
}
