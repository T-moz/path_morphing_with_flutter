import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_morph/path_morph.dart';
import 'package:path_drawing/path_drawing.dart';

import 'digitClipper.dart';

void main() => runApp(MyApp());

const SCALE_RATIO = 0.8;
const WIDTH = 85.0;
const HEIGHT = 140.0;

const ONE_PATH =
    'M32.7324 0.681641H34.8477C41.8984 2.24023 45.4238 5.76563 45.4238 11.2578V156.318C44.0879 163.666 40.3027 167.34 34.0684 167.34H33.2891C25.9414 165.781 22.2676 162.293 22.2676 156.875V28.1797C17.2949 29.8125 13.4727 30.6289 10.8008 30.6289C5.53125 30.6289 2.04297 27.1035 0.335938 20.0527V17.4922C0.335938 11.5547 6.83008 7.25 19.8184 4.57812L32.7324 0.681641Z';
const TWO_PATH =
    "M51.4941 0.792969C67.6738 0.792969 81.7383 7.99219 93.6875 22.3906C99.9961 31.9648 103.15 41.873 103.15 52.1152C103.15 67.7012 95.6914 82.5078 80.7734 96.5352L39.0254 144.295H94.3555C100.367 144.295 104.004 147.932 105.266 155.205V156.207C104.152 163.629 100.367 167.34 93.9102 167.34H11.9727C4.69922 166.004 1.0625 162.219 1.0625 155.984V155.539C1.0625 151.902 3.99414 147.338 9.85742 141.846L74.873 67.7012C78.0645 63.248 79.6602 58.0527 79.6602 52.1152C79.6602 39.4238 72.9805 30.5176 59.6211 25.3965C57.543 24.7285 55.0938 24.3945 52.2734 24.3945H51.0488C38.877 24.3945 30.082 30.9258 24.6641 43.9883C23.9961 46.6602 23.5137 50.2227 23.2168 54.6758C20.4707 60.2422 16.834 63.0254 12.3066 63.0254H11.1934C3.8457 61.6895 0.171875 58.0527 0.171875 52.1152C0.171875 34.1543 8.70703 19.459 25.7773 8.0293C34.9062 3.20508 43.4785 0.792969 51.4941 0.792969Z";
const HOME_PATH =
    "M3.70008 64.0839C3.7046 64.0805 3.70799 64.076 3.71138 64.0726L64.0838 3.70249C66.6571 1.12802 70.0785 -0.289062 73.7177 -0.289062C77.357 -0.289062 80.7783 1.12802 83.3528 3.70249L143.694 64.0422C143.714 64.0625 143.735 64.0839 143.755 64.1043C149.039 69.4192 149.03 78.0425 143.729 83.3439C141.307 85.7671 138.109 87.1695 134.689 87.3174C134.549 87.3309 134.409 87.3377 134.267 87.3377H131.862V131.765C131.862 140.558 124.708 147.711 115.915 147.711H92.2957C89.9007 147.711 87.9597 145.769 87.9597 143.375V108.543C87.9597 104.531 84.6953 101.268 80.6835 101.268H66.752C62.7401 101.268 59.4768 104.531 59.4768 108.543V143.375C59.4768 145.769 57.5358 147.711 55.1409 147.711H31.5213C22.7274 147.711 15.5743 140.558 15.5743 131.765V87.3377H13.343C9.70492 87.3377 6.28359 85.9206 3.70799 83.345C-1.59903 78.0357 -1.60129 69.3966 3.70008 64.0839V64.0839ZM9.84042 77.2137C10.7765 78.1498 12.0208 78.6658 13.343 78.6658H19.9102C22.3051 78.6658 24.2461 80.6068 24.2461 83.0018V131.765C24.2461 135.776 27.5094 139.039 31.5213 139.039H50.805V108.543C50.805 99.7505 57.9581 92.5962 66.752 92.5962H80.6835C89.4773 92.5962 96.6316 99.7505 96.6316 108.543V139.039H115.915C119.926 139.039 123.19 135.776 123.19 131.765V83.0018C123.19 80.6068 125.131 78.6658 127.526 78.6658H133.981C134.048 78.6613 134.115 78.6579 134.184 78.6568C135.476 78.6342 136.687 78.1216 137.595 77.2126C139.526 75.2817 139.526 72.1393 137.595 70.2073C137.594 70.2073 137.594 70.2062 137.593 70.2051L137.589 70.2017L77.2192 9.83379C76.2843 8.89772 75.0411 8.38283 73.7177 8.38283C72.3955 8.38283 71.1523 8.89772 70.2162 9.83379L9.85961 70.1893C9.85058 70.1983 9.84042 70.2073 9.83138 70.2164C7.9107 72.1506 7.91408 75.2863 9.84042 77.2137V77.2137Z";
