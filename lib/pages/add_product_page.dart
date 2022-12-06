import 'dart:ffi';

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/helper_function.dart';
class NewProductAddPage extends StatefulWidget {
  static const String routeName = '/add_product';
  const NewProductAddPage({Key? key}) : super(key: key);

  @override
  State<NewProductAddPage> createState() => _NewProductAddPageState();
}

class _NewProductAddPageState extends State<NewProductAddPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? selectedType;
  DateTime? expireDate;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
        actions: [
          IconButton(onPressed: saveProduct,
              icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1
                  )
                )
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return "This field must not be empty";
                }
              },
            ),),
            Padding(padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "Enter Product Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: Colors.blue,
                            width: 1
                        )
                    )
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "This field must not be empty";
                  }
                },
              ),),
            Padding(padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    hintText: "Enter Product Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: Colors.blue,
                            width: 1
                        )
                    )
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "This field must not be empty";
                  }
                },
              ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                          const BorderSide(color: Colors.blue, width: 1))),
                  hint: const Text('Select Product Type'),
                  items: productType
                      .map((e) => DropdownMenuItem(value: e, child: Text(e!)))
                      .toList(),
                  value: selectedType,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: selectDate,
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Select Release Date'),
                  ),
                  Text(expireDate == null
                      ? 'No date chosen'
                      : getFormattedDate(expireDate!, 'dd/MM/yyyy'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveProduct() {
  }

  void selectDate() {
  }
}
