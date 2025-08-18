import 'package:flutter/material.dart';
import 'package:flutter_review/getx/employee_file_screen/employee_view_file.dart';
import 'package:flutter_review/getx/employee_shp_screen/home_view.dart';
import 'package:flutter_review/getx/product_screen/product_view.dart';


class AllWidget extends StatefulWidget {
  const AllWidget({super.key});

  @override
  State<AllWidget> createState() => _AllWidgetState();
}

class _AllWidgetState extends State<AllWidget> {
  final List _recipes = [
    'Samlor Korko',
    'Amok Trey',
    'Beef Lok Lak',
    'Khmer Noodle',
    'Rice',
  ];

  // final List _images = [
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhop8VR94Fv478QjfyiCxH5c4GIUfFINSzMw&s',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0H9GAbEmtbqG3JyYEBYo9MUYHoV1Gp6upiA&s',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnsLe7HexCUxODiNg_4b5P_Bz6i0iHRhS85g&s',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBqlkkoZsmGcuRRDSojUkThGFqByKGaoQlAg&s',
  // ];

  final List _imagesAssets = [
    'assets/images/korko.jpg',
    'assets/images/ahmork.png',
    'assets/images/loklak.jpg',
    'assets/images/khmer_noodle.jpg',
    'assets/images/rice.jpeg',
  ];

  // double _scale = 1.0;

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


  // setState(() {
  //     _scale = 1.1;
  //     Future.delayed(const Duration(milliseconds: 100), () {
  //       setState(() {
  //         _scale = 1.0;
  //       });
  //     });
  //   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      /// Layout
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text and style
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recipes',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          showDialog(
                            context: context, 
                            builder: (context) {
                              return AlertDialog(
                                title: Text('New Recipe'),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                                actions: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'name',
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'list of ingredients',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, 
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, 
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              );
                            }
                          );
                        }, 
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          'New',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.deepPurple
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeView()));
                        },
                        child: Text(
                          'File',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen()));
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(
                          'SQLite',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 87,
              ///    Grid
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3
                ),
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  /// Button
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 1, color: Colors.black),
                    ),
                    onPressed: (){
                      /// Navigation
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                    },
                    child: Text(_recipes[index]));
                },
              ),
            ),
            Text(
              'New Recipes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              ///    List
              child: ListView.builder( 
                padding: EdgeInsets.zero,
                itemCount: _imagesAssets.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                  // color: Colors.white,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: InkWell(
                        onTap: () {
                          print(index);
                          _imageScaleAnimat(index);
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Long Press'),
                            ),
                          );
                        },
                        child: Row(
                          spacing: 10,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _recipes[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Khmer Ingredients',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      )
    );
  }
}