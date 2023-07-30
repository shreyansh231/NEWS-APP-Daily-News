import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'model.dart';
class Category extends StatefulWidget {

  String Query;
  Category({super.key, required this.Query});

  @override

  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];

  bool isLoading = true;
  getNewsByQuery(String query) async {

    String url = "";
    if(query == "Top News" || query == "India"){
       url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=eba122e30d1b45bca0573ccdd603a9ce";

    }
    // if( query=="World" || query=="Finacnce")
    //   {
    //     url="https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=eba122e30d1b45bca0573ccdd603a9ce";
    //   }
    else{
    url= "https://newsapi.org/v2/everything?q=$query&from=2023-06-20&sortBy=publishedAt&apiKey=eba122e30d1b45bca0573ccdd603a9ce";
    }

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });

      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery(widget.Query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily News"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body:    SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin : const EdgeInsets.fromLTRB(15, 25, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12,),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(widget.Query, style: const TextStyle( fontSize: 39
                      ),),
                    ),
                  ],
                ),
              ),
              isLoading ? SizedBox( height: MediaQuery.of(context).size.height -500 , child: const Center(child: CircularProgressIndicator(),),) :
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 1.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(newsModelList[index].newsImg ,fit: BoxFit.fitHeight, height: 230,width: double.infinity, )),

                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(

                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12.withOpacity(0),
                                                Colors.black
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter
                                          )
                                      ),
                                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            newsModelList[index].newsHead,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(newsModelList[index].newsDes.length > 50 ? "${newsModelList[index].newsDes.substring(0,55)}...." : newsModelList[index].newsDes , style: const TextStyle(color: Colors.white , fontSize: 12)
                                            ,)
                                        ],
                                      )))
                            ],
                          )),
                    );
                  }),

            ],
          ),
        ),
      ),
    );
  }
}