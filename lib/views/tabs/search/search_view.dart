import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/views/components/search_grid_view.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/extension/dismiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serchController = useTextEditingController();
    final searchTerm = useState('');
    useEffect(() {
      serchController.addListener(() {
        searchTerm.value = serchController.text;
      });
      return () {};
    }, [useTextEditingController]);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: serchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: Strings.enterYourSearchTermHere,
                suffixIcon: IconButton(
                  onPressed: () {
                    serchController.clear();
                    dismissKeyboard();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ),
        ),
        SearchGridView(searchTerm: searchTerm.value)
      ],
    );
  }
}
