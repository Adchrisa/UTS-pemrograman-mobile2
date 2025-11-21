import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

class OrderItem {
  final MenuModel menu;
  final int qty;
  OrderItem({required this.menu, required this.qty});

  OrderItem copyWith({MenuModel? menu, int? qty}) {
    return OrderItem(menu: menu ?? this.menu, qty: qty ?? this.qty);
  }
}

class OrderCubit extends Cubit<List<OrderItem>> {
  OrderCubit() : super([]);

  void addToOrder(MenuModel menu) {
    final idx = state.indexWhere((e) => e.menu.id == menu.id);
    final List<OrderItem> newList = List.from(state);
    if (idx >= 0) {
      final existing = newList[idx];
      newList[idx] = existing.copyWith(qty: existing.qty + 1);
    } else {
      newList.add(OrderItem(menu: menu, qty: 1));
    }
    emit(newList);
  }

  void removeFromOrder(MenuModel menu) {
    final newList = state.where((e) => e.menu.id != menu.id).toList();
    emit(newList);
  }

  void updateQuantity(MenuModel menu, int qty) {
    final idx = state.indexWhere((e) => e.menu.id == menu.id);
    final List<OrderItem> newList = List.from(state);
    if (idx >= 0) {
      if (qty <= 0) {
        newList.removeAt(idx);
      } else {
        final existing = newList[idx];
        newList[idx] = existing.copyWith(qty: qty);
      }
      emit(newList);
    }
  }

  void clearOrder() {
    emit([]);
  }

  int getTotalPrice() {
    int total = 0;
    for (final item in state) {
      final itemPrice = item.menu.getDiscountedPrice() * item.qty;
      total += itemPrice;
    }
    return total;
  }

  int getFinalPriceWithBonus() {
    final subtotal = getTotalPrice();
    if (subtotal > 100000) {
      final discounted = (subtotal - (subtotal * 0.10)).toInt();
      return discounted;
    } else {
      return subtotal;
    }
  }

  bool isTotalDiscountApplied() {
    return getTotalPrice() > 100000;
  }
}
