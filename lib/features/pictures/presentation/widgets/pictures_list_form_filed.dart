import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/bloc/picture_bloc.dart';

class PicturesListFormField extends StatefulWidget {
  const PicturesListFormField({super.key});

  @override
  State<PicturesListFormField> createState() => _PicturesListFormFieldState();
}

class _PicturesListFormFieldState extends State<PicturesListFormField> {
  late PictureBloc pictureBloc;
  final TextEditingController filterController = TextEditingController();
  final FocusNode filterFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    pictureBloc = BlocProvider.of<PictureBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PictureBloc, PictureState>(
      bloc: pictureBloc,
      builder: (context, state) {
        return TextFormField(
          controller: filterController,
          focusNode: filterFocusNode,
          onChanged: (label) => pictureBloc.add(FilterListEvent(label: label)),
          keyboardType: state.selectedFilter == Filtertype.date
              ? TextInputType.datetime
              : TextInputType.name,
          decoration: InputDecoration(
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                    ),
                    initialSelection: state.selectedFilter,
                    width: MediaQuery.sizeOf(context).width / 4,
                    onSelected: (selectedFilter) async {
                      filterFocusNode.nextFocus();
                      pictureBloc.add(ChangeFilterEvent(
                        selectedFilter: selectedFilter!,
                      ));
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                        label: 'Date',
                        value: Filtertype.date,
                      ),
                      DropdownMenuEntry(
                        label: 'Title',
                        value: Filtertype.title,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
