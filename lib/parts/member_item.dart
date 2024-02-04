import 'package:flutter/material.dart';

class MemberItem {
  final String? path;
  final String? name;
  final bool? isPaid;

  MemberItem({this.path, this.name, this.isPaid = false});
}
