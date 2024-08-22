import 'package:flutter/cupertino.dart';

showLoading(BuildContext context) {
  return showCupertinoDialog(
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
              color: CupertinoTheme.of(context).barBackgroundColor,
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
) => showCupertinoDialog(
  useRootNavigator: false,
  barrierDismissible: true,
  context: context, 
  builder: (context) => Center(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoTheme.of(context).barBackgroundColor,
      ),
      width: MediaQuery.sizeOf(context).width * 0.7,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(height: 15),
          child
        ],
      ),
    ),
  )
);
