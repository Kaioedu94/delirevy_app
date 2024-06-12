import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            if (state.cart.isEmpty) {
              return const Center(
                child: Text('O carrinho está vazio.'),
              );
            }
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final cartItem = state.cart[index];
                return Card(
                  child: ListTile(
                    
                    leading: Image.asset('assets/1.png'),
                    title: Text(cartItem.name),
                    subtitle: Text('R\$${cartItem.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(RemoveFromCart(cartItem));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item removido do carrinho'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
