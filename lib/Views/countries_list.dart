import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/state_services.dart';
import 'detailes_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  StatesService statesService = StatesService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesService.fetchCountriesRecord(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10.0,
                                  width: 50.0,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10.0,
                                  width: 50.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String countryName =
                            snapshot.data![index]["country"].toString();
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailesScreen(
                                        name: snapshot.data![index]["country"]
                                            .toString(),
                                        totalCases: snapshot.data![index]
                                            ["cases"],
                                        totalDeaths: snapshot.data![index]
                                            ["deaths"],
                                        totalRecovered: snapshot.data![index]
                                            ["totalRecovered"],
                                        active: snapshot.data![index]["active"],
                                        critical: snapshot.data![index]
                                            ["critical"],
                                        todayRecovered: snapshot.data![index]
                                            ["todayRecovered"],
                                        test: snapshot.data![index]["test"],
                                        image: snapshot.data![index]
                                                ["countryInfo"]["flag"]
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]["countryInfo"]
                                          ["flag"],
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data![index]["country"].toString(),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]["cases"].toString() +
                                        " Cases",
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (countryName.toLowerCase().contains(
                            searchController.text
                                .toLowerCase()
                                .toLowerCase())) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]["countryInfo"]
                                        ["flag"],
                                  ),
                                ),
                                title: Text(
                                  snapshot.data![index]["country"].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]["cases"].toString() +
                                      " Cases",
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
