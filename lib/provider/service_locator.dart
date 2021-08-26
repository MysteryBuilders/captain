import 'package:captain/provider/call_services.dart';
import 'package:get_it/get_it.dart';




GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}