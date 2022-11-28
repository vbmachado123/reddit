import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../model/filter.dart';

/**
 * @description: O FilterListItem (barra de pesquisa) simplificando 
 * a implementação e aumentando a escalabilidade da aplicação
 */
class FilterListItemWidget extends StatefulWidget {
  final Filter filter;
  final VoidCallback onTap;

  const FilterListItemWidget({
    super.key,
    required this.filter,
    required this.onTap,
  });

  @override
  State<FilterListItemWidget> createState() => _FilterListItemWidgetState();
}

class _FilterListItemWidgetState extends State<FilterListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          border: Border.all(
            color: widget.filter.isSelected
                ? widget.filter.color
                : AppColors.grey_0,
            width: 1,
          ),
        ),
        child: Text(
          'r/${widget.filter.label}',
          style: AppTextStyles.p_regular,
        ),
      ),
    );
  }
}
