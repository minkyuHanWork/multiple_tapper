import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_tapper/storage/storage_repository.dart';

final storageProvider = Provider((ref) => StorageRepository());
