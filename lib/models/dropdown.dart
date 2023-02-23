import 'package:flutter/material.dart';


List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: const Text("Personal"),value: "Persanal"),
    const DropdownMenuItem(child: const Text("Work"),value: "Work"),
    const DropdownMenuItem(child: const Text("Travel"),value: "Travel"),
    const DropdownMenuItem(child: const Text("Financial"),value: "Financial"),
    const DropdownMenuItem(child: const Text("Gaming"),value: "Gaming"),
  ];
  return menuItems;
}