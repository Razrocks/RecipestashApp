import 'package:flutter/material.dart';
import 'package:recipestash/classes/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipestash/pages/account.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Authentication().currentUser;

  Widget searchField()
  {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                ),
                hintText: 'Search',
                suffixIcon: Icon(Icons.search)
              )
            )
          ),
        ],
      )
    );
  }

  Widget categoriesHeader()
  {
    return const Column(
      children: [
        Text('Categories', style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.5)
      ],
    );
  }

  Widget card(String text, double w, double h) //add image parameter later
  {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey
              // image: DecorationImage(                //uncomment after adding image parameter
              //   image: AssetImage(imagePath),
              //   fit: BoxFit.cover)
              ),
          ),
          
        ],
      )
    );
  }

  Widget categories()
  {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            card('Breakfast',120,80),
            card('Lunch',120,80),
            card('Dinner',120,80),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            card('Dessert',120,80),
            card('Snacks',120,80),
            card('Drinks',120,80),
          ],
        )
      ],
    );
  }

  // Widget recipes()
  // {
  //   return ListView(); //add recipe cards later
  // }

  void addRecipe()
  {
    //add recipe
  }

  void navtoAccount(BuildContext context)
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Account())
    );
  }

  Widget navBar(BuildContext context)
  {
    return BottomAppBar(
      height: 40,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ones that are only icon need their pages before they can be navigated to
          Icon(Icons.home_outlined),
          IconButton(onPressed: () {navtoAccount(context);}, icon: Icon(Icons.account_circle_outlined)),
          Icon(Icons.settings_outlined)
        ],
      )
    );
  }

    Future<void> signOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            searchField(),
            categoriesHeader(),
            categories(),
            // recipes(),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {addRecipe();},
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: navBar(context),
      )
    );
  }
}