const HOME_EXTRA_PATH = "M74 120.25";
const PHOTO_PATH =
    "M21.5834 33.9166H40.0834C41.4154 33.9166 42.587 33.0716 43.0064 31.8076L44.955 25.9555C47.064 19.6531 52.9409 15.4166 59.5824 15.4166H88.4179C95.0654 15.4166 100.942 19.6531 103.039 25.9555L104.987 31.8076C105.413 33.0716 106.591 33.9166 107.917 33.9166H126.417C138.318 33.9166 148 43.5984 148 55.5V111C148 122.902 138.318 132.583 126.417 132.583H21.5831C9.68157 132.583 0 122.902 0 111V55.5C0 43.5984 9.68157 33.9166 21.5834 33.9166ZM74 120.25C94.4055 120.25 111 103.655 111 83.25C111 62.8445 94.4055 46.25 74 46.25C53.5945 46.25 37 62.8445 37 83.25C37 103.655 53.5945 120.25 74 120.25Z";
const PHOTO_EXTRA_PATH =
    "M74 58.5834C87.6036 58.5834 98.6666 69.6464 98.6666 83.25C98.6666 84.952 97.2851 86.3334 95.5831 86.3334C93.8811 86.3334 92.5 84.952 92.5 83.25C92.5 73.0504 84.1996 64.75 74 64.75C72.298 64.75 70.9166 63.3686 70.9166 61.6666C70.9166 59.9646 72.298 58.5834 74 58.5834Z";

class ViewBox {
  double width;
  double height;

  ViewBox(this.width, this.height);
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> with SingleTickerProviderStateMixin {
  SampledPathData data;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    final matrix4 = Matrix4.identity()..scale(SCALE_RATIO, SCALE_RATIO);
    Path path1 = parseSvgPathData(ONE_PATH).transform(matrix4.storage);
    Path path2 = parseSvgPathData(TWO_PATH).transform(matrix4.storage);

    data = PathMorph.samplePaths(path1, path2);

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    PathMorph.generateAnimations(controller, data, func);
  }

  void func(int i, Offset z) {
    setState(() {
      data.shiftedPoints[i] = z;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: Container(
          color: Color(0xFF212121),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15.0,
                              color: Color(0xFF151515),
                              offset: Offset(8.0, 8.0),
                            ),
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Color(0xFF292929),
                              offset: Offset(-8.0, -8.0),
                            ),
                          ],
                          border:
                              Border.all(color: Color(0xFF212121), width: 2),
                          color: Color(0xFF212121),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 16.0),
                        child: Text(
                          "Path morphing with Flutter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      )),
                ),
                Spacer(),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Color(0xFFFFFFFF),
                    textColor: Color(0xFF212121),
                    onPressed: () {
                      if (controller.status == AnimationStatus.completed) {
                        controller.reverse();
                      }
                      if (controller.status == AnimationStatus.dismissed) {
                         .forward();
                      }
                    },
                    child: Text("Change shape"),
                  ),
                )),
                Spacer(),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15.0,
                            color: Color(0xFF151515),
                            offset: Offset(8.0, 8.0),
                          ),
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0xFF292929),
                            offset: Offset(-8.0, -8.0),
                          ),
                        ],
                        border: Border.all(color: Color(0xFF212121), width: 2),
                        color: Color(0xFF212121),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                          height: HEIGHT,
                          width: WIDTH,
                          child: ClipRect(
                              clipper:
                                  DigitBoxClipper(new ViewBox(WIDTH, HEIGHT)),
                              child: Stack(children: <Widget>[
                                ClipPath(
                                  clipper: DigitClipper(
                                    PathMorph.generatePath(data),
                                  ),
                                  child: CustomPaint(
                                      size: Size.infinite,
                                      painter: MyPainter(
                                          PathMorph.generatePath(data))),
                                )
                              ]))),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Path path;
  var myPaint;

  MyPainter(this.path) {
    myPaint = Paint();
    myPaint.color = Color(0xFFC4C4C4);
    //myPaint.style = PaintingStyle.values;
    myPaint.strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(path, myPaint);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
