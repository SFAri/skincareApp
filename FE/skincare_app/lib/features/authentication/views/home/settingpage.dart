import 'package:flutter/material.dart';
import 'package:skincare_app/core/utils/date_formater.dart';
import 'package:skincare_app/features/authentication/data/auth_repository.dart';
import 'package:skincare_app/features/authentication/models/user.dart';
import 'package:skincare_app/features/authentication/views/home/changepasswordpage.dart';
import 'package:skincare_app/features/authentication/views/home/editprofilepage.dart';
import 'package:skincare_app/features/authentication/views/login/login.dart';
import 'package:skincare_app/features/survey/views/testpage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final data = await AuthRepository().getMe();

    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
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
                            user!.name ?? "Not loaded yet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            user!.email,
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
              
              child: (user!.answers == null || user!.answers!.isEmpty) 
              ? const Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Center(
                  child: Text(
                    "Bạn chưa thực hiện khảo sát nào",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ) 
              
              : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user!.answers!.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final answer = user!.answers![index];

                  return ListTile(
                    tileColor: const Color.fromARGB(255, 253, 249, 243),
                    leading: const Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.orange,
                    ),
                    title: Text(answer.survey.title),
                    subtitle: Text(
                      "${answer.result.title} • ${formatDate(answer.createdAt)}",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestingPage(
                            // isResultMode: true,
                            surveyId: answer.survey.id,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 24),

            /// --- Đăng xuất ---
            ElevatedButton.icon(
              onPressed: () async {
                // xử lý logout
                final success = await AuthRepository().logout();
                if (success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logout failed")),
                  );
                }
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
