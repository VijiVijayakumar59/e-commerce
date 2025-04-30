import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/providers/cart_item_bloc/cart_item_bloc.dart';

class CountWidget extends StatefulWidget {
  final int id;
  final int initialQuantity;

  const CountWidget({super.key, required this.initialQuantity, required this.id});

  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _updateQuantity(int newQuantity) {
    setState(() => quantity = newQuantity);
    context.read<CartItemBloc>().add(UpdateItemQuantity(id: widget.id, quantity: quantity));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final height = orientation == Orientation.portrait ? size.height * 0.035 : size.height * 0.07; // slightly taller in landscape

    return Container(
      height: height,
      width: 80,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: quantity > 1 ? () => _updateQuantity(quantity - 1) : null,
            child: Icon(CupertinoIcons.minus, size: 16, color: quantity > 1 ? CupertinoColors.black : CupertinoColors.inactiveGray),
          ),
          Text(quantity.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          GestureDetector(onTap: () => _updateQuantity(quantity + 1), child: const Icon(CupertinoIcons.add, size: 16)),
        ],
      ),
    );
  }
}
