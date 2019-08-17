

import 'model.dart';


 /// This is the Controller class which represents
 /// the controller according to MVC (Model - View - Controller).
 /// It communicates with the model and brings data to
 /// the UI.
class Controller{

  /// The Customer object.
  Customer _customer;

  /// List of Product objects.
  List<Product> _products;

  ///List of Product objects which
  ///represents the products which
  ///have offers.
  List<Product> _offers;

  ///List of Sector objects
  List<Sector> _sectors;

  /// Colors dictionary.
  Map<int, String> colors = {
    0xff24c34f : 'Green',
    0xfffef200 : 'Yellow',
    0xffff2851 : 'Fuscia',
    0xff0076fe : 'Blue',
    0xff231f20 : 'Black',
    0xffffffff : 'White',
    0xff66d3f4 : 'Sky',
    0xfffd0003 : 'Red',
    0xffa5238d : 'Purple',
    0xffff96db : 'Fushia',
    0xffff9600 : 'Pink',
    0xff01b0b3 : 'Arctic',
  };

  /// Gets the color name from the color map.
  String getColorName(int colorCode){
    return colors[colorCode];
  }

  Controller(){
    _products = List();
    _offers = List();
    _sectors = List();
  }

  /// Initialize the Customer object.
  initCustomer(int id, String firstName, String lastName, String email, String phone){
    _customer = Customer(id, firstName, lastName, email, phone);
    _testData();
  }

  initCustomerFromJson(Map json){
    _customer = Customer.fromJson(json);
    _testData();
  }

  ///Adds a product to the customer's wishlist.
  addToWishList(Product product){
    if(_customer != null)
      _customer.wishList.add(product);
  }

  ///Removes a product from the customer's wishlist.
  removeFromWishList(Product product){
    if(_customer != null){
      _customer.wishList.remove(product);
    }
  }

  ///Adds a product with specified quantitiy to
  ///the customer's cart.
  addToCart(Product product, int quantity){
    CartItem item = CartItem(_customer.cart.length, product, quantity);
    bool _added = false;
    if(_customer != null){
      for (int i = 0; i < _customer.cart.length ; i++){
        if(_customer.cart[i].product == product){
          _added = true;
          break;
        }
      }
      if(!_added){
        _customer.cart.add(item);
      }
    }

  }

  ///Removes a product from
  ///the customer's cart.
  removeFromCart(Product product){
    if(_customer != null){
      for (int i = 0; i < _customer.cart.length; i++){
        if(_customer.cart[i].product.id == product.id){
          _customer.cart.remove(_customer.cart[i]);
          break;
        }
      }

    }
  }

  ///Adds an address to the customer's
  ///addresses list.
  addAddress(Address address){
    if(_customer != null)
      _customer.addresses.add(address);
  }

  ///Removes an address from the customer's
  ///addresses list
  removeAddress(Address address){
    if(_customer != null){
      _customer.addresses.remove(address);
    }
  }

  ///Adds an order to the customer's
  ///orders list
  addOrder (Order order){
    if (_customer != null)
      _customer.orders.add(order);
  }

  ///Removes an order from the customer's
  ///orders list
  removeOrder(Order order){
    if(_customer != null){
      _customer.orders.remove(order);
    }
  }

  ///Gets the products list.
  List<Product> get products => _products;

  ///Gets the Customer object.
  Customer get customer => _customer;

  ///Gets a product by its ID.
  Product getProductById(int id){
    Product _product;
    for(int i = 0; i < _products.length ; i++){
      if(_products[i].id == id){
        _product = _products[i];
        break;
      }
    }
    return _product;
  }

  ///Gets an address by its ID.
  Address getAddressById(int id){
    Address address;
    for(int i = 0; i < _customer.addresses.length ; i++){
      if(_customer.addresses[i].id == id){
        address = _customer.addresses[i];
        break;
      }
    }
    return address;
  }

  ///Gets an order by its ID.
  Order getOrderById(int id){
    Order order;
    for(int i = 0; i < _customer.orders.length ; i++){
      if(_customer.orders[i].id == id){
        order = _customer.orders[i];
        break;
      }
    }
    return order;
  }

  ///Gets an item from the customer's
  ///cart using the cart item's ID.
  CartItem getCartItemById (int id){
    CartItem item;
    for(int i =0 ; i < _customer.cart.length; i++){
      if(_customer.cart[i].id == id){
        item = _customer.cart[i];
        break;
      }
    }
    return item;
  }

  ///Gets the offers list.
  List<Product> get offers => _offers;


  ///Gets the sectors list ..
  List<Sector> get sectors => _sectors;
//
//  int getSectorId (int sectorIndex) => _sectors[sectorIndex].id;
//
//  String getSectorName(int sectorIndex) => _sectors[sectorIndex].name;
//
//  String getSectorImageUrl(int sectorIndex) => _sectors[sectorIndex].imageUrl;

