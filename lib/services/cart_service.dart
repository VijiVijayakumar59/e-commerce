import 'package:shopify/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();
  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cart(
      id INTEGER PRIMARY KEY,
      title TEXT,
      price REAL,
      image TEXT,
      quantity INTEGER
    )
    ''');
  }

  Future<void> insertCartItem(CartItemModel item) async {
    final db = await instance.database;

    final existing = await db.query('cart', where: 'id = ?', whereArgs: [item.id]);
    if (existing.isNotEmpty) {
      await db.update('cart', {'quantity': (existing.first['quantity'] as int) + 1}, where: 'id = ?', whereArgs: [item.id]);
    } else {
      await db.insert('cart', item.toJson());
    }
  }

  Future<List<CartItemModel>> fetchCartItems() async {
    final db = await instance.database;
    final result = await db.query('cart');
    return result.map((json) => CartItemModel.fromJson(json)).toList();
  }

  Future<void> updateQuantity(int id, int quantity) async {
    final db = await instance.database;
    await db.update('cart', {'quantity': quantity}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteCartItem(int id) async {
    final db = await instance.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalCartPrice() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT SUM(price * quantity) as total FROM cart');
    final total = result.first['total'];
    return (total != null) ? (total as num).toDouble() : 0.0;
  }

  Future<int> getTotalCartQuantity() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT SUM(quantity) as totalQuantity FROM cart');
    final totalQuantity = result.first['totalQuantity'] as int?;
    return totalQuantity ?? 0;
  }
}
