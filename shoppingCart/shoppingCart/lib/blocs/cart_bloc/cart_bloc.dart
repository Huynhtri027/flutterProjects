import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppingCart/models/item.dart';

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
      yield* _mapCartItemAddedToState(state, event);
    }
  }
}

Stream<CartState> _mapCartStartedToState() async* {
  yield CartLoading();
  try {
    yield CartLoaded(cartItem: []);
  } catch (_) {
    yield CartError();
  }
}

Stream<CartState> _mapCartItemAddedToState(
    CartState state, CartItemAdded event) async* {
  final currentState = state;
  if (currentState is CartLoaded) {
    try {
      if (currentState.cartItem.length > 0) {
        for (int i = 0; i < currentState.cartItem.length; i++) {
          if (currentState.cartItem[i].id.contains(event.cartItem.id)) {
            print("Removed at" + currentState.cartItem[i].id);
            currentState.cartItem.removeAt(i);
            yield CartLoaded(
              cartItem: List.from(currentState.cartItem)..add(event.cartItem),
            );
          } else {
            //print("Added first item");
            yield CartLoaded(
              cartItem: List.from(currentState.cartItem)..add(event.cartItem),
            );
            print("Got the new item");
          }
        }
      } else {
        yield CartLoaded(
          cartItem: List.from(currentState.cartItem)..add(event.cartItem),
        );
        print("Added first item");
      }
    } catch (_) {
      yield CartError();
    }
  }
}
