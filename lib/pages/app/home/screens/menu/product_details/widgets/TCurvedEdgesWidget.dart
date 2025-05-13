import 'package:flutter/material.dart';
import 'package:zainab_restuarant_app/pages/app/home/screens/menu/product_details/widgets/TCustomCurvedEdges.dart';

class TCurvedEdgesWidget extends StatelessWidget {
  const TCurvedEdgesWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}
