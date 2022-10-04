
import 'package:flutter/material.dart';
import 'package:flutter_graphql/Pages/smartphones_list.dart';
import 'package:flutter_graphql/Services/getSmartphones.service.dart';
import 'package:flutter_graphql/Widget/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Widget/alertDialog.dart';
import '../Widget/button.dart';
import '../globals/globals.dart';
import 'package:connectivity_checker/connectivity_checker.dart';

class AddSmartphone extends StatefulWidget {
  const AddSmartphone({ Key? key }) : super(key: key);
  
  @override
  State<AddSmartphone> createState() => _AddSmartphoneState();
}

class _AddSmartphoneState extends State<AddSmartphone> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? brand ;
  String? displayQuality ;
  String? screenSize ;
  String? camera ;
  String? storage ;
  String? battery ;
  String? operatingSystem ;
  bool _saving=false ;
  bool isVisible=false;
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Scaffold(bottomNavigationBar:  Visibility(
           visible: !isVisible,
          child: ButtonWidget(
                            text: "Add",
                            onClicked: () async{
                              if (!formKey.currentState!.validate())
                              {
                                return ;
                              }
        
                              
                                submit () ;
                             
                            }),
        ),
                          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      hint: "Brand", 
                      icon: const Icon (FontAwesomeIcons.one,size: 10,color: Color(0xffDB9200),), 
                      onChanged: (value) {brand = value.trim();;},
                      validator: (value) {
                          return validateField(value!);
                        },
                        ),
                    TextFieldWidget(
                      hint: "Display quality", 
                      icon:const Icon (FontAwesomeIcons.two,size: 10,color: Color(0xffDB9200),),
                      onChanged: (value) {displayQuality = value.trim();;},
                      validator: (value) {
                          return validateField(value!);
                        },
                      ),
                    TextFieldWidget(
                      hint: "Screen size", 
                      icon:const Icon (FontAwesomeIcons.three,size: 10,color: Color(0xffDB9200),),
                      onChanged: (value) {screenSize = value.trim();;},
                      validator: (value) {
                          return validateField(value!);
                        },
                      ),
                    TextFieldWidget(
                      hint: "Camera", 
                      icon:const Icon (FontAwesomeIcons.four,size: 10,color: Color(0xffDB9200),),
                      onChanged: (value) {camera = value.trim();;},
                      validator: (value) {
                          return validateField(value!);
                        },
                      ),
                    TextFieldWidget(
                      hint: "Storage", 
                      icon: const Icon (FontAwesomeIcons.five,size: 10,color: Color(0xffDB9200),),
                      onChanged: (value) {storage = value.trim();;},
                      validator: (value) {
                          return validateField(value!);
                        },
                      ),
                    TextFieldWidget(
                    hint: "Battery", 
                    icon:const Icon (FontAwesomeIcons.six,size: 10,color: Color(0xffDB9200),),
                    onChanged: (value) {battery = value.trim();;},
                    validator: (value) {
                          return validateField(value!);
                        },
                    ),
                    TextFieldWidget(
                      hint: "Operating system", 
                      icon:const Icon (FontAwesomeIcons.seven,size: 10,color: Color(0xffDB9200),),
                      onChanged: (value) {operatingSystem = value.trim();;},
                      validator: (value) {
                          return validateField(value!);
                        },
                      ),     
                    ]
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
   String? validateField(String value) {
    if (value.trim().isEmpty) return "this field can't be empty";
    return null;
  }
  bool checkValidation() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      formKey.currentState!.save();
      return true;
    }
  }
  void submit()async {
    await APIService.addSmartphone(brand,displayQuality,screenSize,camera,storage,battery,operatingSystem);
    setState(() {
      _saving = true;
      isVisible=true;
    });

    //Simulate a service call
    print('submitting to backend...');
      setState(() {
        _saving = false;
        isVisible=false;
      });
       
        if (await ConnectivityWrapper.instance.isConnected) {
          if (addphone) {
                            //  Get.off(() => const SmartphoneList());
                            showDialog<Dialog>(context: context, builder: (context)=> AlertDialogFb1(title: "Done", description: "Your request has been sent", actions: []));
            }
        return;
        } else {
          showDialog<Dialog>(context: context, builder: (context)=> AlertDialogFb1(title: "Error", description: "Your are not connected", actions: []));
          
        }
      
       
  }
}