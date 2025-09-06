import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPanel extends StatefulWidget {
  final Future<void> Function(File? file) onImagePicked;
  const UploadPanel({super.key, required this.onImagePicked});

  @override
  State<UploadPanel> createState() => _UploadPanelState();
}

class _UploadPanelState extends State<UploadPanel> {
  File? _selected;

  Future<void> _pick() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.image);
    if (res != null && res.files.single.path != null) {
      setState(() { _selected = File(res.files.single.path!); });
      await widget.onImagePicked(_selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _selected == null
                  ? 'لم يتم اختيار صورة بعد.'
                  : 'تم اختيار: ${_selected!.path.split(Platform.pathSeparator).last}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: _pick,
            icon: const Icon(Icons.upload),
            label: const Text('اختر صورة'),
          ),
        ],
      ),
    );
  }
}
