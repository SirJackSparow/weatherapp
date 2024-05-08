import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/const/utils/utils.dart';
import 'package:weatherapps/presentation/controllers/favorite_controller/favorite_controller_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    HomeUtils.getFavorite(context);
    return  Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, states){
        if(states is FavoriteDataLoaded) {
          return ListView.builder(
              itemCount: states.weatherModel.length,
              itemBuilder: (context, index) {
            return ListTile(
              title: Text(states.weatherModel[index].name),
            );
          }
          );
        } else if (states is FavoriteError){

        }
        return Container();
      }),
    );
  }
}
