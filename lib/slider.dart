
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './size/size_config.dart';

import '../../blocs/blocs.dart';

class SliderHeightWidget extends StatefulWidget {

  final fullWidth;

   SliderHeightWidget({

    this.fullWidth = true,
  });

  @override
  _SliderHeightWidgetState createState() => _SliderHeightWidgetState();
}

class _SliderHeightWidgetState extends State<SliderHeightWidget> {
  double _value = 0.0;
  // double _height = 150.0;
  final double sliderHeight = SizeConfig.responsiveHeight(5.0, 10.0);



  @override
  Widget build(BuildContext context) {
    double paddingFactor = .1;

    if (widget.fullWidth) paddingFactor = .3;

    return Container(
      width: widget.fullWidth ? double.infinity : sliderHeight * 5.5,
      height: sliderHeight,
      decoration:  BoxDecoration(
        borderRadius:  BorderRadius.all(
          Radius.circular((sliderHeight * .15)),
        ),
        gradient: const  LinearGradient(
          colors: [
             Color(0xaa00c6ff),
             Color(0xFF00ddaa),
          ],
          begin:  FractionalOffset(0.0, 0.0),
          end:  FractionalOffset(1.0, 1.00),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(sliderHeight * paddingFactor, 2, sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                '$_value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sliderHeight * .3,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(
            //   width: this.widget.sliderHeight * .1,
            // ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),
                    trackHeight: 6.0,
                    thumbColor: Colors.blue,
                    // thumbShape: SliderComponentShape.noThumb,
                    // CustomSliderThumbCircle(
                    //   thumbRadius: this.widget.sliderHeight * .4,
                    //   min: this.widget.min,
                    //   max: this.widget.max,
                    // ),
                    // overlayShape: CustomSliderThumbCircle(
                    //   thumbRadius: this.widget.sliderHeight * .3,
                    //   min: this.widget.min,
                    //   max: this.widget.max,
                    // ),
                    overlayColor: Colors.white.withOpacity(.4),
                    // thumbColor: Colors.black,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.blueAccent,
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child:  Slider(
                        value:_value ,
                        divisions: 100,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });


                        },
                      ),

                  ),
                ),
              ),

            SizedBox(
              width: sliderHeight * .05,
            ),
            Text(
              '$_value',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
