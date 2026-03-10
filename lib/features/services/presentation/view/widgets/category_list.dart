import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/category_item.dart';
//category model and logic
class CategoryList extends StatefulWidget {
  const CategoryList({super.key});
  @override
  State<CategoryList> createState() => _CategoryListState();
}
class _CategoryListState extends State<CategoryList> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: CategoryItem(
                icon: Icons.home_repair_service_outlined,
                title: 'Category $index',
                isSelected: currentIndex == index,
              ),
            ),
          ),
        ),
      ),
    );
  }
}