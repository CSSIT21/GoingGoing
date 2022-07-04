import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../config/routes/routes.dart';
import '../../models/google_api/place.dart';
import '../../models/google_api/suggestion_place.dart';
import '../../services/google_maps_service.dart';
import '../../services/provider/search_provider.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/search/search_bar.dart';
import '../../widgets/search/no_result_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _query = TextEditingController();
  final _googleMapsApi = GoogleMapsApi(const Uuid().v4());

  late List<SuggestionPlace> _suggestions = <SuggestionPlace>[];

  void _onSelectPlace(SuggestionPlace suggest) async {
    Place place = await _googleMapsApi.getPlaceDetailFromId(suggest.placeId);
    context.read<SearchProvider>().place = place;

    Navigator.pushNamed(context, Routes.showOffer);
  }

  void _onQueryChanged(String value) async {
    if (value.isEmpty) {
      setState(() {
        _suggestions.clear();
      });
      return;
    }

    var suggestions = await _googleMapsApi.fetchSuggestions(
      value,
      Localizations.localeOf(context).languageCode,
    );

    setState(() {
      _suggestions = suggestions;
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
            child: SearchBar(_query, _onQueryChanged),
          ),
          _query.text.isEmpty
              ? Container(
                  padding: const EdgeInsets.only(left: 35, top: 8),
                  width: double.infinity,
                  child: const NoResultText(),
                )
              : _suggestions.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              _suggestions[index].description,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          onTap: () => _onSelectPlace(_suggestions[index]),
                        ),
                        itemCount: _suggestions.length,
                      ),
                    )
                  : const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
