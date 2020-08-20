part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent extends Equatable{
  const ProductsEvent();
  
  @override
  List<Object> get props => [];
}

class ProductLoadedEvent extends ProductsEvent {

  @override
  String toString() {
    return 'HomeBlocLoadEvent';
  }
}