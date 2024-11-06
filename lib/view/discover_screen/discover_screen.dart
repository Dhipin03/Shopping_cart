import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/controller/addtocart_screen_controller.dart';
import 'package:shoppingcart/controller/discover_screen_controller.dart';
import 'package:shoppingcart/utils/constants/color_constants.dart';
import 'package:shoppingcart/view/product_detail_screen/product_detail_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<DiscoverScreenController>().getAllproducts();
        context.read<DiscoverScreenController>().getcategory();
        context.read<AddtocartScreenController>().initdb();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.whitecolor,
        title: Text(
          'Discover',
          style: TextStyle(
              color: ColorConstants.blackcolor,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 30,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      child: Text(
                        '1',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.whitecolor,
                            fontSize: 10),
                      ),
                      radius: 8,
                      backgroundColor: ColorConstants.blackcolor,
                    )),
              ],
            ),
          )
        ],
      ),
      body: Consumer<DiscoverScreenController>(
        builder: (context, providerobj, child) => providerobj.isLogined
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: ColorConstants.whitecolor,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search anything',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.greycolor),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                                fillColor:
                                    ColorConstants.greycolor.withOpacity(0.2),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            child: Icon(
                              Icons.filter_list,
                              color: ColorConstants.whitecolor,
                            ),
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: ColorConstants.blackcolor,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 5),
                        itemCount: providerobj.categorylist.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            context
                                .read<DiscoverScreenController>()
                                .onCategorySelection(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                                color: context
                                            .watch<DiscoverScreenController>()
                                            .selectedCategoryindex ==
                                        index
                                    ? ColorConstants.blackcolor
                                    : ColorConstants.greycolor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 25),
                            child: Text(
                              providerobj.categorylist[index].toString(),
                              style: TextStyle(
                                  color: context
                                              .watch<DiscoverScreenController>()
                                              .selectedCategoryindex ==
                                          index
                                      ? ColorConstants.whitecolor
                                      : ColorConstants.blackcolor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: providerobj.isProductLogined
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Consumer<DiscoverScreenController>(
                                builder: (context, providerobj, child) =>
                                    GridView.builder(
                                  itemCount: providerobj.productlist.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              0.654, // Adjusted for better display
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 5),
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      if (providerobj.productlist[index].id !=
                                          null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen(
                                                productid: providerobj
                                                    .productlist[index].id!,
                                              ),
                                            ));
                                      }
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height:
                                                    153, // Fixed height for the image container
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    providerobj
                                                        .productlist[index]
                                                        .image
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 10,
                                                top: 10,
                                                child: Container(
                                                  child: Icon(Icons
                                                      .favorite_border_outlined),
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .whitecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  8), // Space between image and text
                                          Text(
                                            providerobj.productlist[index].title
                                                    .toString() ??
                                                'No Image',
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.blackcolor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'PKR ${providerobj.productlist[index].price.toString()}',
                                            style: TextStyle(
                                                color: ColorConstants.greycolor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.blackcolor,
        unselectedItemColor: ColorConstants.blackcolor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home, color: ColorConstants.blackcolor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined,
                color: ColorConstants.blackcolor),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: ColorConstants.blackcolor),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: ColorConstants.blackcolor),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
