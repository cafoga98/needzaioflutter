
class ListadoUsers {

  String Id;
  String Name;
  String Email;
  String Username;
  AlbumsClass Albums;

  ListadoUsers(this.Id, this.Name, this.Email, this.Username, this.Albums);

  ListadoUsers.map(Map<String, dynamic> map){
    Id = map['id'];
    Name = map['name'];
    Email = map['email'];
    Username = map['username'];
    Albums = AlbumsClass.map(map['albums']);
  }

}


class AlbumsClass {

  List <DataPhotos> Data;

  AlbumsClass(this.Data);

  AlbumsClass.map(Map<String, dynamic> map){
    var tu = map['data'] as List;
    print(tu);
    List<DataPhotos> fotoList = tu.map((jason) => DataPhotos.map(jason)).toList();
    Data = fotoList;
  }

  factory AlbumsClass.fromJson(dynamic json) {
    return AlbumsClass(
      json['data'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["data"]=this.Data;

    return map;
  }

  Map<String, dynamic> toJson() => {
    "data": this.Data
  };
}

class DataPhotos {

  PhotosClass Photos;

  DataPhotos(this.Photos);

  DataPhotos.map(Map<String, dynamic> map){
    Photos = PhotosClass.map(map['photos']);
  }

  factory DataPhotos.fromJson(dynamic json) {
    return DataPhotos(
      json['photos'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["photos"]=this.Photos;
    return map;
  }

}

class PhotosClass {

  List<DataLinks> Data;

  PhotosClass(this.Data);

  PhotosClass.map(Map<String, dynamic> map){
    var tu = map['data'] as List;
    print(tu);
    List<DataLinks> fotoList = tu.map((jason) => DataLinks.map(jason)).toList();
    Data = fotoList;
  }

  factory PhotosClass.fromJson(dynamic json) {
    return PhotosClass(
      json['data'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["data"]=this.Data;
    return map;
  }
}


class DataLinks {

  String Url;
  String ThumbnailUrl;

  DataLinks(this.Url, this.ThumbnailUrl);

  DataLinks.map(Map<String, dynamic> map){
    Url = map['url'];
    ThumbnailUrl = map['thumbnailUrl'];
  }

  factory DataLinks.fromJson(dynamic json) {
    return DataLinks(
      json['url'],
      json['thumbnailUrl'].toString(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["url"]=this.Url;
    map["thumbnailUrl"]=this.ThumbnailUrl;
    return map;
  }

}
