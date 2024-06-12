import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc/cart_bloc.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(state.cart[index].image),
                    title: Text(state.cart[index].name),
                    subtitle: Text('\$${state.cart[index].price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        // Remover item do carrinho
                        BlocProvider.of<CartBloc>(context).add(RemoveFromCart(state.cart[index]));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
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