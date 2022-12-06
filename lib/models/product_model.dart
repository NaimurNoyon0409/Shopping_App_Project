const String tableProduct='tbl_movie';
const String tblProductColId='id';
const String tblProductColName='name';
const String tblProductColImage='image';
const String tblProductColDes='description';
const String tblProductColPrice='price';
const String tblProductColType='type';
const String tblProductColExpireDate='expire_date';

class ProductModel{
  int? id;
  String name;
  String image;
  String description;
  int price;
  String type;
  String expire_date;

  ProductModel({
    this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.type,
    required this.expire_date,
  });

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{
      tblProductColName:name,
      tblProductColDes:description,
      tblProductColImage:image,
      tblProductColPrice:price,
      tblProductColType:type,
      tblProductColExpireDate:expire_date,
    };
    if(id!=null){
      map[tblProductColId]=id;
    }
    return map;
  }

  factory ProductModel.fromMap(Map<String,dynamic> map) => ProductModel(
    id: map[tblProductColId],
    name: map[tblProductColName],
    image: map[tblProductColImage],
    description: map[tblProductColDes],
    price: map[tblProductColPrice],
    type: map[tblProductColType],
    expire_date: map[tblProductColExpireDate],);
}