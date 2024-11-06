import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/controller/addtocart_screen_controller.dart';
import 'package:shoppingcart/controller/product_detailsScreen_controller.dart';
import 'package:shoppingcart/utils/constants/color_constants.dart';
import 'package:shoppingcart/view/addtocart_screen/addtocart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  int productid;
  ProductDetailScreen({super.key, required this.productid});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context
            .read<ProductDetailsscreenController>()
            .getProductDetails(widget.productid);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
              color: ColorConstants.blackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 35,
                ),
                Positioned(
                  top: 4, // Adjust this value as needed for exact alignment
                  right: 2,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: ColorConstants.blackcolor,
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.whitecolor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<ProductDetailsscreenController>(
          builder: (context, productdetailobj, child) =>
              productdetailobj.isLogined
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  productdetailobj.product?.image ??
                                      'No Image'.toString(),
                                  height: 500,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: 25,
                                  top: 28,
                                  child: Container(
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 30,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorConstants.whitecolor),
                                    height: 50,
                                    width: 50,
                                  )),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            productdetailobj.product?.title ??
                                'No title'.toString(),
                            style: TextStyle(
                                color: ColorConstants.blackcolor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              RatingBar.readOnly(
                                size: 20,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                initialRating:
                                    productdetailobj.product?.rating?.rate ?? 0,
                                maxRating: 5,
                              ),
                              // Icon(
                              //   Icons.star,
                              //   color: ColorConstants.yellowcolor,
                              // ),
                              SizedBox(width: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${productdetailobj.product?.rating?.rate ?? 'No Rating'.toString()}/5',
                                      style: TextStyle(
                                          color: ColorConstants.blackcolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    TextSpan(
                                      text:
                                          ' (${productdetailobj.product?.rating?.count ?? 'No Rating'.toString()} reviews)',
                                      style: TextStyle(
                                          color: ColorConstants.greycolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            productdetailobj.product?.description ??
                                'No Rating'.toString(),
                            style: TextStyle(
                              color: ColorConstants.greycolor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Choose size',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: ColorConstants.blackcolor),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'S',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.blackcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConstants.greycolor,
                                    )),
                              ),
                              SizedBox(width: 8),
                              Container(
                                child: Center(
                                  child: Text(
                                    'M',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.blackcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConstants.greycolor,
                                    )),
                              ),
                              SizedBox(width: 8),
                              Container(
                                child: Center(
                                  child: Text(
                                    'L',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.blackcolor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConstants.greycolor,
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
        ),
      ),
      bottomNavigationBar: Consumer<ProductDetailsscreenController>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 26),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                        color: ColorConstants.greycolor,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PKR ${value.product?.price}',
                    style: TextStyle(
                        color: ColorConstants.blackcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  context
                      .read<AddtocartScreenController>()
                      .addProducttocart(value.product!);
                  context.read<AddtocartScreenController>().getproduct();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddtocartScreen(),
                      ));
                },
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: ColorConstants.whitecolor,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: ColorConstants.whitecolor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      )
                    ],
                  ),
                  width: 170,
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorConstants.blackcolor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
