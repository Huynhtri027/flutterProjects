part of 'products_bloc.dart';

@immutable
abstract class ProductsState extends Equatable{
  const ProductsState();
  
}

class ProductsLoading extends ProductsState {

  @override
  List<Object> get props => [props];

  @override
  String toString() {
    return 'Products are loading';
  }
}

class ProductsLoaded extends ProductsState {
  final Products product;
  
  const ProductsLoaded(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() {
    return 'Products are loaded';
  }
}

class ProductError extends ProductsState {
  @override
  List<Object> get props => [];
}