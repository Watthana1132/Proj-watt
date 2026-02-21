import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// ---------------------------
/// Branch mapping
/// ---------------------------
const Map<String, String> branchNameByCode = {
  '0001': 'สาขาดาวคะนอง',
  '0002': 'สาขาสยามพารากอน',
  '0003': 'สาขาเซ็นทรัล ลาดพร้าว',
  '0004': 'สาขาเอกมัย',
  '0005': 'สาขาทองหล่อ',
  '0006': 'สาขาพระราม 3',
  '0007': 'สาขาพระราม 9',
  '0008': 'สาขาบางแค',
  '0009': 'สาขาปิ่นเกล้า',
  '0010': 'สาขาบางกะปิ',
  '0011': 'สาขาสะพานควาย',
  '0012': 'สาขาอารีย์',
  '0013': 'สาขาดินแดง',
  '0014': 'สาขาห้วยขวาง',
  '0015': 'สาขาสุทธิสาร',
  '0016': 'สาขาโชคชัย 4',
  '0017': 'สาขาลาดพร้าว 71',
  '0018': 'สาขาวังหิน',
  '0019': 'สาขานวมินทร์',
  '0020': 'สาขารามอินทรา',
  '0021': 'สาขาวัชรพล',
  '0022': 'สาขาสายไหม',
  '0023': 'สาขาดอนเมือง',
  '0024': 'สาขาหลักสี่',
  '0025': 'สาขาตลิ่งชัน',
  '0026': 'สาขาพุทธมณฑล สาย 4',
  '0027': 'สาขามีนบุรี',
  '0028': 'สาขาหนองจอก',
  '0029': 'สาขาประเวศ',
  '0030': 'สาขาบางนา-ตราด',
  '0031': 'สาขาสำโรง',
  '0032': 'สาขาปากน้ำ',
  '0033': 'สาขาศรีนครินทร์',
  '0034': 'สาขาเทพารักษ์',
  '0035': 'สาขาแพรกษา',
  '0036': 'สาขาบางบัวทอง',
  '0037': 'สาขาแจ้งวัฒนะ',
  '0038': 'สาขารัตนาธิเบศร์',
  '0039': 'สาขาติวานนท์',
  '0040': 'สาขาปากเกร็ด',
  '0041': 'สาขารังสิต-คลอง 1',
  '0042': 'สาขาธัญบุรี',
  '0043': 'สาขาลำลูกกา',
  '0044': 'สาขานวนคร',
  '0045': 'สาขาสามพราน',
  '0046': 'สาขามหาชัย',
  '0047': 'สาขากระทุ่มแบน',
  '0048': 'สาขาอ้อมน้อย',
  '0049': 'สาขาศาลายา',
  '0050': 'สาขาบางใหญ่',
  '0051': 'สาขาอโศก',
  '0052': 'สาขาสีลม',
  '0053': 'สาขาสาทร',
  '0054': 'สาขาเยาวราช',
  '0055': 'สาขาอนุสาวรีย์ชัยฯ',
  '0056': 'สาขาประตูน้ำ',
  '0057': 'สาขาคลองเตย',
  '0058': 'สาขาพระโขนง',
  '0059': 'สาขาบางจาก',
  '0060': 'สาขาอ่อนนุช',
  '0061': 'สาขาอุดมสุข',
  '0062': 'สาขาลาซาล',
  '0063': 'สาขาแบริ่ง',
  '0064': 'สาขาเมกาบางนา',
  '0065': 'สาขาไอคอนสยาม',
  '0066': 'สาขาเอเชียทีค',
  '0067': 'สาขาเซ็นทรัลเวิลด์',
  '0068': 'สาขามาบุญครอง',
  '0069': 'สาขาจตุจักร',
  '0070': 'สาขาหมอชิต',
  '0071': 'สาขาชลบุรี',
  '0072': 'สาขาพัทยา',
  '0073': 'สาขาศรีราชา',
  '0074': 'สาขาบางแสน',
  '0075': 'สาขาระยอง',
  '0076': 'สาขาบ่อวิน',
  '0077': 'สาขาปลวกแดง',
  '0078': 'สาขาฉะเชิงเทรา',
  '0079': 'สาขาบางปะกง',
  '0080': 'สาขาอยุธยา',
  '0081': 'สาขาโรจนะ',
  '0082': 'สาขาสระบุรี',
  '0083': 'สาขาแก่งคอย',
  '0084': 'สาขาลพบุรี',
  '0085': 'สาขานครปฐม',
  '0086': 'สาขากำแพงแสน',
  '0087': 'สาขาราชบุรี',
  '0088': 'สาขาบ้านโป่ง',
  '0089': 'สาขากาญจนบุรี',
  '0090': 'สาขาหัวหิน',
  '0091': 'สาขาเชียงใหม่',
  '0092': 'สาขาเชียงราย',
  '0093': 'สาขาพิษณุโลก',
  '0094': 'สาขานครสวรรค์',
  '0095': 'สาขาขอนแก่น',
  '0096': 'สาขาอุดรธานี',
  '0097': 'สาขาโคราช',
  '0098': 'สาขาอุบลราชธานี',
  '0099': 'สาขาภูเก็ต',
  '0100': 'สาขาหาดใหญ่',
};

