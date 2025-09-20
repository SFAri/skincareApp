import 'package:flutter/material.dart';

class TestingPage extends StatefulWidget {
  final bool isResultMode;
  const TestingPage({super.key, this.isResultMode = false});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  late bool isResultMode;
  // Giả sử đây là dữ liệu mẫu (sau này bạn lấy từ DB)
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Loại da của bạn thường là?',
      'options': ['Da dầu', 'Da khô', 'Da hỗn hợp', 'Da nhạy cảm'],
      'answer': null,
    },
    {
      'question': 'Bạn thường cảm thấy da mình?',
      'options': ['Căng khô', 'Bóng nhờn', 'Bình thường'],
      'answer': null,
    },
    {
      'question': 'Bạn thường cảm thấy da mình?',
      'options': ['Căng khô', 'Bóng nhờn', 'Bình thường'],
      'answer': null,
    },
    {
      'question': 'Bạn thường cảm thấy da mình?',
      'options': ['Căng khô', 'Bóng nhờn', 'Bình thường'],
      'answer': null,
    },
    {
      'question': 'Bạn thường cảm thấy da mình?',
      'options': ['Căng khô', 'Bóng nhờn', 'Bình thường'],
      'answer': null,
    },
    {
      'question': 'Bạn thường cảm thấy da mình?',
      'options': ['Căng khô', 'Bóng nhờn', 'Bình thường'],
      'answer': null,
    },
    {
      'question': 'Bạn thường cảm thấy da mình?',
      'options': ['Căng khô', 'Bóng nhờn', 'Bình thường'],
      'answer': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    isResultMode = widget.isResultMode; // lấy giá trị được truyền
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skin survey')),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Khảo sát loại da",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Hiển thị câu hỏi
            ...questions.asMap().entries.map((entry) {
              int index = entry.key;
              var q = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}. ${q['question']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ...q['options'].map<Widget>((opt) {
                    return RadioListTile(
                      title: Text(opt),
                      value: opt,
                      groupValue: q['answer'],
                      onChanged: (value) {
                        setState(() {
                          q['answer'] = value;
                        });
                      },
                    );
                  }).toList(),

                  const Divider(),
                ],
              );
            }),

            const SizedBox(height: 20),
            if (!isResultMode)
              ElevatedButton(
                onPressed: () {
                  // In ra đáp án (hoặc lưu DB)
                  print(questions.map((q) => q['answer']).toList());
                },
                child: const Text("Finish"),
              ),
            if (isResultMode)
              SizedBox(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, size: 50, color: Colors.green),
                    Text(
                      'Result: ' + 'Da dầu',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
