import 'package:blocer/bloc/cubit/auth.dart';
import 'package:blocer/pages/home_page.dart';
import 'package:blocer/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OnboardPage extends StatefulWidget{
  const OnboardPage({super.key});
  @override
  State<StatefulWidget> createState()=>_OnboardPage();
}

class _OnboardPage extends State<OnboardPage>{
  bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value){
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      context.read<AuthCubit>().init();
    });
    return  BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state){
          if(_isLoading){
            return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/lotties/loading.json', width: 130,
                          delegates: LottieDelegates(
                            values: [
                              ValueDelegate.colorFilter(
                                ['**'], value: ColorFilter.mode(Theme.of(context).colorScheme.inversePrimary, BlendMode.src),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                )
            );
          } else if(state.isLoggedIn){
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }
    );
  }
}
