import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart'; // Verifique o caminho

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    } else if (event is GetCart) {
      yield* _mapGetCartToState();
    }
  }

  Stream<CartState> _mapAddToCartToState(AddToCart event) async* {
    if (state is CartUpdated) {
      final List<Pizza> updatedCart = List.from((state as CartUpdated).cart)..add(event.pizza);
      yield CartUpdated(updatedCart);
    } else {
      yield CartUpdated([event.pizza]);
    }
  }

  Stream<CartState> _mapRemoveFromCartToState(RemoveFromCart event) async* {
    if (state is CartUpdated) {
      final List<Pizza> updatedCart = List.from((state as CartUpdated).cart)..remove(event.pizza);
      yield CartUpdated(updatedCart);
    } else {
      yield const CartUpdated([]);
    }
  }

  Stream<CartState> _mapGetCartToState() async* {
    if (state is CartUpdated) {
      yield state;
    } else {
      yield const CartUpdated([]); 
    }
  }
}
