import 'package:flutter/material.dart';
import '../widgets/theme_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Chế độ tối'),
            trailing: ThemeSwitch(),
          ),
          ListTile(
            title: const Text('Ngôn ngữ'),
            trailing: DropdownButton<String>(
              value: 'Tiếng Việt',
              onChanged: (String? newValue) {
                // Xử lý thay đổi ngôn ngữ nếu cần
              },
              items: <String>['Tiếng Việt', 'English']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Về ứng dụng'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Xử lý khi nhấn vào mục này nếu cần
            },
          ),
        ],
      ),
    );
  }
}
