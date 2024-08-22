import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  return showDialog(
    useRootNavigator: false,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: Center(
          child: Container(
            width: 75,
            height: 75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: const CupertinoActivityIndicator(
              radius: 15,
            ),
          ),
        ),
      );
    });
}
openDialog(
  BuildContext context, 
  String title, 
  Widget child,
) => showDialog(
  useRootNavigator: false,
  context: context, 
  builder: (context) => Dialog(
    backgroundColor:  Theme.of(context).colorScheme.surfaceVariant,
    child: Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: [
          Text(title),
          const SizedBox(height: 20),
          child
        ],
      ),
    ),
  )
);
