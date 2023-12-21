import 'package:flutter/material.dart';

class TodoItem {
  PopupMenuItem todoItem(Function onTap, String title, Icon icon) {
    return PopupMenuItem(
      child: ListTile(
        title: Text(title.toString()),
        leading: icon,
        onTap: () => onTap,
      ),
    );
  }

  Widget PopupMenu(BuildContext context, Function onEdit, Function onDelete) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
              todoItem(onEdit, 'Edit to do', const Icon(Icons.edit)),
              todoItem(onDelete, 'Delete to do', const Icon(Icons.delete)),
            ]);
  }
}
