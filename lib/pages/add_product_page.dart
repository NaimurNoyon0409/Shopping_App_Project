import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopping_project/providers/product_provider.dart';

import '../models/product_model.dart';
import '../utils/constants.dart';
import '../utils/helper_function.dart';
class NewProductAddPage extends StatefulWidget {
  static const String routeName = '/add_product';
  const NewProductAddPage({Key? key}) : super(key: key);

  @override
  State<NewProductAddPage> createState() => _NewProductAddPageState();
}

class _NewProductAddPageState extends State<NewProductAddPage> {
  late ProductProvider productProvider;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? selectedType;
  DateTime? expireDate;
  String? imagePath;

  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imagePath == null
                      ? const Icon(
                    Icons.movie,
                    size: 100,
                  )
                      : Image.file(
                    File(imagePath!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  TextButton.icon(
                    onPressed: getImage,
                    icon: const Icon(Icons.photo),
                    label: const Text('Select from Gallery'),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void saveProduct() {
    if (expireDate == null) {
      showMsg(context, 'Please select a date');
      return;
    }
    if (imagePath == null) {
      showMsg(context, 'Please select an image');
      return;
    }
    if (_formkey.currentState!.validate()) {

      final product = ProductModel(
        name: nameController.text,
        image: imagePath!,
        description: descriptionController.text,
        price: int.parse(priceController.text),
        type: selectedType!,
        expire_date: getFormattedDate(expireDate!, 'dd/MM/yyyy'),
      );
/*      if(id != null) {
        product.id = id;
        productProvider.updateProduct(product)
            .then((value) {
          productProvider.getAllMovies();
          Navigator.pop(context, product.name);
        })
            .catchError((error) {
          print(error.toString());
        });
      } else {
        productProvider
            .insertMovie(movie)
            .then((value) {
          productProvider.getAllMovies();
          Navigator.pop(context);
        }).catchError((error) {
          print(error.toString());
        });
      }*/
    productProvider
         .insertProduct(product)
         .then((value) {
           productProvider.getAllProducts();
           Navigator.pop(context);
    }).catchError((error){
      print(error.toString());
    });
    }
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if(selectedDate != null){
      setState(() {
        expireDate = selectedDate;
      });
    }
  }

  void getImage() async{
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file != null)
      {
        setState(() {
          imagePath = file.path;
        });
      }
  }
}
