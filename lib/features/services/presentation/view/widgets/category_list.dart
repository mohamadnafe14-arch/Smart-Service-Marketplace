import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/features/services/data/models/category_model.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/service_states.dart';
import 'package:smart_service_marketplace/features/services/presentation/manager/services_cubit/services_cubit.dart';
import 'package:smart_service_marketplace/features/services/presentation/view/widgets/category_item.dart';

//category model and logic
class CategoryList extends StatefulWidget {
  const CategoryList({super.key});
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  static List<CategoryModel> categories = const [
    CategoryModel(title: "الكل", icon: Icons.all_inclusive_outlined),
    CategoryModel(title: "الكهرباء", icon: Icons.electrical_services_outlined),
    CategoryModel(title: "البناء", icon: Icons.construction_outlined),
    CategoryModel(title: "البرمجة", icon: Icons.code_outlined),
    CategoryModel(title: "السباكة", icon: Icons.plumbing_outlined),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        final selected = context.read<ServicesCubit>().selectedCategory;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: GestureDetector(
                  onTap: () {
                    context.read<ServicesCubit>().changeCategory(
                          categories[index].title,
                    );
                  },
                  child: CategoryItem(
                    categoryModel: categories[index],
                    isSelected: selected == categories[index].title,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
