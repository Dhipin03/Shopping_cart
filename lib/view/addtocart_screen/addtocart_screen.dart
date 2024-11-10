import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingcart/controller/addtocart_screen_controller.dart';
import 'package:shoppingcart/utils/constants/color_constants.dart';

class AddtocartScreen extends StatefulWidget {
  const AddtocartScreen({super.key});

  @override
  State<AddtocartScreen> createState() => _AddtocartScreenState();
}

class _AddtocartScreenState extends State<AddtocartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<AddtocartScreenController>().getproduct();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
              color: ColorConstants.blackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
      ),
      body: Consumer<AddtocartScreenController>(
        builder: (context, providerobj, child) => Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
              itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.greycolor.withOpacity(0.2)),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(providerobj
                                              .addeditem?[index]?['image']
                                              ?.toString() ??
                                          ''))),
                              height: 85,
                              width: 85,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    providerobj.addeditem?[index]?['name']
                                            ?.toString() ??
                                        '',
                                    style: TextStyle(
                                        color: ColorConstants.blackcolor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    'PKR,${providerobj.addeditem?[index]?['amount']?.toString() ?? ''}',
                                    style: TextStyle(
                                        color: ColorConstants.blackcolor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      providerobj.incrementquantity(
                                          currentqty: providerobj
                                              .addeditem?[index]?['quantity'],
                                          id: providerobj.addeditem?[index]
                                              ?['id']);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: ColorConstants.blackcolor,
                                    )),
                                Text(
                                  providerobj.addeditem?[index]?['quantity']
                                          .toString() ??
                                      ''
                                          '',
                                  style: TextStyle(
                                      color: ColorConstants.blackcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      providerobj.decerementquantity(
                                          currentqty: providerobj
                                              .addeditem?[index]?['quantity'],
                                          id: providerobj.addeditem?[index]
                                              ?['id']);
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: ColorConstants.blackcolor,
                                    )),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    providerobj.removeitem(
                                        providerobj.addeditem?[index]?['id']);
                                  },
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                        color: ColorConstants.blackcolor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: providerobj.addeditem.length),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      color: ColorConstants.blackcolor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
                Text(
                  'PKR ${context.watch<AddtocartScreenController>().totalamount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: ColorConstants.blackcolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                context.read<AddtocartScreenController>().paymentmethod();
              },
              child: Container(
                child: Row(
                  children: [
                    Text(
                      'CHECKOUT',
                      style: TextStyle(
                          color: ColorConstants.whitecolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.shopping_cart,
                      color: ColorConstants.whitecolor,
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                    color: ColorConstants.blackcolor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: ColorConstants.greycolor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20)),
        height: 100,
        width: double.infinity,
      ),
    );
  }
}