String resolveBranchName(String code) => branchNameByCode[code] ?? 'สาขา $code';

/// ---------------------------
/// App
/// ---------------------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_ready) return;

    Future(() async {
      await precacheImage(const AssetImage('assets/images/login_bg.jpg'), context);
      await precacheImage(const AssetImage('assets/images/store_logo.png'), context);

      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Inventory',
      theme: ThemeData(useMaterial3: false),
      home: _ready
          ? const LoginPage()
          : const Scaffold(
        backgroundColor: Colors.pinkAccent,
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

/// ---------------------------
/// Models
/// ---------------------------
double _toDouble(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0;
}

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}

class Product {
  final String id;
  final String name;
  final int stockCount;
  final String category;
  final String aisle;
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.stockCount,
    required this.category,
    required this.aisle,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      stockCount: _toInt(json['stockCount']),
      category: (json['category'] ?? '').toString(),
      aisle: (json['aisle'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      price: _toDouble(json['price']),
    );
  }
}

class CartItem {
  final Product product;
  int qty;
  CartItem({required this.product, this.qty = 1});

  double get lineTotal => product.price * qty;
}

/// ---------------------------
/// Page 1: Login
/// ---------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameCtrl = TextEditingController();
  final _branchCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _branchCtrl.dispose();
    super.dispose();
  }

  void _go() {
    final name = _nameCtrl.text.trim();
    final branch = _branchCtrl.text.trim();

    if (name.isEmpty || branch.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกชื่อและรหัสสาขาร้านลุงแช่ม')),
      );
      return;
    }

    final normalizedBranch = branch.padLeft(4, '0');

    if (!branchNameByCode.containsKey(normalizedBranch)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('รหัสสาขาไม่ถูกต้อง (รองรับ 0001 - 0100)')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchPage(
          searcherName: name,
          branchCode: normalizedBranch,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แอปร้านลุงแช่ม'),
        backgroundColor: Colors.pink[300],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/login_bg.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/store_logo.png', fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.storefront, size: 64, color: Colors.pink[200]),
                      const SizedBox(height: 8),
                      const Text(
                        'ยินดีต้อนรับสู่ร้านลุงแช่ม',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'ชื่อคนที่ค้นหาของ',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _branchCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'รหัสสาขาร้านลุงแช่ม',
                          hintText: '0001 - 0100',
                          prefixIcon: Icon(Icons.store),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _go,
                          icon: const Icon(Icons.login),
                          label: const Text('เข้าร้านลุงแช่ม'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[600]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------
/// Page 2: Search
/// ---------------------------
enum SortBy { stockDesc, stockAsc, nameAsc, priceAsc, priceDesc }

class SearchPage extends StatefulWidget {
  final String searcherName;
  final String branchCode;

  const SearchPage({
    super.key,
    required this.searcherName,
    required this.branchCode,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> _products = [];
  List<Product> _filtered = [];

  String _selectedCategory = "ทั้งหมด";
  List<String> _categories = ["ทั้งหมด"];
  String _query = "";

  SortBy _sortBy = SortBy.stockDesc;

  final Map<String, CartItem> _cart = {}; // key = productId

  int get _cartCount => _cart.values.fold(0, (sum, e) => sum + e.qty);
  double get _cartTotal => _cart.values.fold(0, (sum, e) => sum + e.lineTotal);

  Future<void> _loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final dynamic decoded = json.decode(response);

    final List<dynamic> data = decoded is List ? decoded : <dynamic>[];

    final products =
    data.whereType<Map<String, dynamic>>().map((m) => Product.fromJson(m)).toList();

    final set = <String>{"ทั้งหมด"};
    for (final p in products) {
      if (p.category.trim().isNotEmpty) set.add(p.category);
    }

    setState(() {
      _products = products;
      _categories = set.toList();
      _applyFilter();
    });
  }

  void _applyFilter() {
    final q = _query.trim().toLowerCase();

    final list = _products.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(q);
      final matchesCategory = (_selectedCategory == "ทั้งหมด") || (p.category == _selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();

    switch (_sortBy) {
      case SortBy.stockDesc:
        list.sort((a, b) => b.stockCount.compareTo(a.stockCount));
        break;
      case SortBy.stockAsc:
        list.sort((a, b) => a.stockCount.compareTo(b.stockCount));
        break;
      case SortBy.nameAsc:
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortBy.priceAsc:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortBy.priceDesc:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    setState(() => _filtered = list);
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  void _addToCart(Product p) {
    setState(() {
      final existing = _cart[p.id];
      final currentQty = existing?.qty ?? 0;

      if (currentQty >= p.stockCount) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เพิ่มไม่ได้แล้ว: คงเหลือ ${p.stockCount} ชิ้น')),
        );
        return;
      }

      if (existing == null) {
        _cart[p.id] = CartItem(product: p, qty: 1);
      } else {
        existing.qty += 1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('โกยลงตะกร้า: ${p.name} (+1)')),
    );
  }

  void _openMiniDetail(Product p) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      p.imageUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.shopping_bag, size: 48, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('ล็อก: ${p.aisle} • หมวด: ${p.category}'),
                        const SizedBox(height: 4),
                        Text(
                          'คงเหลือ: ${p.stockCount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: p.stockCount > 0 ? Colors.pink[300] : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('ราคา:', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    '${p.price.toStringAsFixed(2)} บาท',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow[900]),
                  ),
                  const Spacer(),
                  Text('ในตะกร้า: ${_cart[p.id]?.qty ?? 0}'),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _addToCart(p);
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('ใส่ตะกร้า'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _goSummary() {
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ยังไม่มีสินค้าในตะกร้า')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryPage(
          searcherName: widget.searcherName,
          branchCode: widget.branchCode,
          cart: _cart,
          onCartChanged: () => setState(() {}),
          onFinishReset: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final branchName = resolveBranchName(widget.branchCode);

    return Scaffold(
      appBar: AppBar(
        title: Text('ร้านลุงแช่ม • $branchName'),
        backgroundColor: Colors.pink[300],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'ตะกร้า',
                  onPressed: _goSummary,
                  icon: Stack(
                    children: [
                      const Icon(Icons.shopping_cart, size: 26),
                      if (_cartCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$_cartCount',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (_cartTotal > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '${_cartTotal.toStringAsFixed(0)}฿',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      _query = val;
                      _applyFilter();
                    },
                    decoration: InputDecoration(
                      hintText: "ค้นหาสินค้า",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<SortBy>(
                  tooltip: 'เรียงลำดับ',
                  icon: const Icon(Icons.sort),
                  onSelected: (v) {
                    setState(() => _sortBy = v);
                    _applyFilter();
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: SortBy.stockDesc, child: Text('คงเหลือ: มาก → น้อย')),
                    PopupMenuItem(value: SortBy.stockAsc, child: Text('คงเหลือ: น้อย → มาก')),
                    PopupMenuItem(value: SortBy.nameAsc, child: Text('ชื่อสินค้า: ก → ฮ')),
                    PopupMenuItem(value: SortBy.priceAsc, child: Text('ราคา: ต่ำ → สูง')),
                    PopupMenuItem(value: SortBy.priceDesc, child: Text('ราคา: สูง → ต่ำ')),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: Colors.yellow[700],
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    onSelected: (_) {
                      setState(() => _selectedCategory = cat);
                      _applyFilter();
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: _filtered.isEmpty && _products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final p = _filtered[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    onTap: () => _openMiniDetail(p),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        p.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.shopping_bag, size: 40, color: Colors.grey),
                      ),
                    ),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("ล็อก: ${p.aisle} | ${p.category} | ${p.price.toStringAsFixed(0)}฿"),
                    trailing: Text(
                      "${p.stockCount}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: p.stockCount > 0 ? Colors.pink[400] : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _goSummary,
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('สรุปยอดสินค้า'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------
/// Page 3: Summary + QR Pay + Receipt Flow
/// ---------------------------
class SummaryPage extends StatefulWidget {
  final String searcherName;
  final String branchCode;
  final Map<String, CartItem> cart;
  final VoidCallback onFinishReset;
  final VoidCallback onCartChanged;

  const SummaryPage({
    super.key,
    required this.searcherName,
    required this.branchCode,
    required this.cart,
    required this.onFinishReset,
    required this.onCartChanged,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  List<CartItem> get cartList => widget.cart.values.toList();

  double get subtotal => cartList.fold(0, (sum, e) => sum + e.lineTotal);

  double get discount {
    final s = subtotal;
    if (s >= 1000) return s * 0.10;
    if (s >= 500) return s * 0.05;
    return 0;
  }

  String get promoText {
    final s = subtotal;
    if (s >= 1000) return 'โปรโมชัน: ลด 10% เมื่อครบ 1,000 บาท';
    if (s >= 500) return 'โปรโมชัน: ลด 5% เมื่อครบ 500 บาท';
    return 'โปรโมชัน: -';
  }

  void _incQty(String productId) {
    setState(() {
      final item = widget.cart[productId];
      if (item == null) return;

      if (item.qty >= item.product.stockCount) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เพิ่มไม่ได้แล้ว: คงเหลือ ${item.product.stockCount} ชิ้น')),
        );
        return;
      }
      item.qty += 1;
    });
    widget.onCartChanged();
  }

  void _decQty(String productId) {
    setState(() {
      final item = widget.cart[productId];
      if (item == null) return;

      item.qty -= 1;
      if (item.qty <= 0) widget.cart.remove(productId);
    });
    widget.onCartChanged();
  }

  void _removeItem(String productId) {
    setState(() {
      widget.cart.remove(productId);
    });
    widget.onCartChanged();
  }

  void _goReceipt() {
    if (cartList.isEmpty) return;

    final branchName = resolveBranchName(widget.branchCode);
    final total = subtotal - discount;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReceiptPage(
          searcherName: widget.searcherName,
          branchCode: widget.branchCode,
          branchName: branchName,
          cart: cartList,
          subtotal: subtotal,
          discount: discount,
          total: total,
          paidAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = subtotal - discount;
    final branchName = resolveBranchName(widget.branchCode);

    final payPayload =
        'LUNGCHAEM|BRANCH=${widget.branchCode}|TOTAL=${total.toStringAsFixed(2)}|TIME=${DateTime.now().toIso8601String()}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('สรุปยอดตะกร้า'),
        backgroundColor: Colors.pink[300],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                title: Text('ผู้ค้นหา: ${widget.searcherName}'),
                subtitle: Text('สาขา: $branchName (${widget.branchCode})\n$promoText'),
              ),
            ),
          ),
          Expanded(
            child: cartList.isEmpty
                ? const Center(child: Text('ตะกร้าว่าง'))
                : ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final item = cartList[index];
                final id = item.product.id;

                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'ราคา ${item.product.price.toStringAsFixed(2)}฿\n'
                          'ล็อก ${item.product.aisle} • ${item.product.category}\n'
                          'คงเหลือในร้าน: ${item.product.stockCount}',
                    ),
                    trailing: SizedBox(
                      width: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            tooltip: 'ลดจำนวน',
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _decQty(id),
                          ),
                          Text('${item.qty}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            tooltip: 'เพิ่มจำนวน',
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _incQty(id),
                          ),
                          IconButton(
                            tooltip: 'ลบรายการ',
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(id),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _sumRow('ยอดรวม', subtotal),
                    _sumRow('ส่วนลด', -discount),
                    const Divider(),
                    _sumRow('ยอดสุทธิ', total, isTotal: true),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text('สแกนเพื่อชำระเงิน',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    QrImageView(data: payPayload, size: 180),
                    const SizedBox(height: 8),
                    Text(
                      'ยอดชำระ: ${total.toStringAsFixed(2)} ฿',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: cartList.isEmpty ? null : _goReceipt,
                  icon: const Icon(Icons.payments),
                  label: const Text('กดเพื่อสรุปบิล'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[800]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sumRow(String label, double value, {bool isTotal = false}) {
    final textStyle = TextStyle(
      fontSize: isTotal ? 18 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
    );

    final v = value >= 0 ? value.toStringAsFixed(2) : '-${value.abs().toStringAsFixed(2)}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: textStyle),
          const Spacer(),
          Text('$v ฿', style: textStyle),
        ],
      ),
    );
  }
}

/// ---------------------------
/// Receipt Page
/// ---------------------------
class ReceiptPage extends StatelessWidget {
  final String searcherName;
  final String branchCode;
  final String branchName;
  final List<CartItem> cart;
  final double subtotal;
  final double discount;
  final double total;
  final DateTime paidAt;

  const ReceiptPage({
    super.key,
    required this.searcherName,
    required this.branchCode,
    required this.branchName,
    required this.cart,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paidAt,
  });

  @override
  Widget build(BuildContext context) {
    final payPayload =
        'LUNGCHAEM|BRANCH=$branchCode|TOTAL=${total.toStringAsFixed(2)}|TIME=${paidAt.toIso8601String()}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('ใบเสร็จรับเงิน'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  'ร้านลุงแช่ม • $branchName ($branchCode)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('ผู้ค้นหา: $searcherName\nชำระเมื่อ: ${paidAt.toLocal()}'),
              ),
            ),
            const SizedBox(height: 8),

            // ✅ QR อ้างอิงการชำระเงิน (optional)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text('QR อ้างอิงการชำระเงิน', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    QrImageView(data: payPayload, size: 150),
                    const SizedBox(height: 6),
                    Text('ยอดชำระ: ${total.toStringAsFixed(2)} ฿',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, i) {
                  final item = cart[i];
                  return Card(
                    child: ListTile(
                      title: Text(item.product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'ราคา ${item.product.price.toStringAsFixed(2)}฿ • จำนวน ${item.qty}\n'
                            'ล็อก ${item.product.aisle} • ${item.product.category}',
                      ),
                      trailing: Text(
                        '${item.lineTotal.toStringAsFixed(2)}฿',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _sumRow('ยอดรวม', subtotal),
                    _sumRow('ส่วนลด', -discount),
                    const Divider(),
                    _sumRow('ยอดสุทธิ', total, isTotal: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text('เสร็จสิ้น'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800]),

                onPressed: () async {
                  // 1) ไปหน้า ThankYou ก่อน
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ThankYouPage()),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PreloadPage(message: 'กำลังรีเซ็ต...')),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sumRow(String label, double value, {bool isTotal = false}) {
    final style = TextStyle(
      fontSize: isTotal ? 18 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
    );
    final v = value >= 0 ? value.toStringAsFixed(2) : '-${value.abs().toStringAsFixed(2)}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: style),
          const Spacer(),
          Text('$v ฿', style: style),
        ],
      ),
    );
  }
}


class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.accessible_forward_outlined, size: 72, color: Colors.pinkAccent),
              const SizedBox(height: 12),
              const Text(
                'ขอบคุณหลานๆ ที่ใช้บริการร้านลุงแช่ม ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'ทีนี้จะไปไหนเอ็งก็ไป..!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context), // ✅ ปิด ThankYou กลับไปให้ปุ่มเสร็จสิ้นทำงานต่อ
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                  child: const Text('จ้าาา'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreloadPage extends StatelessWidget {
  final String message;
  const PreloadPage({super.key, this.message = 'กำลังกลับหน้าเริ่มต้น...'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              const CircularProgressIndicator(color: Colors.pinkAccent),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
