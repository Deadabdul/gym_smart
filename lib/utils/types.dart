import 'dart:ui';
extension Arithmatic on Color {
  Color operator *(double t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    return withRed((red * t).round()).withGreen((green * t).round()).withBlue((blue * t).round());
  }
  Color operator +(double t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    return withRed((red + t * 255).round()).withGreen((green + t * 255).round()).withBlue((blue + t * 255).round());
  }
  Color operator -(double t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    return withRed((red - t * 255).round()).withGreen((green - t * 255).round()).withBlue((blue - t * 255).round());
  }
}