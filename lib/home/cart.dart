import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ujikomtvanmuda/home/cart.dart';
import 'package:ujikomtvanmuda/home/dashboard.dart';
import 'package:ujikomtvanmuda/home/profile.dart';
import 'package:ujikomtvanmuda/pages/createPage.dart';
import 'package:ujikomtvanmuda/pages/detailscreen.dart';
import 'package:ujikomtvanmuda/pages/editPage.dart';
import 'package:ujikomtvanmuda/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const routeName = 'home';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late User? _user;
  bool _isAdmin = false;
  int _total = 0;

  void AddItem() {
    setState(() {
      _total++;
    });
  }

  void Removeitem() {
    setState(() {
      _total--;
    });
  }

  void initState() {
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
  TextEditingController _searchController = TextEditingController();
  CollectionReference _articles =
      FirebaseFirestore.instance.collection("articles");

  void _deleteArticle(String articleId) {
    _articles.doc(articleId).delete();
  }

  Stream<QuerySnapshot> _filteredNotesStream(String searchText) {
    return _articles
        .where('title', isGreaterThanOrEqualTo: searchText)
        .where('title', isLessThanOrEqualTo: searchText + '\uf8ff')
        .snapshots();
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: _searchController.text.isEmpty
                      ? _articles.snapshots()
                      : _filteredNotesStream(
                          _searchController.text.toLowerCase()),
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
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                    articleId: article.id,
                                    initialTitle: article['title']));
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
                              trailing: _isAdmin
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPage(
                                                  articleId: article.id,
                                                  initialTitle:
                                                      article['title'],
                                                  initialDetail:
                                                      article['detail'],
                                                ),
                                              ),
                                            );
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
                                  : const SizedBox(), // Jika bukan admin, tampilkan widget kosong
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
              padding: const EdgeInsets.only(top: 185, left: 40, right: 40),
              child: CupertinoSearchTextField(
                itemColor: Colors.black,
                backgroundColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _searchController.text = value;
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                  ),
                                  child: Row(
                                    // Use a Row for horizontal layout
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Align icons
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Tambah\nData",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              foreground: Paint()
                                                ..shader = linear),
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
                                                Navigator.pushNamed(context,
                                                    EditPage.routeName);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 35,
                                              ))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String initialTitle;
  final String articleId;

  const CustomDialog({
    Key? key,
    required this.initialTitle,
    required this.articleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      child: Stack(
        children: [
          CardDialog(
            initialTitle: initialTitle,
            articleId: articleId,
          ),
          Positioned(
            right: 0,
            top: 0,
            height: 35,
            width: 35,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
              child: Image.asset('assets/svg/cancel.svg'),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatefulWidget {
  final String initialTitle;
  final String articleId;
  const CardDialog({
    super.key,
    required this.initialTitle,
    required this.articleId,
  });

  @override
  State<CardDialog> createState() => _CardDialogState();
}

class _CardDialogState extends State<CardDialog> {
  void launchWhatsApp({required number, required message}) async {
    String url = 'https://wa.me/$number?text=$message';
    await canLaunch(url) ? launch(url) : print("Tidak Bisa Membuka WhatsApp");
  }

  // CollectionReference _articles =
  //     FirebaseFirestore.instance.collection("articles");
  // final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _titleController.text = widget.initialTitle;
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  int _total = 0;

  void AddItem() {
    setState(() {
      _total++;
    });
  }

  void Removeitem() {
    setState(() {
      _total--;
      if (_total < 1) {
        _total = 1;
      }
    });
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.initialTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text("jumlah yang ingin di beli"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Removeitem();
                },
                icon: Icon(
                  Icons.remove,
                )),
            Text('$_total'),
            IconButton(
                onPressed: () {
                  AddItem();
                },
                icon: Icon(Icons.add))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x0ff78CC5A)),
                onPressed: () {},
                child: Text("Masukan Keranjang",
                    style: GoogleFonts.poppins(color: Colors.white))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x0ff78CC5A)),
                onPressed: () {
                  launchWhatsApp(
                      number: "+6282117229009",
                      message:
                          "Nama Melon :  ${widget.initialTitle}\nJumlah Pesanan : $_total ");
                },
                child: Text(
                  "Belanja Sekarang",
                  style: GoogleFonts.poppins(color: Colors.white),
                )),
          ],
        )
      ],
    );
  }
}
