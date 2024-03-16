import 'package:flutter/material.dart';
import 'package:cocktail_api_yeferson/controllers/cocktail_controller.dart';
import 'package:cocktail_api_yeferson/model/cocktail_model.dart';
import 'package:get/get.dart';
import 'details_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api de Cocktail'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: GetBuilder<CocktailController>(
          init: CocktailController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<CocktailModel>>(
                    future: controller.getCocktails(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        );
                      } else {
                        return Expanded(
                        
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.cocktails.length,
                            itemBuilder: (context, index) {
                              final cocktail =
                                  snapshot.data![index].drinks[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          image: cocktail.strDrinkThumb,
                                          name: cocktail.strDrink,
                                        ),
                                      ));
                                },
                                child: Card(
                                  elevation: 2,
                                  color: Colors.deepPurple,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          cocktail.strDrinkThumb,
                                          height: 110,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Id: ${cocktail.idDrink}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            cocktail.strDrink,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ],
            );
          }),
    );
  }
}