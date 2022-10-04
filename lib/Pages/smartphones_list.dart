
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_graphql/Model/smartphoneModel.dart';
import 'package:flutter_graphql/Services/getSmartphones.service.dart';
import 'package:flutter_graphql/Widget/listTile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../Widget/button.dart';
import '../Widget/drawer.dart';
import 'addSmartphone.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class SmartphoneList extends StatefulWidget {
  const SmartphoneList({ Key? key }) : super(key: key);

  @override
  State<SmartphoneList> createState() => _SmartphoneListState();
}

class _SmartphoneListState extends State<SmartphoneList> {
  
    late Stream<List<Smartphone>?> smartphonesStream ;
    bool _customTileExpanded = false;
   


  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      APIService.getAllSmartphones() ;
     });
   smartphonesStream =  APIService.getAllSmartphones() ;
   // init();

  }
   void init() async {
   //smartphonesFuture =  APIService.getAllSmartphones() ;

  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar (
          backgroundColor: Colors.black,
        ),
        drawer: const DrawerFb1(),
      backgroundColor: Colors.black,
        body: Column(
                children:[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.25,
                    child:
                           StreamBuilder <List<Smartphone>?> (
                                     stream:smartphonesStream,
                                     builder: (context,snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                        return const Center( child: SpinKitFadingCircle(color: Color(0xffDB9200),size: 50.0,
                                         ),
                                         );
                                         case ConnectionState.done :
                                         default :
                                      if (snapshot.hasError)
                                       {
                                         return Text ("${snapshot.hasError}");
                                       }
                                      
                                       else if (snapshot.data!.isEmpty) {
                                         return const Center(child: Text("You have no Data",style: TextStyle(color:Colors.white),));
                                       }
                                        else if (snapshot.hasData)
                                       {
                                         final smartphones=snapshot.data!;
                                       
                                       return  buildSmartphones(smartphones);
                                       }
                                       else {
                                        return const Center(child: Text("You have no Data",style: TextStyle(color:Colors.white),));
                                       }
                                     }
                                      }
                           ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            
                             child: ButtonWidget(
                              
                                           text: "Add Smartphone",
                                           onClicked: () {
                                            
                                             // if (isLoading) return ;
                                             // setState(() =>
                                             //   isLoading=true 
                                             // );
                                             Get.to(() =>const  AddSmartphone() );
                                           },) 
                               ),
        )
       ],)
         
      ),
    );
      
    
    
  }

 Widget buildSmartphones (List<Smartphone>smartphones )=>ListView.builder(
  scrollDirection: Axis.vertical,
  shrinkWrap: true,
  
  itemCount:smartphones.length ,
  itemBuilder : (context,index) {
    final smartphone = smartphones[index] ;
    { 
 
    
    {return Slidable(
      enabled:!_customTileExpanded,
            endActionPane: ActionPane (motion: const StretchMotion(),
            children: [
              SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: "Delete",
              onPressed: (context)=>delete (smartphones,index)
              )],
              ),
      child: Padding(
    padding: const EdgeInsets.only(left:15.0,right: 15),
    child: Card ( 
            color: const Color (0xff151515),
            shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0)),
            child: ExpansionTile (
               title: Text (smartphone.brand,style: const TextStyle(color: Color(0xffDB9200)), ),
               subtitle: Text(smartphone.operatingSystem,style: const TextStyle(color: Colors.white)),
            children: [
              ListileWidget(
                text:smartphone.displayQuality),
              ListileWidget(
                text:smartphone.screenSize),
                ListileWidget(
                text:smartphone.camera),
                  ListileWidget(
                text:smartphone.storage),
                  ListileWidget(
                text:smartphone.battery),
                  ListileWidget(
                text:smartphone.operatingSystem),
             
            ],
             trailing: Icon(_customTileExpanded?
              Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,color: const Color (0xffDB9200),),
               onExpansionChanged: (bool expanded) {
                setState(() => _customTileExpanded = expanded);
              },
          ),
          ),
  )
    );
    }
 
  }

  
  },
);


void delete(List<Smartphone>smartphones , int index) {
   final smartphone = smartphones[index] ;
   APIService.deleteSmartphone(smartphone.id);
   setState(() {
     
     smartphones.removeAt(index) ;
     showSnackBar(context,"${smartphone.brand} is deleted", Colors.red);
   });

}


 
void showSnackBar(BuildContext context , String title , Color color)
{
  final snackBar=SnackBar(content: Text(title), backgroundColor:color,duration: const Duration(milliseconds : 500));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
}