  ///Increases the quantity of items in
  ///the customer's cart.
  increaseCartItemQuantity(CartItem item){
    int quantity = item.quantity + 1;
    item.quantity = quantity;
  }

  ///Decreases the quantity of items in
  ///the customer's cart.
  decreaseCartItemQuantity(CartItem item){
    if(item.quantity > 1){
      int quantity = item.quantity - 1;
      item.quantity = quantity;
    }
  }

  ///Does the customer's cart contain
  ///the product whose id is the
  ///productId?
  bool containsCartItem(int productId){
    bool value = false;

    for (int i = 0; i < _customer.cart.length ; i++){
      if(_customer.cart[i].product.id == productId){
        value = true;
        break;
      }
    }
    return value;
  }

  ///Calculates the total price of the
  ///items in the customer's cart and
  ///returns it.
  double calculateTotalPrice(){
    double sum = 0;

    for(int i = 0; i < _customer.cart.length ; i ++){
      //print('Item price: ${_customer.cart[i].product.price}');
      if(_customer.cart[i].product.discountPecentage < 100){
        double discount = _customer.cart[i].product.price * (_customer.cart[i].product.discountPecentage / 100)  ;
        sum = sum +  ((_customer.cart[i].product.price - discount) * _customer.cart[i].quantity);
      } else {
        sum = sum +  (_customer.cart[i].product.price * _customer.cart[i].quantity);
      }

    }
    return sum;
  }

  populateSectors(List list) {
    for(int i = 0; i < list.length ; i++){
      _sectors.add(Sector.fromJson(list[i]));
    }
  }

  populateCategories(int sectorIndex, List list){
    for(int i = 0; i < list.length ; i++){
      _sectors[sectorIndex].categories.add(Category.fromJson(list[i]));
    }
  }

//  populateProducts(int sectorIndex, int categoryIndex, List list) async {
//    for(int i = 0; i < list.length; i++){
//      //_sectors[sectorIndex].categories[categoryIndex].products.add(value)
//    }
//  }

  ///It's just test data to populate
  ///fields and objects as there is no
  ///ready API for the project
  _testData(){
    final addresses = [
      Address(1, '40, The 10th District, Nasr City', 'First Floor, Suite 3',
          '+201118301953', 'Nasr City', 'Cairo', 'Egypt'),
      Address(2, '100, Al-Maadi', '', '+201118551353', 'Al-Maadi', 'Cairo', 'Egypt'),
    ];
    _customer.addresses.add(addresses[0]);
    _customer.addresses.add(addresses[1]);

    final orders = [
      Order(10023, 'Pending', DateTime.utc(2019, 4, 20)),
      Order(10006, 'On Way', DateTime.utc(2019, 4, 19)),
      Order(10023, 'Delivered', DateTime.utc(2019, 3, 25)),
    ];

    _customer.orders.add(orders[0]);
    _customer.orders.add(orders[1]);
    _customer.orders.add(orders[2]);

    final products = [
      Product(1, 'White Dress', 'https://i.ebayimg.com/thumbs/images/g/euMAAOSwwXRcejsR/s-l225.jpg',100 , 0xffffffff, 'L', 100),
      Product(2, 'White Dress', 'https://i.ebayimg.com/thumbs/images/g/euMAAOSwwXRcejsR/s-l225.jpg',100 , 0xffffffff, 'L', 25),
      Product(3, 'Black Clothes', 'https://images-na.ssl-images-amazon.com/images/I/81OVTBVzAYL._UX569_.jpg', 70, 0xfffef200, 'XL', 100),
      Product(4, 'Sky Blue Clothes', 'https://images-na.ssl-images-amazon.com/images/I/61iRHYXKCBL._UX679_.jpg', 80, 0xff66d3f4, 'M', 100),
      Product(5, 'Sky Blue Clothes', 'https://images-na.ssl-images-amazon.com/images/I/61iRHYXKCBL._UX679_.jpg', 80, 0xff66d3f4, 'M', 10),
      Product(6, 'Blue Clothes', 'https://images-na.ssl-images-amazon.com/images/I/81%2BsN7uMPHL._UX385_.jpg', 90, 0xff0076fe, 'XXL', 100),
      Product(7, 'Blue Clothes', 'https://images-na.ssl-images-amazon.com/images/I/81%2BsN7uMPHL._UX385_.jpg', 90, 0xff0076fe, 'XXL', 15),
    ];

    _products.add(products[0]);
    _products.add(products[1]);
    _products.add(products[2]);
    _products.add(products[3]);
    _products.add(products[4]);
    _products.add(products[5]);
    _products.add(products[6]);

    for(int i = 0; i < _products.length; i++){
      if(_products[i].discountPecentage < 100){
        _offers.add(_products[i]);
      }
    }
  }


}