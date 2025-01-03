import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  late Map<Filter, bool> _filters;

  @override
  void initState() {
    super.initState();
    _filters = {...widget.currentFilters};
  }

  void _saveFilters() {
    Navigator.of(context).pop(_filters);
  }

  void _resetFilters() {
    setState(() {
      _filters = {
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      };
    });
  }

  Future<bool> _onWillPop() async {
    if (_filters != widget.currentFilters) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text(
              'You have unsaved changes. Are you sure you want to discard them?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Discard'),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Column(
          children: [
            ...Filter.values.map((filter) {
              return FilterSwitch(
                filter: filter,
                value: _filters[filter] ?? false,
                onChanged: (newValue) {
                  setState(() {
                    _filters[filter] = newValue;
                  });
                },
              );
            }).toList(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.errorContainer,
                        foregroundColor:
                            Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      onPressed: _resetFilters,
                      child: const Text('Reset Filters'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: _saveFilters,
                      child: const Text('Save Filters'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterSwitch extends StatelessWidget {
  const FilterSwitch({
    super.key,
    required this.filter,
    required this.value,
    required this.onChanged,
  });

  final Filter filter;
  final bool value;
  final void Function(bool) onChanged;

  String _getFilterTitle(Filter filter) {
    switch (filter) {
      case Filter.glutenFree:
        return 'Gluten-free';
      case Filter.lactoseFree:
        return 'Lactose-free';
      case Filter.vegetarian:
        return 'Vegetarian';
      case Filter.vegan:
        return 'Vegan';
      default:
        return '';
    }
  }

  String _getFilterSubtitle(Filter filter) {
    switch (filter) {
      case Filter.glutenFree:
        return 'Only include gluten-free meals.';
      case Filter.lactoseFree:
        return 'Only include lactose-free meals.';
      case Filter.vegetarian:
        return 'Only include vegetarian meals.';
      case Filter.vegan:
        return 'Only include vegan meals.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        _getFilterTitle(filter),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        _getFilterSubtitle(filter),
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
