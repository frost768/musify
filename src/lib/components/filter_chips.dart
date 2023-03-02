import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/consts.dart';

import 'package:spotify_clone/providers/playlist_provider.dart';

class SearchPageFilterChips extends FilterChips {
  SearchPageFilterChips() : super(searchPageChiplist, searchPageFilterProvider);
}

class LibraryPageFilterChips extends FilterChips {
  LibraryPageFilterChips() : super(libraryChiplist, libraryPageFilterProvider);
}

class FilterChips extends ConsumerStatefulWidget {
  final StateNotifierProvider<FilterNotifier, String>? filter;
  final Map<String, String> chipList;
  const FilterChips(this.chipList, this.filter);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterChipsState();
}

class _FilterChipsState extends ConsumerState<FilterChips> {
  var _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (__, WidgetRef ref, _) {
        final filter = ref.watch(widget.filter!);
        return SizedBox(
          height: 60,
          child: ListView.separated(
              padding: const EdgeInsets.only(left: 20),
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.chipList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 10),
              itemBuilder: (BuildContext context, int index) {
                final e = widget.chipList.entries.elementAt(index);
                return FilterChip(
                  onSelected: (value) {
                    ref.read(widget.filter!.notifier).set(e.key);
                    setState(() {});
                    _controller.animateTo(50 * index.toDouble(),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear);
                  },
                  label: Text(e.value),
                  selected: e.key == filter,
                );
              }),
        );
      },
    );
  }
}
