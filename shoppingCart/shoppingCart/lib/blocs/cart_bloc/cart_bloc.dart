import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppingCart/models/cart.dart';
import 'package:shoppingCart/models/item.dart';
import 'package:shoppingCart/models/products.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartStarted) {
      yield* _mapCartStartedToState();
    } else if (event is CartItemAdded) {
      yield* _mapCartItemAddedToState(state,event);
    }
  }
}

Stream<CartState> _mapCartStartedToState() async* {
  yield CartLoading();
  try{
    yield CartLoaded(cartItem: []);
  } catch(_) {
    yield CartError();
  }
}

Stream<CartState> _mapCartItemAddedToState(CartState state, CartItemAdded event) async* {
  final currentState = state;
  if (currentState is CartLoaded) {
    try {
      yield CartLoaded(
        cartItem: List.from(currentState.cartItem)..add(event.cartItem),
      );
    } catch(_) {
      yield CartError();
    }
  }
}