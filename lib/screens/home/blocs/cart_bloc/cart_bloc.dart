import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart'; // Verifique o caminho

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<GetCart>(_onGetCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (state is CartUpdated) {
      final List<Pizza> updatedCart = List.from((state as CartUpdated).cart)..add(event.pizza);
      emit(CartUpdated(updatedCart));
    } else {
      emit(CartUpdated([event.pizza]));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    if (state is CartUpdated) {
      final List<Pizza> updatedCart = List.from((state as CartUpdated).cart)..remove(event.pizza);
      emit(CartUpdated(updatedCart));
    } else {
      emit(const CartUpdated([]));
    }
  }

  void _onGetCart(GetCart event, Emitter<CartState> emit) {
    if (state is CartUpdated) {
      emit(state);
    } else {
      emit(const CartUpdated([])); 
    }
  }
}
