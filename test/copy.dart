import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterClipboard.copy('''
السلام عليكم أخي السائق
يرجى العلم بانه لديك طلب جديد
يرجى التواصل معه في أقرب وقت
وإليك بعض البيانات المهمة
رقم للتواصل: ${formdata['name']}

''').then((value) => print('Form data copied to clipboard'));
}

var formdata = {
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "password",
  "confirm_password": "password"
};
