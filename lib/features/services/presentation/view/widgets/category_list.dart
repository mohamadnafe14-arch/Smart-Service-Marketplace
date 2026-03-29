import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/services/data/models/category_model.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/category_item.dart';

//category model and logic
class CategoryList extends StatefulWidget {
  const CategoryList({super.key});
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  static List<CategoryModel> categories = const [
    CategoryModel(title: "السباكة", icon: Icons.plumbing_outlined),
    CategoryModel(title: "الكهرباء", icon: Icons.electrical_services_outlined),
    CategoryModel(title: "البناء", icon: Icons.construction_outlined),
    CategoryModel(title: "البرمجة", icon: Icons.code_outlined),
    CategoryModel(title: "الكل", icon: Icons.all_inclusive_outlined),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (index != currentIndex) {
                    currentIndex = index;
                  }
                });
              },
              child: CategoryItem(
                categoryModel: categories[index],
                isSelected: currentIndex == index,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
