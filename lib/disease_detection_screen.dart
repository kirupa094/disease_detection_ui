import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? _selectedImage;
  bool _isProcessing = false;
  String _apiResponse = '';

  _selectImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _sendApiRequest() async {
    final request =
        http.MultipartRequest('POST', Uri.parse('YOUR_UPLOAD_ENDPOINT'));
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      _selectedImage!.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _apiResponse = responseData.toString();
      });
    } else {
      setState(() {
        _apiResponse = 'Error uploading image: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 214, 41, 18),
          title: const Text(
            'Disease identification',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _selectImage(ImageSource.gallery),
                  child: const Text('Select from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () => _selectImage(ImageSource.camera),
                  child: const Text('Take from Camera'),
                ),
                if (_selectedImage != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.file(_selectedImage!),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : _sendApiRequest,
                    child: !_isProcessing
                        ? const Text('Process Image')
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                if (_apiResponse.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_apiResponse),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
