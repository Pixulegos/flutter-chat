import 'package:chat_app/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(online: true, email: 'test1@gmail.com', name: 'Jorge', uuid: '1'),
    User(online: false, email: 'test2@gmail.com', name: 'Carlos', uuid: '2'),
    User(online: true, email: 'test3@gmail.com', name: 'Juan', uuid: '3'),
  ];
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Name', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.exit_to_app, color: Colors.black54)
          //Icon(Icons.offline_bolt, color: Colors.red)
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400])
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _usersListView())
   );
  }

  ListView _usersListView() {
    return ListView.separated(
      itemBuilder: (context, i) => _userListTile(users[i]), 
      separatorBuilder: (context, index) => Divider(), 
      itemCount: users.length);
  }

  ListTile _userListTile(User user) {
    return ListTile(
      onTap: () {
        
      },
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.name.substring(0,2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300]: Colors.red,
          shape: BoxShape.circle
        ),
      ),
    );
  }

  Future<void> _loadUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}