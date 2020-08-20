import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppingCart/models/products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsLoading());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is ProductLoadedEvent){
       yield* _mapProductLoadedEventToState();
    }
  }

  Stream<ProductsState> _mapProductLoadedEventToState() async* {
    yield ProductsLoading();
    try {
      yield ProductsLoaded(Products());
    } catch(_) {
      yield ProductError();
    }
  }
}
