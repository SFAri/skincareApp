import 'package:flutter/material.dart';
import 'package:skincare_app/features/survey/data/repository/survey_repo.dart';
import 'package:skincare_app/features/survey/models/survey.dart';
import 'package:skincare_app/features/survey/models/survey_result.dart';

class TestingPage extends StatefulWidget {
  // bool? isResultMode;
  final String? answerId;
  final String surveyId;
  const TestingPage({
    super.key,
    this.answerId,
    required this.surveyId,
  });

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  late bool isResultMode;
  bool isLoading = true;
  bool isSubmitting = false;
  late Survey survey;
  late SurveyResult result;

  Map<String, String> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    openSurvey();
  }

  Future<void> openSurvey() async {
    final res = await SurveyRepository().getSurvey(widget.surveyId);
    if (res.mode == "result") {
      final answer = res.answer!;

      Map<String, String> map = {};

      for (var item in answer.selectedOptions) {
        final questionId = item.option!.questionId;
        final optionId = item.option!.id;

        map[questionId] = optionId;
      }

      setState(() {
        survey = answer.survey;
        result = answer.result;
        selectedOptions = map;
        isResultMode = true;
        isLoading = false;
      });
    } else {
      print("IN SURVEY MODE");
      final surveyData = res.survey;
      if (surveyData == null) {
        throw Exception("Survey is null");
      }
      setState(() {
        survey = surveyData;
        isResultMode = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text('Skin survey')),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              survey.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Hiển thị câu hỏi
            ...survey.questions.map((q) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    q.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ...q.options.map<Widget>((opt) {
                    return RadioListTile<String>(
                      title: Text(opt.option),
                      value: opt.id,
                      groupValue: selectedOptions[q.id],
                      onChanged: isResultMode
                          ? null
                          : (value) {
                              setState(() {
                                selectedOptions[q.id] = value!;
                              });
                            },
                    );
                  }),

                  const Divider(),
                ],
              );
            }).toList(),

            const SizedBox(height: 20),
            if (!isResultMode)
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                        // 🔥 validate đủ câu hỏi
                        if (selectedOptions.length < survey.questions.length) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please answer all questions"),
                            ),
                          );
                          return;
                        }

                        setState(() => isSubmitting = true);

                        try {
                          final res = await SurveyRepository().submitSurvey(
                            surveyId: widget.surveyId,
                            answers: selectedOptions,
                          );

                          if (!mounted) return;

                          if (res != null) {
                            setState(() {
                              result = res;
                              isResultMode = true;
                            });
                          }
                        } catch (e) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        } finally {
                          if (mounted) {
                            setState(() => isSubmitting = false);
                          }
                        }
                      },
                child: isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Finish"),
              ),
            if (isResultMode)
              SizedBox(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, size: 50, color: Colors.green),
                    Text(
                      "Result: ${result.title}",
                      style: const TextStyle(fontSize: 22),
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
