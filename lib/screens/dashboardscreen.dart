import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as ov;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:interview/bloc/createuser/createuser_bloc.dart';
import 'package:interview/bloc/edituser/edit_user_bloc.dart';
import 'package:interview/main.dart';
import 'package:interview/models/userresponse.dart';
import 'package:interview/repository/apiservice.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const _pageSize = 10;

  final PagingController<int, Data> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchusers(pageKey);
      print("page is $pageKey");
      final isLastPage = newItems.data!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.data!);
      } else {
        final nextPageKey = pageKey + newItems.data!.length;
        _pagingController.appendPage(newItems.data!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController jobc = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      print("page is $pageKey");
      _fetchPage(pageKey);
      // fetchusers(pageKey);
    });
    getname().then((value) {
      print("name is $value");
    });
    super.initState();
  }

  UserResponse? userResponse;
  Future getname() async {
    return await storage.read("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: Drawer(
          child: Text("name"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Icon(
              Icons.menu,
            ),
          ),
          actions: [
            MultiBlocListener(
              listeners: [
                BlocListener<CreateuserBloc, CreateuserState>(
                  listener: (context, state) {
                    if (state is CreateUserLoading) {
                      ov.Loader.show(context,
                          progressIndicator: CircularProgressIndicator(
                            color: Colors.red,
                          ));
                    } else if (state is CreateUserLoaded) {
                      ov.Loader.hide();
                      Fluttertoast.showToast(msg: "User Added");
                      usernamecontroller.clear();
                      jobc.clear();
                      Navigator.pop(context);
                    }
                  },
                ),
                BlocListener<EditUserBloc, EditUserState>(
                  listener: (context, state) {
                    if (state is EditUserLoading) {
                      ov.Loader.show(context,
                          progressIndicator: CircularProgressIndicator(
                            color: Colors.red,
                          ));
                    } else if (state is EditUserLoaded) {
                      ov.Loader.hide();
                      Fluttertoast.showToast(msg: "User Edited");
                      Navigator.pop(context);
                      _fetchPage(0);
                    }
                  },
                ),
              ],
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      enableDrag: false,
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200.sm,
                          child: Padding(
                            padding: EdgeInsets.all(10.0.r),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: usernamecontroller,
                                  decoration:
                                      InputDecoration(hintText: "User Name"),
                                ),
                                TextFormField(
                                  controller: jobc,
                                  decoration: InputDecoration(hintText: "Job"),
                                ),
                                SizedBox(
                                  height: 10.sm,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (usernamecontroller.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please Add UserName");
                                    } else if (jobc.text.isEmpty) {
                                      Fluttertoast.showToast(msg: "Add Job");
                                    } else {
                                      BlocProvider.of<CreateuserBloc>(context)
                                          .add(CreateNewUser(
                                              job: jobc.text,
                                              username:
                                                  usernamecontroller.text));
                                    }
                                  },
                                  child: Container(
                                    height: 40.sm,
                                    width: 80.sm,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text("ADD"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20.r),
                  child: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(15.r),
            child: PagedListView<int, Data>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Data>(
                  itemBuilder: (context, item, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 4.r, bottom: 4.r),
                      child: Container(
                        height: 90.sm,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60.sm,
                                width: 60.sm,
                                margin: EdgeInsets.only(left: 10.r),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    item.avatar!,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.firstName! + " " + item.lastName!,
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.email!,
                                    style: GoogleFonts.nunito(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              PopupMenuButton(
                                  itemBuilder: (_) =>
                                      const <PopupMenuItem<String>>[
                                        PopupMenuItem<String>(
                                            child: Text('Edit'), value: 'Edit'),
                                        PopupMenuItem<String>(
                                            child: Text('Delete'),
                                            value: 'Delete'),
                                      ],
                                  onSelected: (_) {
                                    if (_ == "Edit") {
                                      showModalBottomSheet(
                                          enableDrag: false,

                                          // isDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            TextEditingController uname =
                                                TextEditingController(
                                                    text: item.firstName);
                                            TextEditingController job =
                                                TextEditingController(
                                                    text: item.lastName);
                                            return Container(
                                              height: 200.sm,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0.r),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller: uname,
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "User Name"),
                                                    ),
                                                    TextFormField(
                                                      controller: job,
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: "Job"),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sm,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        // if (use
                                                        //     .text.isEmpty) {
                                                        //   Fluttertoast.showToast(
                                                        //       msg:
                                                        //           "Please Add UserName");
                                                        // } else if (jobc
                                                        //     .text.isEmpty) {
                                                        //   Fluttertoast.showToast(
                                                        //       msg: "Add Job");
                                                        // } else {
                                                        BlocProvider.of<
                                                                    EditUserBloc>(
                                                                context)
                                                            .add(DoEditUser(
                                                                id: item.id
                                                                    .toString(),
                                                                job: jobc.text,
                                                                username:
                                                                    usernamecontroller
                                                                        .text));
                                                        //   }
                                                      },
                                                      child: Container(
                                                        height: 40.sm,
                                                        width: 80.sm,
                                                        color: Colors.red,
                                                        child: Center(
                                                          child: Text("Edit"),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    } else if (_ == "Delete") {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: 111.sm,
                                                width: 900.sm,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Are you sure want to Delete",
                                                      style: GoogleFonts.nunito(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(height: 20.sm),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "NO",
                                                            // style: Theme.of(context)
                                                            //     .primaryTextTheme
                                                            //     .headline2,
                                                          ),
                                                        ),
                                                        SizedBox(width: 20.sm),
                                                        InkWell(
                                                          onTap: () {
                                                            deleteuser(
                                                                    id: item.id
                                                                        .toString())
                                                                .whenComplete(
                                                                    () {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "User Deleted");
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "YES",
                                                            // style: Theme.of(context)
                                                            //     .primaryTextTheme
                                                            //     .headline2,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              insetPadding: EdgeInsets.all(28),
                                            );
                                          });
                                    }
                                  }),
                            ]),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10.r)),
                        width: double.infinity,
                      ),
                    );
                  },
                )

                // itemBuilder: (context, index) {
                //   return Text(
                //       userResponse!.data!.elementAt(index).firstName!);
                // },
                // separatorBuilder: ((context, index) {
                //   return SizedBox(
                //     height: 10.sm,
                //   );
                // }),
                ) // itemCount: userResponse!.data!.length)

            ));
  }
}
