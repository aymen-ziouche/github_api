import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_storage/get_storage.dart';
import 'package:github_api/screens/repospage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0D1117),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "GitGram",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset("assets/Octocat.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter the username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  controller: myController,
                  onSubmitted: (value) async {
                    final storage = GetStorage();
                    await Future.wait([
                      storage.write("username", myController.text),
                    ]);
                    Navigator.pushNamed(
                      context,
                      ReposPage.id,
                    );
                    myController.clear();
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: const TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.green,
                      size: 30,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20)),
                      depth: 8,
                      lightSource: LightSource.topLeft,
                      shadowLightColor: Colors.green,
                      color: Colors.green),
                  child: TextButton(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Text(
                        'Fetch data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      final storage = GetStorage();
                      await Future.wait([
                        storage.write("username", myController.text),
                      ]);
                      Navigator.pushNamed(
                        context,
                        ReposPage.id,
                      );
                      myController.clear();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
