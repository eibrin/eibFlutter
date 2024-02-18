import 'package:flutter/material.dart';
import 'package:widget_master/models/memo_helper.dart';

import '../models/memo.dart';

class ListviewBuilder extends StatefulWidget {
  const ListviewBuilder({super.key});

  @override
  State<ListviewBuilder> createState() => _ListviewBuilderState();
}

class _ListviewBuilderState extends State<ListviewBuilder> {
  MemoHelper mHelper = MemoHelper();

  @override
  void initState() {
    super.initState();
    mHelper.testDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('데이터베이스 ${mHelper.memoList!.length}')),
        body: Container(
          child: Center(
            child: mylistView(context),
            /* GridView.count(
                  crossAxisCount: 3, // 열 개수
                  children:
                      List<Widget>.generate(mHelper.memoList!.length, (idx) {
                    return Container(
                      color: Colors.amber,
                      padding: const EdgeInsets.all(40),
                      margin: const EdgeInsets.all(8),
                      child: Text(
                        mHelper.memoList![idx].title!,
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList())*/

            /*FutureBuilder(
              builder: (context, snapshot) {
                print('snapshot : $snapshot');
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Memo memo = snapshot.data![index];
                          return ListTile(
                            title: Text(
                              memo.title!,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Container(
                              child: Column(
                                children: [
                                  Text(memo.content!),
                                  Container(
                                    height: 1,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data?.length,
                      );
                    }
                }
                print('snapshot: ${snapshot.hasData}');

                return Text('No data');
              },
              future: mHelper.memoList,
            ),*/
          ),
        ));
  }

  Widget mylistView(BuildContext context) {
    var mList = mHelper.memoList;
    return ListView.builder(
      itemCount: (mList != null) ? mList.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(mList![index].title!),
          leading: CircleAvatar(
            child: Text(mList[index].active.toString()),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>detailPage(mList[index]))),
          },
        );
      },
    );
  }
}
