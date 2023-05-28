import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blocer/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthState{
  bool isLoading;
  bool isLoggedIn;
  String? accessToken;
  Admin? user;
  AuthState({
    required this.isLoading,
    required this.isLoggedIn,
    this.accessToken,
    this.user,
  });

  factory AuthState.fromJson(Map<String, dynamic> data)=>AuthState(
      isLoading: true,
      isLoggedIn: data["isLoggedIn"] ?? false,
      accessToken: data["accessToken"],
      user: data["user"]!=null ? Admin.fromJson(data["user"]) : null
  );

  toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isLoading'] = isLoading;
    data['isLoggedIn'] = isLoggedIn;
    data['accessToken'] = accessToken;
    data['user'] = user != null ? user!.toJson() : null;
    return data;
  }

  static copyWith(AuthState state, {
    bool? isLoading,
    bool? isLoggedIn,
    String? accessToken,
    Admin? user,
  }){
    AuthState newState = AuthState(isLoading: state.isLoading, isLoggedIn: state.isLoggedIn, accessToken: state.accessToken, user: state.user);
    newState.isLoading  = isLoading ?? state.isLoading;
    newState.isLoggedIn  = isLoggedIn ?? state.isLoggedIn;
    newState.accessToken  = accessToken ?? state.accessToken;
    newState.user  = user ?? state.user;
    return newState;
  }
}

class AuthCubit extends Cubit<AuthState> {
  final String _prefsKey = "AUTH_STATE";
  AuthCubit() : super(AuthState(isLoading: true, isLoggedIn: false,));

  login(String email, String password) async {
    emit(AuthState.copyWith(state, isLoading:true));
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final AuthState auth = AuthState(isLoading: false, isLoggedIn: true, user: Admin(id: "0x765f9dd87887e7757f7", name: "Nafish Ahmed", phone: "919123881186"),accessToken: "khgjgdjgdjhgfjhdfg");
    prefs.setString(_prefsKey, jsonEncode(auth.toJson()));
    emit(auth);
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    final AuthState auth = AuthState(isLoading:false, isLoggedIn: false);
    prefs.setString(_prefsKey, jsonEncode(auth.toJson()));
    emit(auth);
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? authState = prefs.getString(_prefsKey);
    if(authState != null){
      final AuthState auth = AuthState.fromJson(jsonDecode(authState));
      auth.isLoading = false;
      emit(auth);
    } else {
      emit(AuthState(isLoading: false, isLoggedIn: false));
    }
  }
}