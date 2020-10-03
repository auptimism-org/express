import 'package:flutter/material.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:supercharged/supercharged.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';

enum AniProps { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(
          AniProps.color1,
          Theme.of(context).primaryColor.tweenTo(Theme.of(context).accentColor),
          3.seconds)
      ..add(
          AniProps.color2,
          Theme.of(context).accentColor.tweenTo(Theme.of(context).primaryColor),
          3.seconds);

    return CustomAnimation<MultiTweenValues<AniProps>>(
      control: CustomAnimationControl.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                value.get(AniProps.color1),
                value.get(AniProps.color2),
              ],
            ),
          ),
        );
      },
    );
  }
}
