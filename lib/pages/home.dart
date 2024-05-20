import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujikomtvanmuda/home/cart.dart';
import 'package:ujikomtvanmuda/home/dashboard.dart';
import 'package:ujikomtvanmuda/home/profile.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/theme.dart';

List<IconData> navIcon = [Icons.home, Icons.carpenter, Icons.people];

List<String> navTitle = ["Home", "Cart", "Profile"];

List<Widget> screens = [DashBoardPage(), CartPage(), ProfilePage()];

int selectedIndex = 0;

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = 'home';

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  late User? _user;
  bool _isAdmin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserRole();
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

  final Shader linear = const LinearGradient(
    colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  CollectionReference _articles =
      FirebaseFirestore.instance.collection("articles");

  void _addArticle() {
    _articles.add(
        {'title': _titleController.text, 'detail': _detailController.text});
  }

  void _deleteArticle(String articleId) {
    _articles.doc(articleId).delete();
  }

  void _editArticle(DocumentSnapshot article) {
    _titleController.text = article['title'];
    _detailController.text = article['detail'];

    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                AlertDialog(
                  title: Text(
                    "Edit Artikel",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        foreground: Paint()..shader = linear),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        maxLines: null,
                        controller: _titleController,
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0x0ff20B263))),
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linear),
                            labelText: 'Edit Judul'),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        maxLines: null,
                        controller: _detailController,
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0x0ff20B263))),
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linear),
                            labelText: 'Edit Artikel'),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Batal",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linear),
                        )),
                    TextButton(
                        onPressed: () {
                          _updateArticle(article.id);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Perbarui",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linear),
                        ))
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _updateArticle(String userId) {
    _articles.doc(userId).update(
        {'title': _titleController.text, 'detail': _detailController.text});

    _titleController.clear();
    _detailController.clear();
  }

  void navigateToDetailScreen(String title, String detail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(title: title, detail: detail),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String greetingText = _isAdmin ? 'Halo Admin 👋' : 'Halo User 👋';

    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: _articles.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 370, right: 16, left: 16),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var article = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {
                            navigateToDetailScreen(
                                article['title'], article['detail']);
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                article['title'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  foreground: Paint()..shader = linear,
                                ),
                              ),
                              subtitle: Text(
                                article['detail'],
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
                                            _editArticle(article);
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        const SizedBox(width: 4),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Konfirmasi",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                    "Apakah Anda yakin ingin menghapus artikel ini?",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Batal",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _deleteArticle(
                                                            article.id);
                                                      },
                                                      child: Text(
                                                        "Hapus",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    )
                                  : SizedBox(), // Jika bukan admin, tampilkan widget kosong
                            ),
                          ),
                        );
                      },
                    );
                  })),
          Container(
            height: height / 2.5,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
                gradient: LinearGradient(
                    colors: [Color(0xFF20B263), Color(0x0ff78CC5A)])),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 185, left: 66),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 32.0,
                          offset: const Offset(4.0, 4.0))
                    ]),
                width: width / 1.5,
                height: height / 6,
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
                          color: Colors.white),
                    ),
                    Text(
                      "Mau belajar apa hari ini",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (_isAdmin)
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 138,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2.0,
                                    blurRadius: 32.0,
                                    offset: const Offset(4.0, 4.0),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Row(
                                // Use a Row for horizontal layout
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Align icons
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Tambah\nData",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          foreground: Paint()..shader = linear),
                                    ),
                                  ),
                                  ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) =>
                                          const RadialGradient(
                                              center: Alignment.topCenter,
                                              stops: [
                                                .5,
                                                1
                                              ],
                                              colors: [
                                                Color(0xFF20B263),
                                                Color(0x0ff78CC5A)
                                              ]).createShader(bounds),
                                      child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Center(
                                                      child: Text(
                                                        'Tambah Data',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 24,
                                                                foreground:
                                                                    Paint()
                                                                      ..shader =
                                                                          linear),
                                                      ),
                                                    ),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          const SizedBox(
                                                              height: 20),
                                                          TextFormField(
                                                            maxLines: null,
                                                            controller:
                                                                _titleController,
                                                            decoration: InputDecoration(
                                                                enabledBorder: const UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey)),
                                                                focusedBorder: const UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0x0ff20B263))),
                                                                labelStyle: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    foreground: Paint()
                                                                      ..shader =
                                                                          linear),
                                                                labelText:
                                                                    'Masukkan Judul'),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          TextFormField(
                                                            maxLines: null,
                                                            controller:
                                                                _detailController,
                                                            decoration: InputDecoration(
                                                                enabledBorder: const UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .grey)),
                                                                focusedBorder: const UnderlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Color(
                                                                            0x0ff20B263))),
                                                                labelStyle: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    foreground: Paint()
                                                                      ..shader =
                                                                          linear),
                                                                labelText:
                                                                    'Masukkan Artikel'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'Batal',
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  foreground: Paint()
                                                                    ..shader =
                                                                        linear),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              _addArticle();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              'Tambah',
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  foreground: Paint()
                                                                    ..shader =
                                                                        linear),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            size: 35,
                                          )))
                                ],
                              ),
                            ),
                          ],
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
