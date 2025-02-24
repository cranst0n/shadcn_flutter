import 'package:shadcn_flutter/shadcn_flutter.dart';

class MultiSelectExample3 extends StatefulWidget {
  const MultiSelectExample3({super.key});

  @override
  State<MultiSelectExample3> createState() => _MultiSelectExample3State();
}

class _MultiSelectExample3State extends State<MultiSelectExample3> {
  final Map<String, List<String>> fruits = {
    'Apple': ['Red Apple', 'Green Apple'],
    'Banana': ['Yellow Banana', 'Brown Banana'],
    'Lemon': ['Yellow Lemon', 'Green Lemon'],
    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  };
  Iterable<String>? selectedValues;

  Iterable<MapEntry<String, List<String>>> _filteredFruits(
      String searchQuery) sync* {
    for (final entry in fruits.entries) {
      final filteredValues = entry.value
          .where((value) => _filterName(value, searchQuery))
          .toList();
      if (filteredValues.isNotEmpty) {
        yield MapEntry(entry.key, filteredValues);
      } else if (_filterName(entry.key, searchQuery)) {
        yield entry;
      }
    }
  }

  bool _filterName(String name, String searchQuery) {
    return name.toLowerCase().contains(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelect<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      popup: SelectPopup.builder(
        searchPlaceholder: const Text('Search fruit'),
        emptyBuilder: (context) {
          return const Center(
            child: Text('No fruit found'),
          );
        },
        loadingBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        builder: (context, searchQuery) async {
          final filteredFruits = searchQuery == null
              ? fruits.entries.toList()
              : _filteredFruits(searchQuery).toList();
          await Future.delayed(const Duration(milliseconds: 500));
          return SelectItemBuilder(
            childCount: filteredFruits.isEmpty ? 0 : null,
            builder: (context, index) {
              final entry = filteredFruits[index % filteredFruits.length];
              return SelectGroup(
                headers: [
                  SelectLabel(
                    child: Text(entry.key),
                  ),
                ],
                children: [
                  for (final value in entry.value)
                    SelectItemButton(
                      value: value,
                      child: Text(value),
                    ),
                ],
              );
            },
          );
        },
      ),
      onChanged: (value) {
        setState(() {
          selectedValues = value;
        });
      },
      constraints: BoxConstraints(
        minWidth: 200,
      ),
      value: selectedValues,
      placeholder: const Text('Select a fruit'),
    );
  }
}
