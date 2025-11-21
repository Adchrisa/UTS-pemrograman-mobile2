import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';
import 'category_stack_page.dart';
import 'order_summary_page.dart';

class OrderHomePage extends StatefulWidget {
  const OrderHomePage({Key? key}) : super(key: key);

  @override
  State<OrderHomePage> createState() => _OrderHomePageState();
}

class _OrderHomePageState extends State<OrderHomePage> {
  int _selectedIndex = 0;
  final pages = [
    const CategoryStackPage(),
    const OrderSummaryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: context.read<OrderCubit>(),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          child: pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.grid_view, color: _selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.grey),
                onPressed: () => setState(() => _selectedIndex = 0),
                tooltip: 'Daftar Menu',
              ),
              // cart with badge
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.receipt_long, size: 28, color: _selectedIndex == 1 ? Theme.of(context).primaryColor : Colors.grey),
                    Positioned(
                      right: 0,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(12)),
                        child: Text('${context.read<OrderCubit>().state.length}', style: const TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
