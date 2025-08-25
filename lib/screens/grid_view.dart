import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {

  final List _title = [
    'Apple',
    'Samsung',
    'Google',
    'Xiaomi',
    'OnePlus',
    'Nokia',
  ];

  final List _titleColors = [
    Colors.black,
    const Color.fromARGB(255, 3, 75, 133),
    const Color.fromARGB(255, 34, 194, 39),
    const Color.fromARGB(255, 204, 86, 12),
    Colors.redAccent,
    const Color.fromARGB(255, 9, 21, 128)
  ];

  final List<String> _logo = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGlpdEI6Xlo9wxFEJHom_dDyxkyF_32Y1T4A&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjCGzpvokdRiGL0FFBlZR8Cdhd_-b352BX7w&s',
    'https://static.vecteezy.com/system/resources/previews/059/494/413/non_2x/google-pixel-mobile-company-brand-official-logo-icon-and-symbol-high-quality-digital-download-free-vector.jpg',
    'https://www.freepnglogos.com/uploads/xiaomi-png/mi-logo-png-3.png',
    'https://static.vecteezy.com/system/resources/previews/059/494/388/non_2x/oneplus-mobile-company-brand-official-logo-icon-and-symbol-high-quality-digital-download-free-vector.jpg',
    'https://cdn.wallpapersafari.com/68/91/Mlte9b.png'
  ];

  final List<String> _discription = [
    'Apple is a technology company that produces consumer electronics, computer software, and online services.',
    'Samsung is a South Korean multinational conglomerate that produces a wide range of consumer and industrial electronics, including smartphones, TVs, and home appliances.',
    'Google is a multinational technology company that specializes in Internet-related services and products, including search, cloud computing, and advertising technologies.',
    'Xiaomi is a Chinese electronics company that produces smartphones, laptops, home appliances, and other consumer electronics.',
    'OnePlus is a Chinese smartphone manufacturer that produces high-end smartphones with advanced features.',
    'Nokia is a Finnish telecommunications company that produces mobile phones, smartphones, and network infrastructure equipment.'
  ];

  int _crossAxisCount = 2;

  void onTap () {
    setState(() {
      _crossAxisCount = _crossAxisCount == 2 ? 1 : 2;
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Grid View'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.swap_horiz,
              color: Colors.white,
            ), 
            onPressed: onTap,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  childAspectRatio: _crossAxisCount == 1 ? 2 : .7,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: _title.length,
                itemBuilder: (context, index) {
                  /// Button
                  return _crossAxisCount == 2
                  ? InkWell(
                      onTap: () {
                        _imageScaleAnimat(index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Get.isDarkMode ? Colors.white : Colors.grey,
                              blurRadius: 6,
                              spreadRadius: 3,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: AnimatedScale(
                                  scale: _tappedIndex == index ? 1.2 : 1,
                                  duration: Duration(milliseconds: 200),
                                  child: Image.network(
                                    _logo[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                _title[index],
                                style: TextStyle(
                                  color: _titleColors[index],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0), 
                              child: Text(
                                _discription[index],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        _imageScaleAnimat(index);
                      },
                      /// Container
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Get.isDarkMode ? Colors.white : Colors.grey,
                              blurRadius: 6,
                              spreadRadius: 3,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            /// Image
                            Container(
                              width: 120,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: AnimatedScale(
                                  scale: _tappedIndex == index ? 1.2 : 1,
                                  duration: Duration(milliseconds: 200),
                                  child: Image.network(
                                    _logo[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 5.0),
                                    child: Text(
                                      _title[index],
                                      style: TextStyle(
                                        color: _titleColors[index],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0, right: 10.0, bottom: 10), 
                                    child: Text(
                                      _discription[index],
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}