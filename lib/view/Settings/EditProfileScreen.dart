import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/ProfileController.dart';
import '../../controller/SignUpdateController.dart';
import 'DisplaySelectedImagePage.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController profileController = Get.find();
  SignUpdateController updateController = Get.put(SignUpdateController());

  String _selectedImagePath = ""; // Default image path
  DateTime _selectedDate = DateTime(1990, 1, 1); // Default date of birth
  String _selectedGender = "Male"; // Default gender
  String _address = ""; // Default address

  void _pickImage(BuildContext context, ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DisplaySelectedImagePage(imagePath: pickedImage.path),
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    profileController.loadthongtin();
    _selectedImagePath = profileController.Avatar.toString();
    updateController.firstNameController.text =
        profileController.fisrt_name.toString();
    updateController.lastNameController.text =
        profileController.last_name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chỉnh sửa hồ sơ",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.blue,
            ),
            onPressed: () {
              updateController.signup(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage(context, ImageSource.gallery);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipOval(
                  child: Obx(
                        () => Image.network(
                      profileController.Avatar.toString(),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: updateController.firstNameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: updateController.lastNameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Date of Birth:",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: _selectDate,
                  child: Text(
                    "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Gender:",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedGender,
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value ?? "";
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                setState(() {
                  _address = value;
                });
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
