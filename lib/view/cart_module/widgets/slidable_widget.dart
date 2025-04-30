import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify/core/common/app_slidable.dart';
import 'package:shopify/core/common/app_snackbar.dart';
import 'package:shopify/core/helper.dart';
import 'package:shopify/models/cart_item_model.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';
import 'package:shopify/view/cart_module/widgets/count_widget.dart';

class SlidableWidget extends StatelessWidget {
  final CartItemModel data;
  const SlidableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    final imageWidth = isPortrait ? size.width * 0.23 : size.width * 0.15;
    final imageHeight = isPortrait ? size.height * 0.08 : size.height * 0.12;

    return AppSlidable(
      slideActions: [
        Container(
          height: imageHeight + 30,
          width: size.width * 0.15,
          decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
          child: IconButton(
            onPressed: () {
              BlocProvider.of<CartItemBloc>(context).add(RemoveCartItem(id: data.id));
              AppSnackbar().showAwesomeSnackBar(context, success, itemRemovedSuccessfully, ContentType.success);
            },
            icon: const Icon(Icons.delete_rounded, color: Colors.white),
          ),
        ),
      ],
      slidingCard: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: imageHeight + 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(data.image), fit: BoxFit.contain)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 12, color: Colors.black, fontWeight: FontWeight.w700)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '\$ ${data.price}',
                            style: GoogleFonts.roboto(textStyle: const TextStyle(letterSpacing: .5, fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700)),
                          ),
                          const Spacer(),
                          Container(
                            height: isPortrait ? size.height * 0.028 : size.height * 0.05,
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
                            child: CountWidget(initialQuantity: data.quantity, id: data.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
