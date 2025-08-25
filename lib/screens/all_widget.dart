import 'package:flutter/material.dart';
import 'package:flutter_review/getx/employee_file_screen/employee_view_file.dart';
import 'package:flutter_review/getx/employee_shp_screen/home_view.dart';
import 'package:flutter_review/getx/product_screen/product_view.dart';
import 'package:flutter_review/my_app.dart';
import 'package:flutter_review/screens/grid_view.dart';


class AllWidget extends StatefulWidget {
  const AllWidget({super.key});

  @override
  State<AllWidget> createState() => _AllWidgetState();
}

class _AllWidgetState extends State<AllWidget> {

  final List<Widget> _eachPages = [
    EmployeeView(),
    HomeView(),
    ProductScreen(),
    GridViewWidget(),
  ];

  final List _title = [
    'Employee CRUD with \nFile Storage',
    'Employee CRUD with \nShared Preferences',
    'Product CRUD with \nSQLite',
    'Smart Phone Brand \nwith Grid View',
  ];

  final List _imagesAssets = [
    'assets/images/file_storage.png',
    'assets/images/shared_preference.png',
    'assets/images/sqflite.png',
    'assets/images/gridview.png',
  ];

  int? _tappedIndex;

  void _imageScaleAnimat(int index) {
    /// build-in setState
    setState(() {
      if( _tappedIndex == index) {
        _tappedIndex = null;
      } else {
        _tappedIndex = index;
      }
    });

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        if( _tappedIndex == index) {
          _tappedIndex = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        title: Text('Persistent List'),
        actions: [
          // IconButton(
          //   onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationView()));
          //   }, 
          //   icon: Icon(Icons.notifications)
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  MyApp.onChangeTheme();
                });
              },
            ),
          ),
        ],
      ),
      /// Layout
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text and style
            Expanded(
              ///    List
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _imagesAssets.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: InkWell(
                        onTap: ()  {
                          _imageScaleAnimat(index);
                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(builder: (context) => _eachPages[index]));
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Long Press'),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3.0),
                          child: Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  AnimatedScale(
                                    scale: _tappedIndex == index ? 1.2 : 1.0,
                                    duration: Duration(milliseconds: 200),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        ///  Image Assets
                                        width: 100,
                                        _imagesAssets[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    _title[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_rounded)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}