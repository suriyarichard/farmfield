import 'package:country_picker/country_picker.dart';
import 'package:farmfield/provider/authProvider.dart';
import 'package:farmfield/widgets/auth/login/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final TextEditingController phoneController = TextEditingController();
  // AuthService authService = AuthService();
  // AuthProvider authProvider = AuthProvider();
  AuthProvider? authProvider;

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Consumer<AuthProvider>(
        builder: (context, authProviderInstance, child) {
      authProvider = authProviderInstance;
      final isLoading = authProviderInstance.isLoading;

      print("_isLoading component render $isLoading");

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.black12,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "Welcome To My Farm",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Enter your Phone No",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      controller: phoneController,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          phoneController.text = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550,
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (!isLoading)
                      GestureDetector(
                        onTap: () async {
                          print("_isLoading $isLoading");
                          await sendPhoneNumber();
                          print("_isLoading after sendphone called $isLoading");
                        },
                        child: CustomButton(
                            child: Text(
                          "Get OTP",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                      ),
                    // if (isLoading) const CircularProgressIndicator()
                    if (isLoading)
                      SpinKitCircle(
                        color: Colors.blue,
                        size: 50,
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> sendPhoneNumber() async {
    String phoneNumber = phoneController.text.trim();
    await authProvider?.signInWithPhone(
        context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
