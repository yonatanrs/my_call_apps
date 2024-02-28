import 'package:get/get.dart';
import 'package:call_apps/models/lead_model.dart';

class LeadController extends GetxController {
  var leads = <LeadModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize leads here
  }
}
