import 'package:farmfield/services/register.service.dart';
import 'package:farmfield/widgets/auth/login/customButton.dart';
import 'package:flutter/material.dart';
import '../../../screens/dashboard/dashboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterService registerService = RegisterService();
  var registerUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Join your Village Now",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      color: const Color(0xFF000000)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          //Name field
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Enter your Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: namecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                constraints: const BoxConstraints(
                                  maxHeight: 50,
                                  maxWidth: 327,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Enter your Age",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: agecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter age as  number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                constraints: const BoxConstraints(
                                  maxHeight: 50,
                                  maxWidth: 327,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Enter Your State",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: statecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter State ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                constraints: const BoxConstraints(
                                  maxHeight: 50,
                                  maxWidth: 327,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Enter your District Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: districtcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                constraints: const BoxConstraints(
                                  maxHeight: 50,
                                  maxWidth: 327,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide.none,
                                )),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Terms & Conditions | Privacy Policy",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 20),

                          GestureDetector(
                            onTap: () async => {
                              if (_formKey.currentState!.validate())
                                {
                                  setState(() {
                                    isLoading = true;
                                  }),
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.

                                  registerUser = {
                                    "name": namecontroller.text,
                                    "age": agecontroller.text,
                                    "state": statecontroller.text,
                                    "district": districtcontroller.text,
                                    "createdAt": DateTime.now(),
                                    'crop': []
                                  },
                                  await registerService.add(registerUser),
                                  setState(() {
                                    isLoading = true;
                                  }),
                                  await Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const DashBoard()))),
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content:
                                  //           Text('Successfully registered !!')),
                                  // ),
                                },
                            },
                            child: isLoading == true
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    child: Text(
                                    "Join the village",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white),
                                  )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
