import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cosmic_cast/infrastructure/datasources/isar_datasource.dart';
import 'package:cosmic_cast/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositroyProvider = Provider(
  (ref) => LocalStorageRepositoryImpl(IsarDatasource()),
);
