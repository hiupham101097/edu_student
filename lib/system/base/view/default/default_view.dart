import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class DefaultView extends StatelessWidget {
  // ignore: annotate_overrides, overridden_fields
  Key? key;
  Widget? layout;

  DefaultView({
    this.key,
    this.layout,
  }) : super(key: key);
}
