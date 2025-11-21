import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';
import '../blocs/order_cubit.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  const MenuCard({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    final price = menu.getDiscountedPrice();
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(colors: [Colors.white, Colors.orange.shade50]),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // image / icon circle
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Theme.of(context).primaryColor.withOpacity(0.9), Theme.of(context).primaryColor]),
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.25), blurRadius: 6, offset: Offset(0, 3))],
                      ),
                      child: Center(child: Icon(Icons.fastfood, color: Colors.white, size: 28)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(menu.name, style: const TextStyle(fontWeight: FontWeight.w700))),
                    if (menu.discount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(8)),
                        child: Text('${(menu.discount * 100).toStringAsFixed(0)}% OFF', style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rp $price', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700, fontSize: 16)),
                        if (menu.discount > 0) Text('Rp ${menu.price}', style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        orderCubit.addToOrder(menu);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${menu.name} ditambahkan')));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.add_shopping_cart, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text('Tambah', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
