class Products {
  String? productID;
  String? productName;
  String? productPrice;
  String? totalNumberofItemsInStock;

  Products(); // Default Constructor

  // Map Constructor
  Map<String, dynamic> toJson() => {
        'productID': productID,
        'productName': productName,
        'productPrice': productPrice,
        'totalNumberofItemsInStock': totalNumberofItemsInStock,
      };

  Products.fromSnapshot(snapshot)
      : productID = snapshot['productID'],
        productName = snapshot['productName'],
        productPrice = snapshot['productPrice'],
        totalNumberofItemsInStock = snapshot['totalNumberofItemsInStock'];
}
