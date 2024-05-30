import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/bloc/picture_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/pages/picture_details_page.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/picture_card.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/pictures_list_form_filed.dart';

class PicturesList extends StatefulWidget {
  const PicturesList({
    super.key,
  });

  @override
  State<PicturesList> createState() => _PicturesListState();
}

class _PicturesListState extends State<PicturesList> {
  late final PictureBloc pictureBloc;
  final _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    pictureBloc = BlocProvider.of<PictureBloc>(context);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  /// When ever scroll position isBottom should make a Request for load new list
  void _onScroll() {
    if (_isBottom) {
      pictureBloc.add(const FetchPicturesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12,
          ),
          child: PicturesListFormField(),
        ),
        Expanded(
          child: BlocBuilder<PictureBloc, PictureState>(
            // buildWhen: (previous, current) =>
            //     previous.filteredPictures != current.filteredPictures,
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: state.filteredPictures.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PictureDetailsPage(
                                  picture: state.filteredPictures[index],
                                ),
                              ),
                            ),
                            child: PictureCard(
                                picture: state.filteredPictures[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
