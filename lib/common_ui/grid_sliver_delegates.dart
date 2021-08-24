import 'package:flutter/material.dart';

SliverGridDelegateWithFixedCrossAxisCount CardGridSliverDelegate() {
  return SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisSpacing: 15,
    crossAxisSpacing: 20,
    childAspectRatio: 2 / 3,
    mainAxisExtent: 270,
    crossAxisCount: 1,
  );
}
