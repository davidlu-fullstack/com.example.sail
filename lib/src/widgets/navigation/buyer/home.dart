import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/buyer_bloc.dart';

class BuyerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buyerBloc = Provider.of<BuyerBloc>(context);
    return Scaffold(
      body: pageBody(buyerBloc, context),
    );
  }

  Widget pageBody(BuyerBloc buyerBloc, BuildContext context) {
    return Center(child: Text('Buyer Home'));
  }
}
