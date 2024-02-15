import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartprayer/src/helper/networkmanager/networkmanager.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {

    Get.put(NetworkManager());
  }
}
