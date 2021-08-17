import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kaykommerce/models/order.dart';
import 'package:kaykommerce/ui/views/orders/orders_view_model.dart';
import 'package:kaykommerce/ui/widgets/kayko_text.dart';
import 'package:stacked/stacked.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrdersViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.getUserOrder(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        body: viewModel.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: viewModel.userOrders.length,
                itemBuilder: (context, index) {
                  var order = viewModel.userOrders[index];
                  return OrderWidget(order: order);
                },
              ),
      ),
      viewModelBuilder: () => OrdersViewModel(),
    );
  }
}

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$ ${widget.order.amount} USD'),
          subtitle: KaykoText.caption('${widget.order.dateTime}'),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            height: min(widget.order.products.length * 80, 150),
            child: ListView(
              children: widget.order.products
                  .map(
                    (product) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KaykoText.body(product.name),
                        KaykoText.body(
                          '${product.quantity} x ${product.currentPrice}',
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
      ]),
    );
  }
}
