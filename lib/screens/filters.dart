import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Map<Filter, bool> _filters;

  @override
  void initState() {
    super.initState();
    _filters = {...widget.currentFilters}; // Copy the current filter values
  }

  // Method to save the filter settings
  void _saveFilters() {
    Navigator.of(context).pop(_filters); // Return the selected filters
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: WillPopScope(
        onWillPop: () async {
          // Return the current filter settings when the user navigates back
          Navigator.of(context).pop(_filters);
          return false;
        },
        child: Column(
          children: [
            ...Filter.values.map((filter) {
              return SwitchListTile(
                value: _filters[filter] ?? false,
                onChanged: (newValue) {
                  setState(() {
                    _filters[filter] = newValue;
                  });
                },
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
            }).toList(),
            const Spacer(), // Add a spacer to push the button to the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: _saveFilters,
                child: const Text('Save Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
