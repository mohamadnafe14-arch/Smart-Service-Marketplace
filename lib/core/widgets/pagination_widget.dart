import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_service_marketplace/core/models/pagination_link.dart';

class PaginationWidget extends StatelessWidget {
  final List<PaginationLink> links;
  final Function(int) onPageSelected;

  const PaginationWidget({
    super.key,
    required this.links,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: links.length,
        itemBuilder: (context, index) {
          final link = links[index];
          final pageNum = int.tryParse(link.label);
          if (pageNum == null) return const SizedBox();
          return GestureDetector(
            onTap: link.url != null ? () => onPageSelected(pageNum) : null,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: link.active ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$pageNum',
                style: TextStyle(
                  color: link.active ? Colors.white : Colors.black,
                  fontWeight: link.active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
