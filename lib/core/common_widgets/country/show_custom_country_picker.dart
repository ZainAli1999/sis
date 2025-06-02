import 'package:flutter/material.dart';
import 'package:sis/core/common_widgets/country/country_list.dart';
import 'package:sis/core/common_widgets/country/country_model.dart';

void showCustomCountryPicker(BuildContext context, Function(CountryModel) onSelect) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return CountryPickerBottomSheet(onSelect: onSelect);
    },
  );
}

class CountryPickerBottomSheet extends StatefulWidget {
  final Function(CountryModel) onSelect;

  const CountryPickerBottomSheet({super.key, required this.onSelect});

  @override
  State<CountryPickerBottomSheet> createState() =>
      _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  List<CountryModel> filteredCountries = countries;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                filteredCountries = countries
                    .where((country) => country.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,
                  color: Theme.of(context).colorScheme.secondary),
              hintText: "Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (context, index) {
              final country = filteredCountries[index];
              return ListTile(
                onTap: () {
                  widget.onSelect(country);
                  Navigator.pop(context);
                },
                leading: Text(
                  country.flag,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  country.name,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                subtitle: Text(
                  country.code,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
