import 'package:flutter/material.dart';

class BuildListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const BuildListItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final hoverColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(
        icon,
      ),
      onTap: onTap,
    );
  }
}
