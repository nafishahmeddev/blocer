import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Utility{
  static showLoadingDialog(context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return  WillPopScope(
              onWillPop: () async => false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Lottie.asset('assets/lotties/loading.json', width: 100, height: 100,
                        delegates: LottieDelegates(
                          values: [
                            ValueDelegate.colorFilter(
                              ['**'], value: ColorFilter.mode(Theme.of(context).colorScheme.inversePrimary, BlendMode.src),
                            ),
                          ],
                        )
                    ),

                  )
                ],
              )
          );
        }
    );
  }
}