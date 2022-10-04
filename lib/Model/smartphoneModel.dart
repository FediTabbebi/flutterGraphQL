
class Smartphone {
     final String id;
     final String brand;
     final String displayQuality;
     final String screenSize;
     final String camera;
     final String storage;
     final String battery;
     final String operatingSystem;
    Smartphone({
         required this.id,
         required this.brand,
         required this.displayQuality,
         required this.screenSize,
         required this.camera,
         required this.storage,
         required this.battery,
         required this.operatingSystem,
    });
    static  Smartphone fromJson(json)=> Smartphone(
        id: json["id"],
        brand: json["brand"],
        displayQuality : json["Display_Quality"],
        screenSize : json["Screen_Size"],
        camera : json["Camera"],
        storage : json["Storage"],
        battery : json["Battery"],
        operatingSystem : json["Operating_System"],
    

   
    );
   
}
