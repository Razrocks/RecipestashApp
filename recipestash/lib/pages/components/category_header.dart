import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  // const CategoryHeader({Key? key, required this.text}) : super(key: key);

  // final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Categories(),
      ],
    );
  }
}

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Dessert",
    "Snack",
    "Drink"
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 25.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategoryItem(index),
        ),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 2),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color:
              selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          categories[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index
                ? Color.fromARGB(255, 1, 1, 211)
                : Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}