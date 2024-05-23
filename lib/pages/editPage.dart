import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:html_editor_enhanced/html_editor.dart';

class EditPage extends StatefulWidget {
  final String articleId;
  final String initialTitle;
  final String initialDetail;


  const EditPage({
    Key? key,
    required this.articleId,
    required this.initialTitle,
    required this.initialDetail,
  }) : super(key: key);

  static const routeName = 'editPage';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _titleController = TextEditingController();
  final HtmlEditorController _htmlEditorController = HtmlEditorController();
  final CollectionReference _articles =
      FirebaseFirestore.instance.collection('articles');

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _htmlEditorController.setText(widget.initialDetail);
    });
  }

  void _updateArticle() async {
    String? updatedDetail = await _htmlEditorController.getText();
    if (updatedDetail != null && updatedDetail.isNotEmpty) {
      _articles.doc(widget.articleId).update({
        'title': _titleController.text,
        'detail': updatedDetail,
      }).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        // Handle error if update fails
        print("Failed to update article: $error");
      });
    } else {
      print("Failed to get updated detail from HtmlEditor");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Artikel',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            foreground: Paint()..shader = linear,
          ),
        ),
        backgroundColor: const Color(0xFF20B263),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: null,
              controller: _titleController,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x0ff20B263)),
                ),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linear,
                ),
                labelText: 'Edit Judul',
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: HtmlEditor(
                controller: _htmlEditorController,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Edit Artikel",
                  initialText: widget.initialDetail,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateArticle,
              child: Text(
                'Perbarui',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linear,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF20B263),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
