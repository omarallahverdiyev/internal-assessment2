import 'package:flutter/material.dart';
import 'package:internal_assessment_app/buyer/presentation/cart/address_model.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddressForm extends StatefulWidget {
  const AddressForm(
      {super.key, required this.addressFormKey, required this.onSave});

  final Function(AddressModel) onSave;
  final GlobalKey<FormState> addressFormKey;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  late String addressLine1;

  String? addressLine2;

  late String zipCode;

  late PhoneNumber _phoneNumber;

  late String city;

  void _saveForm() {
    if (_addressLine1Controller.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _zipCodeController.text.isNotEmpty) {
      widget.onSave(AddressModel(
        addressLine1: _addressLine1Controller.text,
        addressLine2: _addressLine2Controller.text.isNotEmpty
            ? _addressLine2Controller.text
            : null,
        city: _cityController.text,
        zipCode: _zipCodeController.text,
        phoneNumber: _phoneNumber.toString(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Form(
        key: widget.addressFormKey,
        onChanged: () {
          _saveForm();
        },
        child: Column(
          children: [
            TextFormField(
              controller: _addressLine1Controller,
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text('Address Line 1'),
                  hintText: 'Placeholder for users address'),
              validator: (value) {
                if (value == null) {
                  return 'Please enter an address line';
                }
                return null;
              },
              onSaved: (value) {
                addressLine1 = value!;
              },
            ),
            TextFormField(
              controller: _addressLine2Controller,
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text('Address Line 2'),
                  hintText: 'Placeholder for users address 2'),
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                addressLine2 = value;
              },
            ),
            TextFormField(
              controller: _zipCodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                  label: Text('Kod pocztowy'),
                  hintText: 'Placeholder for users kod pocztowy'),
              validator: (value) {
                if (value == null) {
                  return 'Please enter a value';
                }
                return null;
              },
              onSaved: (value) {
                zipCode = value!;
              },
            ),
            InternationalPhoneNumberInput(
              initialValue: PhoneNumber(isoCode: 'PL'),
              onInputChanged: (PhoneNumber inputtedPhonenumber) {
                setState(() {
                  _phoneNumber = inputtedPhonenumber;
                });
              },
              onInputValidated: (bool isValid) {
                print('Is number validated? : $isValid');
              },
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              textFieldController: TextEditingController(),
              inputDecoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _cityController,
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text('City'), hintText: 'Placeholder for users city'),
              validator: (value) {
                if (value == null) {
                  return 'Please enter a value';
                }
                return null;
              },
              onSaved: (value) {
                city = value!;
              },
            ),
          ],
        ),
      ),
    );
  }
}
