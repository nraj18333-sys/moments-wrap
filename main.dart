import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MomentsWrapApp());
}
  
  



class Product {
  final String name, category, description, image;
  final int price;
  Product({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.image = '',
  });
}

class MomentsWrapApp extends StatefulWidget {
  const MomentsWrapApp({super.key});
  @override
  State<MomentsWrapApp> createState() => _MomentsWrapAppState();
}
@override
void initState() {
  super.initState();
  _loadProducts();
}

Future<void> _loadProducts() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('products').get();

  if (snapshot.docs.isEmpty) return;

  setState(() {
    products
      ..clear()
      ..addAll(
        snapshot.docs.map((doc) {
          final data = doc.data();
          return Product(
            name: data['name'] ?? '',
            category: data['category'] ?? 'Gifts',
            description: data['description'] ?? '',
            price: data['price'] ?? 0,
            image: data['image'] ?? '',
          );
        }),
      );
  });
}
  final List<Product> products = [
    Product(
      name: 'Red Velvet Temple',
      category: 'Gifts',
      description: 'Red velvet gift item.',
      price: 999,
      image: 'assets/image-1790840579849.jpg',
    ),
    Product(
      name: 'Wooden Night Lamp',
      category: 'Gifts',
      description: 'Wooden night lamp gift.',
      price: 449,
      image: 'assets/image-1790840716118.jpg',
    ),
    Product(
      name: 'Couples Gifts',
      category: 'Gifts',
      description: 'Couples gift.',
      price: 1799,
      image: 'assets/image-1790840829591.jpg',
    ),
    Product(
      name: 'Daughter and Mother Gifts',
      category: 'Gifts',
      description: 'Gift for daughter and mother.',
      price: 1799,
      image: 'assets/image-1790840922811.jpg',
    ),
    Product(
      name: 'Son and Mother Gifts',
      category: 'Gifts',
      description: 'Gift for son and mother.',
      price: 1449,
      image: 'assets/image-1790841236013.jpg',
    ),
    Product(
      name: 'Couple Gifts',
      category: 'Gifts',
      description: 'Couple gift.',
      price: 1449,
      image: 'assets/image-1790841123687.jpg',
    ),
    Product(
      name: 'Cute Couple Gifts',
      category: 'Gifts',
      description: 'Cute couple gift.',
      price: 1190,
      image: 'assets/image-1790841428545.jpg',
    ),
    Product(
      name: 'Son and Mother Gifts',
      category: 'Gifts',
      description: 'Son and mother gift design.',
      price: 1799,
    ),
    Product(
      name: 'Pen Stand Apple Design',
      category: 'Gifts',
      description: 'Apple design pen stand.',
      price: 549,
      image: 'assets/image-1790841374889.jpg',
    ),
    Product(
      name: 'Couple Gift',
      category: 'Gifts',
      description: 'Couple gift.',
      price: 1249,
      image: 'assets/image-1790841174636.jpg',
    ),
    Product(
      name: 'Bangle Ceramic',
      category: 'Gifts',
      description: 'Ceramic bangle.',
      price: 349,
      image: 'assets/image-1790841488306.jpg',
    ),
    Product(
      name: 'Custom Product Hamper',
      category: 'Hampers',
      description: 'Shoes or cosmetic product hamper with full customisation. Making charge ₹699 each.',
      price: 699,
      image: 'assets/IMG-20261001-WA0024.jpg',
    ),

    
  

  

  

  
  
  

  



  

  

  

  

  



  

  

  


  

  

  

  
    
      
    
      
    
    
  ];
class _MomentsWrapAppState extends State<MomentsWrapApp> {
  @override
void initState() {
  ...
}

Future<void> _loadProducts() async {
  ...
  }
  final List<Product> cart = [];
  final List<Product> orders = [];
  int tab = 0;

  void addToCart(Product p) {
    setState(() => cart.add(p));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${p.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOMENTS WRAP',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF9F7F8),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3F78)),
      ),
      home: Scaffold(
        body: SafeArea(child: _page()),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Products'),
            NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
            NavigationDestination(icon: Icon(Icons.admin_panel_settings_outlined), selectedIcon: Icon(Icons.admin_panel_settings), label: 'Admin'),
          ],
        ),
      ),
    );
  }

  Widget _page() {
    switch (tab) {
      case 1: return ProductsPage(products: products, onAdd: addToCart);
      case 2: return CartPage(cart: cart, onCheckout: _checkout);
      case 3: return OrdersPage(orders: orders);
      case 4: return AdminPage(onAdd: (p) => setState(() => products.add(p)));
      default: return HomePage(products: products, onAdd: addToCart);
    }
  }

  void _checkout() {
    if (cart.isEmpty) return;
    setState(() {
      orders.addAll(cart);
      cart.clear();
      tab = 3;
    });
  }
}

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
    child: Row(
      children: [
        const Icon(Icons.auto_awesome, color: Color(0xFFFF3F78)),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800))),
      ],
    ),
  );
}

