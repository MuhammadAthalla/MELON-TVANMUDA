import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
  final TextEditingController _controller = TextEditingController();

  void addItem() {
    setState(() {
      _total++;
      _controller.text = _total.toString();
    });
  }

  void removeItem() {
    setState(() {
      _total--;
      if (_total < 1) {
        _total = 1;
      }
      _controller.text = _total.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserRole();
    _controller.text = _total.toString();
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

  void launchWhatsApp({required String number, required String message}) async {
    String url = 'https://wa.me/$number?text=${Uri.encodeFull(message)}';
    await canLaunch(url) ? launch(url) : print("Tidak Bisa Membuka WhatsApp");
  }

  final Shader linear = const LinearGradient(
    colors: <Color>[Color(0x0ff20B263), Color(0x0ff78CC5A)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
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
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: _searchController.text.isEmpty
                  ? _articles.snapshots()
                  : _filteredNotesStream(_searchController.text.toLowerCase()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 370, right: 16, left: 16),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data!.docs[index];
                    return InkWell(
                        onTap: () {
                          showDialog(
                              barrierColor: Colors.white,
                              context: context,
                              builder: (context) => CardDialog(
                                  articleId: article.id,
                                  initialTitle: article['title']));
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: article['image'] != null
                                      ? Image.network(
                                          article['image'],
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        )
                                      : Container(),
                                ),
                                Text(
                                  article['title'],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    foreground: Paint()..shader = linear,
                                  ),
                                ),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    return HtmlWidget(
                                      article['detail'],
                                      customStylesBuilder: (element) {
                                        if (element.localName == 'p') {
                                          return {
                                            'max-lines': '3',
                                            'overflow': 'ellipsis',
                                          };
                                        }
                                        return null;
                                      },
                                      textStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      renderMode: RenderMode.column,
                                      customWidgetBuilder: (element) {
                                        if (element.localName == 'p') {
                                          return Text(
                                            element.text ?? '',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        }
                                        return null;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                );
              }),
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
                              children: [],
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

class CardDialog extends StatefulWidget {
  final String initialTitle;
  final String articleId;

  const CardDialog({
    Key? key,
    required this.initialTitle,
    required this.articleId,
  }) : super(key: key);

  @override
  State<CardDialog> createState() => _CardDialogState();
}

class _CardDialogState extends State<CardDialog> {
  late String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _getPhoneNumber();
    _controller.text = _total.toString();
  }

  Future<void> _getPhoneNumber() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists && userDoc.data()!.containsKey('phone')) {
        setState(() {
          _phoneNumber = userDoc.data()!['phone'];
        });
      }
    }
  }

  void launchWhatsApp({required String number, required String message}) async {
    String url = 'https://wa.me/$number?text=${Uri.encodeFull(message)}';
    await canLaunch(url) ? launch(url) : print("Tidak Bisa Membuka WhatsApp");
  }

  int _total = 1;
  final TextEditingController _controller = TextEditingController();

  @override
  void addItem() {
    setState(() {
      _total++;
      _controller.text = _total.toString();
    });
  }

  void removeItem() {
    setState(() {
      _total--;
      if (_total < 1) {
        _total = 1;
      }
      _controller.text = _total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    final Shader linear = const LinearGradient(
      colors: <Color>[Color(0xFF20B263), Color(0xFF78CC5A)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(0, 5),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.initialTitle,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  foreground: Paint()..shader = linear,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Jumlah yang ingin dibeli",
                style: GoogleFonts.poppins(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: removeItem,
                    icon: const Icon(Icons.remove),
                  ),
                  Container(
                    width: 50,
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '$_total',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _total = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: addItem,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78CC5A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      String message = "Halo, Sejahtera Seed,\n\n"
                          "Saya ingin memesan produk ${widget.initialTitle} yang tersedia di toko Anda.\n"
                          "Berikut adalah detail pesanan saya:\n"
                          "Nama Barang: ${widget.initialTitle}\n"
                          "Jumlah: $_total\n"
                          "Catatan Tambahan: _catatan tambahan_\n"
                          "Nama: _Nama Anda_\n"
                          "Alamat Pengiriman: _Alamat Pengiriman_\n"
                          "Nomor Telepon: _Nomor Telepon Penerima_\n\n"
                          "Mohon konfirmasikan total biaya dan estimasi waktu pengiriman. Terima kasih!";
                      launchWhatsApp(
                        number: _phoneNumber,
                        message: message,
                      );
                    },
                    child: Text(
                      "Belanja Sekarang",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Kembali",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
