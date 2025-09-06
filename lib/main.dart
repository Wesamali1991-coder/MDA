import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'analysis/strategies.dart';
import 'widgets/upload_panel.dart';

void main() {
  runApp(const MdaApp());
}

class MdaApp extends StatelessWidget {
  const MdaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnalysisModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MDA',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AnalysisModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('MDA')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('حمّل صورة الشارت، واختر نوع التحليل:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            const StrategyPicker(),
            const SizedBox(height: 12),
            UploadPanel(
              onImagePicked: (File? file) async {
                if (file == null) return;
                await model.analyzeChart(file);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    model.resultText.isEmpty
                        ? 'النتيجة ستظهر هنا بعد التحليل...'
                        : model.resultText,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final picker = ImagePicker();
          final image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            await model.analyzeChart(File(image.path));
          }
        },
        label: const Text('اختر صورة'),
        icon: const Icon(Icons.photo),
      ),
    );
  }
}

class StrategyPicker extends StatelessWidget {
  const StrategyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AnalysisModel>();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: Strategy.values.map((s) {
        final selected = model.strategy == s;
        return ChoiceChip(
          label: Text(strategyName(s)),
          selected: selected,
          onSelected: (_) => model.setStrategy(s),
        );
      }).toList(),
    );
  }
}
