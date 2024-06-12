part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<Pizza> cart;

  const CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}