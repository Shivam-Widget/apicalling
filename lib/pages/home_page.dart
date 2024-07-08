import 'dart:math';

import 'package:apicalling/models/pets.dart';
import 'package:apicalling/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetsProvider>(context);
    provider.getDataFromApi();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider API Call'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(provider.pets),
    );
  }

  Widget getLoadingUI() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 80.0,
          ),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI(Pets pets) {
    return ListView.builder(
        itemCount: pets.data.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            // leading: CircleAvatar(
            //   radius: 22,
            //   backgroundImage: NetworkImage(pets.data[i].petImage),
            //   backgroundColor: Colors.grey,
            // ),
            title: Text(pets.data[i].userName),
            trailing: pets.data[i].isFriendly ? const SizedBox() : const Icon(Icons.pets, color: Colors.red,),
          );
        });
  }
}
