import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CreatePage extends StatefulWidget {
  static String routName = 'create_page';
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();

  void _addArticle(String title, String detail) {
    _articles.add({'title': title, 'detail': detail});
    _titleController.clear();
    controller.clear();
  }

  CollectionReference _articles =
      FirebaseFirestore.instance.collection("articles");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "title"),
                ),
                SizedBox(
                  height: 22,
                ),
                HtmlEditor(
                  controller: controller,
                  htmlToolbarOptions:
                      HtmlToolbarOptions(toolbarType: ToolbarType.nativeGrid),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: ElevatedButton(
                    onPressed: () async {
                      String? title = _titleController.text;
                      String? txt = await controller.getText();
                      setState(() {
                        print("ini adalah title : $title dan ini desc : $txt");
                        _addArticle(title, txt);
                      });
                    },
                    child: Text("simpan data"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
