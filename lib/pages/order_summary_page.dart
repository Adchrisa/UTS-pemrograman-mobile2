import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Pesanan'), backgroundColor: Theme.of(context).primaryColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OrderCubit, List<OrderItem>>(
                  builder: (context, items) {
                    if (items.isEmpty) return const Center(child: Text('Belum ada pesanan'));
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final it = items[i];
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(backgroundColor: Theme.of(context).primaryColor.withOpacity(0.12), child: Text(it.menu.name[0].toUpperCase(), style: TextStyle(color: Theme.of(context).primaryColor))),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(it.menu.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 4),
                                      Text('Rp ${it.menu.getDiscountedPrice()} x ${it.qty}', style: const TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () => orderCubit.updateQuantity(it.menu, it.qty - 1),
                                    ),
                                    Text('${it.qty}'),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () => orderCubit.updateQuantity(it.menu, it.qty + 1),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () => orderCubit.removeFromOrder(it.menu),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<OrderCubit, List<OrderItem>>(builder: (context, items) {
                final subtotal = orderCubit.getTotalPrice();
                final finalPrice = orderCubit.getFinalPriceWithBonus();
                final discountApplied = orderCubit.isTotalDiscountApplied();

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text('Rp $subtotal'),
                        ],
                      ),
                      if (discountApplied) ...[
                        const SizedBox(height: 6),
                        const Text('Diskon total 10% diterapkan!', style: TextStyle(color: Colors.green)),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Akhir', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Rp $finalPrice', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: items.isEmpty
                                  ? null
                                  : () {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil membayar Rp $finalPrice')));
                                      orderCubit.clearOrder();
                                    },
                              child: const Text('Bayar'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () => orderCubit.clearOrder(),
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                            child: const Text('Reset'),
                          )
                        ],
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
