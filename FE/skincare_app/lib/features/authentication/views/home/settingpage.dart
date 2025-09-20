import 'package:flutter/material.dart';
import 'package:skincare_app/features/authentication/views/home/changepasswordpage.dart';
import 'package:skincare_app/features/authentication/views/home/editprofilepage.dart';
import 'package:skincare_app/features/survey/testpage.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            /// --- Thông tin người dùng ---
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Color.fromARGB(255, 253, 249, 243),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(
                        "assets/images/user.png",
                      ), // ảnh đại diện
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nguyễn Văn A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "nguyenvana@gmail.com",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            /// --- Các tuỳ chọn ---
            Text(
              "Tài khoản",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Color.fromARGB(255, 253, 249, 243),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.blue),
                    title: Text("Đổi mật khẩu"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            /// --- Kết quả khảo sát ---
            Text(
              "Kết quả khảo sát",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    tileColor: Color.fromARGB(255, 253, 249, 243),
                    leading: Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.orange,
                    ),
                    title: Text("Khảo sát loại da"),
                    subtitle: Text("Da dầu • 12/08/2025"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // mở chi tiết kết quả khảo sát
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestingPage(isResultMode: true),
                        ),
                      );
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    tileColor: Color.fromARGB(255, 253, 249, 243),
                    leading: Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.orange,
                    ),
                    title: Text("Khảo sát tone da"),
                    subtitle: Text("Tone sáng • 20/08/2025"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestingPage(isResultMode: true),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            /// --- Đăng xuất ---
            ElevatedButton.icon(
              onPressed: () {
                // xử lý logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text(
                "Đăng xuất",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
