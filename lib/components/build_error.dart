import 'package:flutter/cupertino.dart';

class BuildError extends StatelessWidget {
  final String msg;

  const BuildError({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg),
    );
  }
}
