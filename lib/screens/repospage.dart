import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:github_api/models/repo.dart';

class ReposPage extends StatefulWidget {
  const ReposPage({Key? key}) : super(key: key);
  static String id = "ReposPage";

  @override
  State<ReposPage> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  @override
  void initState() {
    final storage = GetStorage();
    final username = storage.read("username");
    getData(username);
  }

  bool loading = true;
  bool error = false;
  List<Repo> repo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : error
                    ? const Center(
                        child: Text('An error has occurred!'),
                      )
                    : ListView.builder(
                        itemCount: repo.length,
                        itemBuilder: (context, index) => TimelineTile(
                          isFirst: index == 0 ? true : false,
                          isLast: index == repo.length - 1 ? true : false,
                          indicatorStyle:
                              IndicatorStyle(color: Colors.greenAccent),
                          afterLineStyle: LineStyle(
                            color: Color.fromARGB(255, 56, 158, 109),
                          ),
                          beforeLineStyle: LineStyle(
                            color: Color.fromARGB(255, 56, 158, 109),
                          ),
                          endChild: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              repo[index].name.toUpperCase(),
                                              maxLines: 1,
                                              softWrap: false,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF414C6B),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "repo ID ${repo[index].id}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF414C6B),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              repo[index].description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF414C6B),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () => _launchURL(
                                                  repo[index].svnUrl),
                                              child: Text(
                                                repo[index].svnUrl,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF414C6B),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Future<void> getData(username) async {
    try {
      final dio = Dio();
      var response =
          await dio.get("https://api.github.com/users/" + username + "/repos");
      if (response.statusCode.toString().startsWith('2')) {
        setState(() {
          loading = false;
          repo = (response.data as List)
              .map((data) => Repo.fromMap(data))
              .toList();
        });
      }
    } catch (e) {
      setState(() {
        error = true;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  _launchURL(url) async {
    Uri newurl = Uri.parse(url);
    if (await canLaunchUrl(newurl)) {
      await launchUrl(newurl);
    } else {
      throw 'Could not launch $url';
    }
  }
}






// ListView.builder(
//                         itemCount: repo.length,
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           return repo[index].svnUrl != ""
//                               ? Stack(
//                                   children: [
//                                     Column(
//                                       children: [
//                                         SizedBox(
//                                           width: double.infinity,
//                                           child: Card(
//                                             elevation: 8,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(32)),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(20.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   const SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Text(
//                                                     repo[index].name,
//                                                     maxLines: 1,
//                                                     softWrap: false,
//                                                     style: const TextStyle(
//                                                       fontSize: 20,
//                                                       color: Color(0xFF414C6B),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                     ),
//                                                     textAlign: TextAlign.left,
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                   Text(
//                                                     "repo ID ${repo[index].id}",
//                                                     style: const TextStyle(
//                                                       fontSize: 12,
//                                                       color: Color(0xFF414C6B),
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                     textAlign: TextAlign.left,
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                   Text(
//                                                     repo[index].description,
//                                                     maxLines: 1,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: const TextStyle(
//                                                       fontSize: 15,
//                                                       color: Color(0xFFE4979E),
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                   InkWell(
//                                                     onTap: () => _launchURL(
//                                                         repo[index].svnUrl),
//                                                     child: Text(
//                                                       repo[index].svnUrl,
//                                                       style: const TextStyle(
//                                                         fontSize: 15,
//                                                         color:
//                                                             Color(0xFFE4979E),
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               : const SizedBox.shrink();
//                         },
//                       ),