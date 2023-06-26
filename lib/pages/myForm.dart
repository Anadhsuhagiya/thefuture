import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../data/globals.dart';
import '../services/apiService.dart';
import '../widgets/DummyForm.dart';
import '../widgets/myTextField.dart';
import 'chatPage.dart';

class MyForm extends StatefulWidget {
  final String id;
  final String title;

  const MyForm({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formFields = {};
  Map<String, dynamic> submittedData = {};
  late Map<String, TextEditingController> formFieldControllers = {};

  Future<Map<String, dynamic>> loadForm() async {
    try {
      var data = await ApiService.getFormData(widget.id);
      if (kDebugMode) {
        print("MyForm: $data");
      }
      return data;
    } catch (err) {
      if (kDebugMode) {
        print("MyForm error : $err");
      }
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    loadForm().then((formJSONbyId) {
      setState(() {});
      submittedData['prompt'] = formJSONbyId['prompt'];
      formJSONbyId['schema']['properties'].forEach((key, value) {
        formFields[key] = value;
        formFieldControllers[key] = TextEditingController(text: value['default'].toString());
      });
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      formFieldControllers.forEach((key, controller) {
        submittedData[key] = controller.text;
      });

      if (openai && isAPIValidated == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Enter a valid API Key'),
            backgroundColor: kRed,
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChatScreen(
              queryController: submittedData.toString(),
              isFormRoute: true,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return formFields.isEmpty
        ? DummyForm(title: widget.title)
        : Scaffold(
      backgroundColor: kTransparent,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.title,
                style:
                const TextStyle(color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              for (var field in formFields.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: FocusTraversalGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            field.value['title'],
                            style: const TextStyle(
                              color: kWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MyTextField(
                          field: field,
                          formFieldControllers: formFieldControllers,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              MaterialButton(
                onPressed: _submitForm,
                color: kAiMsgBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}