import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/category_cubit.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';

// Data menu contoh (tetap lokal, tapi ditata ulang)
final List<MenuModel> sampleMenus = [
  MenuModel(id: '1', name: 'Nasi Goreng ayam', price: 28000, category: 'Makanan', discount: 0.12),
  MenuModel(id: '2', name: 'Mie Ayam Biasa', price: 20000, category: 'Makanan', discount: 0.0),
  MenuModel(id: '3', name: 'Es Teh Manis', price: 7000, category: 'Minuman', discount: 0.0),
  MenuModel(id: '4', name: 'Jus Mangga', price: 15000, category: 'Minuman', discount: 0.05),
  MenuModel(id: '5', name: 'Roti Bakar Cokelat', price: 12000, category: 'Snack', discount: 0.0),
  MenuModel(id: '6', name: 'Kentang Goreng', price: 18000, category: 'Snack', discount: 0.1),
  // Items baru yang diminta
  MenuModel(id: '7', name: 'Ayam Geprek', price: 22000, category: 'Makanan', discount: 0.0),
  MenuModel(id: '8', name: 'Ayam Penyet', price: 21000, category: 'Makanan', discount: 0.0),
  MenuModel(id: '9', name: 'Pop Ice', price: 8000, category: 'Minuman', discount: 0.0),
  MenuModel(id: '10', name: 'Air Mineral', price: 3000, category: 'Minuman', discount: 0.0),
  MenuModel(id: '11', name: 'Burger', price: 25000, category: 'Snack', discount: 0.05),
  MenuModel(id: '12', name: 'Tahu Gejrot', price: 12000, category: 'Snack', discount: 0.0),
];

class CategoryStackPage extends StatefulWidget {
  const CategoryStackPage({Key? key}) : super(key: key);

  @override
  State<CategoryStackPage> createState() => _CategoryStackPageState();
}

class _CategoryStackPageState extends State<CategoryStackPage> {
  String searchQuery = '';

  List<String> getCategories() {
    final cats = sampleMenus.map((e) => e.category).toSet().toList();
    return cats;
  }

  @override
  Widget build(BuildContext context) {
    final categories = getCategories();

    return BlocProvider(
      create: (_) => CategoryCubit()..selectCategory(categories.first),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Row(
            children: [
              ShaderMask(
                shaderCallback: (rect) => LinearGradient(colors: [Colors.purple, Colors.blue, Colors.cyan]).createShader(rect),
                child: const Icon(Icons.restaurant, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 8),
              const Text('Cafe Adchrisa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFe0c3fc), Color(0xFF8ec5fc), Color(0xFFf9f9f9)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  // banner/search
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari menu favorit... ',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            ),
                            onChanged: (q) {
                              setState(() {
                                searchQuery = q.trim().toLowerCase();
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.filter_list, color: Colors.white),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // kategori chips dengan animasi dan gradient
                  SizedBox(
                    height: 60,
                    child: BlocBuilder<CategoryCubit, String?>(
                      builder: (context, selected) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            final cat = categories[i];
                            final active = cat == selected;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOutCubic,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                gradient: active
                                    ? LinearGradient(colors: [Colors.blueAccent, Colors.cyan])
                                    : LinearGradient(colors: [Colors.white, Colors.white]),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: active ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.18), blurRadius: 8)] : null,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(32),
                                onTap: () => context.read<CategoryCubit>().selectCategory(cat),
                                child: Row(children: [Icon(_iconForCategory(cat), color: active ? Colors.white : Colors.black54, size: 20), const SizedBox(width: 8), Text(cat, style: TextStyle(color: active ? Colors.white : Colors.black87, fontWeight: FontWeight.w600))]),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(width: 0),
                          itemCount: categories.length,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // grid menu
                  Expanded(
                    child: BlocBuilder<CategoryCubit, String?>(
                      builder: (context, selected) {
                        final filtered = sampleMenus.where((m) =>
                          m.category == selected &&
                          (searchQuery.isEmpty || m.name.toLowerCase().contains(searchQuery))
                        ).toList();
                        if (filtered.isEmpty) return const Center(child: Text('Tidak ada menu di kategori ini'));
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.95,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, i) {
                            return MenuCard(menu: filtered[i]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconForCategory(String cat) {
    switch (cat.toLowerCase()) {
      case 'makanan':
        return Icons.lunch_dining;
      case 'minuman':
        return Icons.local_drink;
      case 'snack':
        return Icons.fastfood;
      default:
        return Icons.menu;
    }
  }
}