class HomePage extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onAdd;
  const HomePage({super.key, required this.products, required this.onAdd});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Image.asset('assets/moments_wrap_logo.jpg', height: 180, fit: BoxFit.cover),
      ),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF17171A),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('MOMENTS WRAP', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text('FLOWERS | CAKE | DECOR | GIFTS | HAMPERS',
            style: TextStyle(color: Color(0xFFFF6B96), fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          Text('Make Every Moment Special', style: TextStyle(color: Colors.white, fontSize: 18)),
        ]),
      ),
      const SizedBox(height: 20),
      const Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: ['Flowers','Cakes','Decor','Gifts','Hampers']
        .map((x) => Chip(label: Text(x), avatar: const Icon(Icons.card_giftcard, size: 18))).toList()),
      const SizedBox(height: 20),
      const Text('Featured Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      ...products.take(4).map((p) => ProductCard(product: p, onAdd: onAdd)),
    ],
  );
}

class ProductsPage extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onAdd;
  const ProductsPage({super.key, required this.products, required this.onAdd});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Header(title: 'All Products'),
      Wrap(spacing: 8, children: ['All','Flowers','Cakes','Decor','Gifts','Hampers']
        .map((x) => FilterChip(label: Text(x), selected: x == 'All', onSelected: (_) {})).toList()),
      const SizedBox(height: 10),
      ...products.map((p) => ProductCard(product: p, onAdd: onAdd)),
    ],
  );
}

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function(Product) onAdd;
  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Container(
          width: 90, height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFFFE7EE),
          ),
      child: product.image.isNotEmpty
    ? Image.asset(product.image, fit: BoxFit.cover)
    : const Icon(Icons.card_giftcard),
     ), 
        
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Text(product.category, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          Text('₹${product.price}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        ])),
        FilledButton(onPressed: () => onAdd(product), child: const Text('Add')),
      ]),
    ),
  );
}

class CartPage extends StatelessWidget {
  final List<Product> cart;
  final VoidCallback onCheckout;
  const CartPage({super.key, required this.cart, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final total = cart.fold<int>(0, (s, p) => s + p.price);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Header(title: 'My Cart'),
        if (cart.isEmpty) const Padding(
          padding: EdgeInsets.all(40),
          child: Center(child: Text('Your cart is empty')),
        ),
        ...cart.map((p) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.card_giftcard)),
          title: Text(p.name),
          subtitle: Text('₹${p.price}'),
        )),
        if (cart.isNotEmpty) ...[
          const Divider(),
          Text('Total: ₹$total', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(height: 52, child: FilledButton(
            onPressed: onCheckout,
            child: const Text('Proceed to Checkout'),
          )),
        ],
      ],
    );
  }
}

class OrdersPage extends StatelessWidget {
  final List<Product> orders;
  const OrdersPage({super.key, required this.orders});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Header(title: 'My Orders'),
      if (orders.isEmpty) const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: Text('No orders yet')),
      ),
      ...orders.asMap().entries.map((e) => Card(
        child: ListTile(
          leading: const Icon(Icons.local_shipping_outlined),
          title: Text(e.value.name),
          subtitle: Text('Order #MW${1000 + e.key}  •  Processing'),
          trailing: Text('₹${e.value.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      )),
    ],
  );
}

class AdminPage extends StatefulWidget {
  final void Function(Product) onAdd;
  const AdminPage({super.key, required this.onAdd});
  @override State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final name = TextEditingController();
  final price = TextEditingController();
  final desc = TextEditingController();
  String category = 'Gifts';

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Header(title: 'Admin Panel'),
      const Text('Add New Product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: category,
        decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
        items: ['Flowers','Cakes','Decor','Gifts','Hampers'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
        onChanged: (v) => setState(() => category = v!),
      ),
      const SizedBox(height: 12),
      TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      TextField(controller: desc, maxLines: 3, decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
      const SizedBox(height: 18),
      SizedBox(height: 52, child: FilledButton.icon(
        onPressed: () {
          final p = Product(
            name: name.text.trim().isEmpty ? 'New Gift Product' : name.text.trim(),
            category: category,
            description: desc.text.trim(),
            price: int.tryParse(price.text) ?? 0,
          );
          widget.onAdd(p);
          name.clear(); price.clear(); desc.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added')));
        },
        icon: const Icon(Icons.add),
        label: const Text('Save Product'),
      )),
      const SizedBox(height: 20),
      const Text('Next phase: image upload, database, customer login, address, UPI/card payment and live order management.',
        style: TextStyle(color: Colors.grey)),
    ],
  );
}
