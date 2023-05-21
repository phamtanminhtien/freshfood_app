import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfood_app/constant.dart';
import 'package:freshfood_app/module/product/widgets/input_element.dart';
import 'package:freshfood_app/module/providers/walletconnect.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

enum UploadState { idle, uploading, done, error }

class TabCreateProduct extends StatefulWidget {
  const TabCreateProduct({Key? key}) : super(key: key);

  @override
  State<TabCreateProduct> createState() => _TabCreateProductState();
}

class _TabCreateProductState extends State<TabCreateProduct> {
  bool isSelected = false;
  bool isSubmit = false;
  String productName = "";
  String productOrigin = "";

  File? _image;
  String _imageUrl = "";
  UploadState _uploadFile = UploadState.idle;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }

    if (_image != null) {
      setState(() {
        _uploadFile = UploadState.uploading;
      });
      await uploadFile(_image!)
          .then((value) => {
                setState(() {
                  _uploadFile = UploadState.done;
                })
              })
          .catchError(
              (error) => {setState(() => _uploadFile = UploadState.error)});
    }
  }

  Future<void> uploadFile(File file) async {
    try {
      String pinataJwt =
          dotenv.get("PINATA_JWT"); // Replace with your Pinata JWT
      String pinataApiUrl = 'https://api.pinata.cloud/pinning/pinFileToIPFS';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $pinataJwt';

      Response response = await dio.post(pinataApiUrl, data: formData);
      if (response.statusCode == 200) {
        setState(() {
          _imageUrl =
              'https://gateway.pinata.cloud/ipfs/' + response.data['IpfsHash'];
        });
        Fluttertoast.showToast(
          msg: '${file.path} file uploaded successfully.',
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${file.path} file upload failed.',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context);
    return GestureDetector(
        child: Container(
      child: Column(
        children: [
          InputElement(
            icon: Icons.title,
            label: "Product name",
            onChange: (value) => {
              productName = value,
              setState(() {
                isSubmit = false;
              })
            },
          ),
          InputElement(
              icon: Icons.location_on,
              label: "Origin",
              onChange: (value) => {
                    productOrigin = value,
                    setState(() {
                      isSubmit = false;
                    })
                  }),
          isSubmit
              ? const Text(
                  "Please enter fullfill",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                )
              : const SizedBox(),
          Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_image != null)
                  Positioned.fill(
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.image),
                    color: primaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Choose product image'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  GestureDetector(
                                    child: const Text('Gallery'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  GestureDetector(
                                    child: const Text('Camera'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: _uploadFile == UploadState.uploading
                ? const CircularProgressIndicator()
                : _uploadFile == UploadState.done
                    ? const Text("Upload image success")
                    : _uploadFile == UploadState.error
                        ? const Text("Upload image error")
                        : const SizedBox(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (productName == "" || productOrigin == "") {
                  setState(() {
                    isSubmit = true;
                  });
                } else {
                  await walletProvider
                      .addProduct(productName, productOrigin, _imageUrl)
                      .then((result) =>
                          {walletProvider.showAlertDialog(context, result)})
                      .catchError((err) => {
                            walletProvider.showAlertDialog(
                                context, err.toString())
                          });
                }
              },
              child: const Text("Save"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          )
        ],
      ),
    ));
  }
}
