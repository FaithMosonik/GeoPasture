import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../core/constants/app_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path   = join(dbPath, AppConstants.dbName);

    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Full schema — see docs/schema.sql for field documentation
    await db.execute('''
      CREATE TABLE PASTORALIST (
        id           TEXT PRIMARY KEY,
        name         TEXT NOT NULL,
        phone_number TEXT UNIQUE NOT NULL,
        location     TEXT,
        created_at   DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE HERD (
        id             TEXT PRIMARY KEY,
        name           TEXT NOT NULL,
        size           INTEGER NOT NULL,
        pastoralist_id TEXT NOT NULL,
        created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (pastoralist_id) REFERENCES PASTORALIST(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE ANIMAL (
        id          TEXT PRIMARY KEY,
        name        TEXT,
        species     TEXT NOT NULL,
        herd_id     TEXT NOT NULL,
        wearable_id TEXT,
        tlu_value   REAL DEFAULT 1.0,
        created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (herd_id) REFERENCES HERD(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE WEARABLE (
        id           TEXT PRIMARY KEY,
        animal_id    TEXT,
        sample_rate  INTEGER DEFAULT 10,
        battery_level REAL,
        last_seen    DATETIME,
        FOREIGN KEY (animal_id) REFERENCES ANIMAL(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE ACCELEROMETER_READING (
        id          TEXT PRIMARY KEY,
        wearable_id TEXT NOT NULL,
        timestamp   DATETIME NOT NULL,
        x_axis      REAL NOT NULL,
        y_axis      REAL NOT NULL,
        z_axis      REAL NOT NULL,
        processed   INTEGER DEFAULT 0,
        FOREIGN KEY (wearable_id) REFERENCES WEARABLE(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE BEHAVIOUR_CLASSIFICATION (
        id              TEXT PRIMARY KEY,
        animal_id       TEXT NOT NULL,
        timestamp       DATETIME NOT NULL,
        behaviour_class INTEGER NOT NULL,
        confidence      REAL NOT NULL,
        window_start    DATETIME NOT NULL,
        window_end      DATETIME NOT NULL,
        synced          INTEGER DEFAULT 0,
        FOREIGN KEY (animal_id) REFERENCES ANIMAL(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE DISTRESS_ALERT (
        id                TEXT PRIMARY KEY,
        animal_id         TEXT NOT NULL,
        classification_id TEXT NOT NULL,
        pastoralist_id    TEXT NOT NULL,
        alert_type        TEXT NOT NULL,
        message           TEXT NOT NULL,
        severity          TEXT NOT NULL,
        timestamp         DATETIME NOT NULL,
        is_acknowledged   INTEGER DEFAULT 0,
        synced            INTEGER DEFAULT 0,
        FOREIGN KEY (animal_id) REFERENCES ANIMAL(id),
        FOREIGN KEY (classification_id) 
          REFERENCES BEHAVIOUR_CLASSIFICATION(id),
        FOREIGN KEY (pastoralist_id) REFERENCES PASTORALIST(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE PASTURE_MAP (
        id                TEXT PRIMARY KEY,
        region            TEXT NOT NULL,
        generated_at      DATETIME NOT NULL,
        ndvi_score        REAL NOT NULL,
        condition         TEXT NOT NULL,
        biomass_kg_per_ha REAL NOT NULL,
        area_ha           REAL NOT NULL,
        total_biomass_kg  REAL NOT NULL,
        carrying_capacity INTEGER,
        duration_days     INTEGER,
        tile_path         TEXT,
        synced            INTEGER DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE GRAZING_SESSION (
        id                TEXT PRIMARY KEY,
        pastoralist_id    TEXT NOT NULL,
        herd_id           TEXT NOT NULL,
        pasture_map_id    TEXT NOT NULL,
        animal_count      INTEGER NOT NULL,
        total_tlu         REAL NOT NULL,
        start_date        DATETIME NOT NULL,
        end_date          DATETIME,
        carrying_capacity INTEGER NOT NULL,
        duration_days     INTEGER NOT NULL,
        synced            INTEGER DEFAULT 0,
        FOREIGN KEY (pastoralist_id) REFERENCES PASTORALIST(id),
        FOREIGN KEY (herd_id) REFERENCES HERD(id),
        FOREIGN KEY (pasture_map_id) REFERENCES PASTURE_MAP(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE SYNC_LOG (
        id                 TEXT PRIMARY KEY,
        record_id          TEXT NOT NULL,
        table_name         TEXT NOT NULL,
        sync_time          DATETIME,
        status             TEXT NOT NULL,
        records_uploaded   INTEGER DEFAULT 0,
        records_downloaded INTEGER DEFAULT 0,
        retry_count        INTEGER DEFAULT 0,
        created_at         DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}
