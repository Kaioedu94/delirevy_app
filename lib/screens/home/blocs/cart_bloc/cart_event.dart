part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Pizza pizza;

  const AddToCart(this.pizza);

  @override
  List<Object> get props => [pizza];
}

class RemoveFromCart extends CartEvent {
  final Pizza pizza;

  const RemoveFromCart(this.pizza);

  @override
  List<Object> get props => [pizza];
}

class GetCart extends CartEvent {}
