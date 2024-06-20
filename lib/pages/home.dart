import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ujikomtvanmuda/pages/createPage.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/pages/editPage.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = 'home';

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  User? _user;
  bool _isAdmin = false;
  late Stream<QuerySnapshot> _stream;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection("articles").snapshots();
    _getUserRole();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isEmpty) {
          _stream =
              FirebaseFirestore.instance.collection("articles").snapshots();
        } else {
          _stream = _filteredNotesStream(_searchController.text.toLowerCase());
        }
      });
    });
  }

  Future<void> _getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _user = user;
          _isAdmin = userDoc.get('role') == 'admin';
        });
      }
    }
  }

  Future<void> _deleteArticle(String articleId) async {
    if (articleId.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection("articles")
            .doc(articleId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Artikel berhasil dihapus')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus artikel: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus artikel: ID artikel kosong')),
      );
    }
  }

  Stream<QuerySnapshot> _filteredNotesStream(String searchText) {
    print("Filtering articles with search text: $searchText");
    return FirebaseFirestore.instance
        .collection("articles")
        .where('title', isGreaterThanOrEqualTo: searchText)
        .where('title', isLessThanOrEqualTo: searchText + '\uf8ff')
        .snapshots();
  }

  void navigateToDetailScreen(String title, String detail, String? imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailScreen(title: title, detail: detail, imageUrl: imageUrl),
      ),
    );
  }

  Future<void> navigateToEditPage(
    String articleId,
    String initialTitle,
    String initialDetail,
    String? imageUrl,
  ) async {
    if (articleId.isNotEmpty &&
        initialTitle.isNotEmpty &&
        initialDetail.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPage(
            articleId: articleId,
            initialTitle: initialTitle,
            initialDetail: initialDetail,
            imageUrl: imageUrl,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Gagal mengedit artikel: Data artikel tidak lengkap')),
      );
    }
  }

  void _confirmDeleteArticle(String articleId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Hapus Artikel",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Apakah Anda yakin ingin menghapus artikel ini?",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Batal",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteArticle(articleId);
              },
              child: Text(
                "Hapus",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String greetingText = _isAdmin ? 'Halo Admin 👋' : 'Halo User 👋';
    final Shader linear = LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error loading data"));
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No data found"));
              }

              QuerySnapshot querySnapshot = snapshot.data!;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              List<Map<String, dynamic>> items = documents.map((e) {
                var data = e.data() as Map<String, dynamic>;
                data['id'] = e.id; // Tambahkan ID dokumen ke dalam data
                return data;
              }).toList();

              print("Loaded ${items.length} articles");

              return ListView.builder(
                padding: const EdgeInsets.only(top: 370, right: 16, left: 16),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> thisItem = items[index];
                  String articleId = thisItem['id'] ?? '';
                  String title = thisItem['title'] ?? '';
                  String detail = thisItem['detail'] ?? '';
                  String? imageUrl = thisItem['image'];

                  if (articleId.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return GestureDetector(
                    onTap: () {
                      navigateToDetailScreen(title, detail, imageUrl);
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Container(
                          height: 80,
                          width: 80,
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                )
                              : Container(),
                        ),
                        title: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            foreground: Paint()..shader = linear,
                          ),
                        ),
                        subtitle: Text(
                          "Baca Artikel selengkapnya...",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        trailing: _isAdmin
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      navigateToEditPage(
                                          articleId, title, detail, imageUrl);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    onPressed: () {
                                      _confirmDeleteArticle(articleId);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              gradient: LinearGradient(
                colors: [Color(0xFF20B263), Color(0x0ff78CC5A)],
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 185, left: 40, right: 40),
              child: CupertinoSearchTextField(
                itemColor: Colors.black,
                backgroundColor: Colors.white,
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    // Pencarian akan diperbarui otomatis oleh listener
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greetingText,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Mau belajar apa hari ini",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (_isAdmin)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, CreatePage.routeName);
                          },
                          child: Text("+"),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
