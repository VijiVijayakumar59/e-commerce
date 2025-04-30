import 'package:shopify/models/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WishlistDatabase {
  static final WishlistDatabase instance = WishlistDatabase._init();

  static Database? _database;

  WishlistDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('wishlist.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE wishlist (
      id INTEGER PRIMARY KEY,
      title TEXT,
      price REAL,
      description TEXT,
      category TEXT,
      image TEXT
    )
  ''');
  }

  // Insert item
  Future<void> addToWishlist(WishlistItemModel item) async {
    final db = await instance.database;
    await db.insert('wishlist', item.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch all wishlist items
  Future<List<WishlistItemModel>> fetchWishlistItems() async {
    final db = await instance.database;
    final result = await db.query('wishlist');

    return result.map((json) => WishlistItemModel.fromJson(json)).toList();
  }

  // Delete item by id
  Future<void> removeFromWishlist(int id) async {
    final db = await instance.database;
    await db.delete('wishlist', where: 'id = ?', whereArgs: [id]);
  }

  // Check if item is already wishlisted
  Future<bool> isItemInWishlist(int id) async {
    final db = await instance.database;
    final result = await db.query('wishlist', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
