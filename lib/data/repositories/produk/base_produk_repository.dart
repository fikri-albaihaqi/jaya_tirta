import '../../models/models.dart';

abstract class BaseProdukRepository {
  Stream<List<Produk>> getAllProduk();
}
