import 'package:flutter/material.dart';

class AppThemedAppBar extends StatelessWidget implements PreferredSize{
  const AppThemedAppBar({
    required this.title,
    this.automaticallyImplyLeading = true,
    super.key,
  });
  final String title;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: automaticallyImplyLeading,
      titleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary,),
    );
  }
  
  @override
  Widget get child => const SizedBox.shrink();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
