import 'package:get/get.dart';
import 'package:schoolmanager/vacation_module/views/drawer_page/languages/english.dart';

class AppLanguages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': english,
    
  };

}