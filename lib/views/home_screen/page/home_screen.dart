import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../../../modals/quotes.dart';
import '../../../providers/quote_db_helper.dart';
import '../../../utils/colours.dart';
import '../../../utils/globals.dart';
import '../../previus_quote.dart';

List<Quotes> preQuoteList = [];

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.mood}) : super(key: key);

  String mood;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static bool data = true;
  late Future<List<Quotes>> res;
  List<Quotes> quotes = [];

  mySetState() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      quotes = await res;
      setState(() {});
      mySetState();
    });
  }

  initDatabase() async {
    await QuoteDatabaseHelper.quoteDatabaseHelper.deleteAllData();
    await QuoteDatabaseHelper.quoteDatabaseHelper
        .insertData(emotionList: emotionQuotes);
    res =
        QuoteDatabaseHelper.quoteDatabaseHelper.fetchAllData(mood: widget.mood);
  }

  deley10Sec() async {
    log(data.toString(), name: "data befour Function");
    if (data == true) {
      await Future.delayed(
        Duration(seconds: 11),
        () async {
          res = QuoteDatabaseHelper.quoteDatabaseHelper
              .fetchAllData(mood: widget.mood);
          quotes = await res;
          preQuoteList.add(quotes[0]);
          setState(() {});
          quotes = [];
          deley10Sec();
        },
      );
    } else {
      log(data.toString(), name: "data in else");
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
    mySetState();
    deley10Sec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          backgroundColor: gradient1,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "Q",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          data = true;
                          deley10Sec();
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:60),
                              child: Text(
                                'Quotes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 520,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: preQuoteList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(
                        'Previus ${i + 1}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        data = false;
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreviousQuotePage(
                                  mood: "${widget.mood}", index: i),
                            ));
                        setState(() {});

                        log(data.toString(), name: "data in LIstTile");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradient1,
              gradient2,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        "assets/images/drawer.png",
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "${widget.mood} Quotes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.restart_alt_outlined,
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 610,
                width: 320,
                child: (quotes.isEmpty && quotes.length < 15)
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 540,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 25, bottom: 25, right: 15, left: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      quotes[i].quote,
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.black,
                                        wordSpacing: 1,
                                        letterSpacing: 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
