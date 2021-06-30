
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http show Client;

import 'core/services/localdb_service/localdb_service.dart';
import '/core/services/navigation_service/navigation_service.dart';
import 'core/services/network_service/network_service.dart';

void initSingletons(){
  GetIt.I.registerSingleton(NavigationService());
  GetIt.I.registerSingleton(NetworkService(http.Client()));
  GetIt.I.registerSingleton(LocalDbService());
}