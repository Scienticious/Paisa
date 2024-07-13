import 'package:flutter/material.dart';

import 'package:paisa/config/routes.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/category/data/model/category_model.dart';

class CategoryItemDesktopWidget extends StatelessWidget {
  const CategoryItemDesktopWidget({
    super.key,
    required this.category,
    required this.onPressed,
  });

  final CategoryModel category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PaisaCard(
      child: InkWell(
        onTap: () {
          CategoryPageData(
            categoryId: category.superId,
          ).push(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      category.icon,
                      fontFamily: fontFamilyName,
                      fontPackage: fontFamilyPackageName,
                    ),
                    size: 42,
                    color: context.onSurface,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.delete_rounded,
                      color: context.error,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: context.titleLarge?.copyWith(
                      color: context.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    category.description == null ? '' : category.description!,
                    style: context.bodyLarge?.copyWith(
                      color: context.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
