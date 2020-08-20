import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingCart/blocs/bloc/products_bloc.dart';
import 'package:shoppingCart/widgets/pdt_item.dart';
//import '../models/products.dart';
//import './pdt_item.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsLoading) {
        return CircularProgressIndicator();
      }
      if (state is ProductsLoaded) {
       return GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.product.items.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext ctx, int i){
              //value: state.product.items[i]
              return PdtItem(
                name: state.product.items[i].name,
                imageUrl: state.product.items[i].imgUrl,
              );},
        );
      }
    });
    //final productData=Provider.of<Products>(context);
    //final pdts=productData.items;
    // return GridView.builder(
    //   physics: ScrollPhysics(),
    //   shrinkWrap: true,
    //   itemCount: pdts.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //   itemBuilder: (ctx, i)=>ChangeNotifierProvider.value(value: pdts[i],
    //   child: PdtItem(name: pdts[i].name,imageUrl: pdts[i].imgUrl,)),
    // );
  }
}
