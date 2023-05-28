import 'package:blocer/bloc/cubit/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameController = TextEditingController( text: "nafish.ahmed.dev@gmail.com",);
  final _passwordController = TextEditingController(text : "@#Password@#");
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 25),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sign In", style: Theme.of(context).textTheme.headlineSmall!.apply(fontWeightDelta: 2)),
                          const SizedBox(height: 20,),
                          Text("Lorem ipsum dollar sit amet, conjecture disciplining elite, sed temper", style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25, top: 60),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please Enter Email";
                          }else if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },
                        decoration:  const InputDecoration(
                            hintText: "Enter email address",
                            label: Text("Email"),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                            hintText: "Enter password",
                            label: const Text("Password"),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(!_showPassword? Icons.visibility_off: Icons.visibility)
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25, top: 30),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state){
                          if(state.isLoading){
                            return Lottie.asset('assets/lotties/loading.json', width: 80,
                                delegates: LottieDelegates(
                                  values: [
                                    ValueDelegate.colorFilter(
                                      ['**'], value: ColorFilter.mode(Theme.of(context).colorScheme.inversePrimary, BlendMode.src),
                                    ),
                                  ],
                                )
                            );
                          }
                          return MaterialButton(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            elevation: 0,
                            colorBrightness: Brightness.dark,
                            minWidth:  MediaQuery.of(context).size.width,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(_usernameController.text, _passwordController.text);
                              }
                            },
                            child: const Text('Sign In'),
                          );
                        },
                      ),
                    ),
                    const Text("©Blocer All rights are resrved")
                  ],
                )
            ),
          )
    );
  }

}