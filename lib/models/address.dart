
import 'dart:convert';



class OrderUser {
    bool? ok;
    String? id;
    String? email;
    String? nombre;
    String? apellido;
    String? vehiculo;
    String? modelo;
    String? patente;
    bool? online;
    String? order;
    bool? estado;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<double>? mensaje;
    String? idDriver;

    OrderUser({
        this.ok,
        this.id,
        this.email,
        this.nombre,
        this.apellido,
        this.vehiculo,
        this.modelo,
        this.patente,
        this.online,
        this.order,
        this.estado,
        this.createdAt,
        this.updatedAt,
        this.mensaje,
         this.idDriver,
    });

   

    String toJson() => json.encode(toMap());

    factory OrderUser.fromJson(Map<String, dynamic> json) => OrderUser(
        ok: json["ok"]?? false,
        id: json["_id"]?? '',
        email: json["email"]?? '',
        nombre: json["nombre"]?? '',
        apellido: json["apellido"]?? '',
        vehiculo: json["vehiculo"]?? '',
        modelo: json["modelo"]?? '',
        patente: json["patente"]?? '',
        online: json["online"]?? false,
        order: json["order"]?? '',
        estado: json["estado"]?? false,
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        mensaje: json["mensaje"] == null ? null :List<double>.from(json["mensaje"].map((x) => x?.toDouble())),
        idDriver: json["idDriver"]??'',
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "_id": id,
        "email": email,
        "nombre": nombre,
        "apellido": apellido,
        "vehiculo": vehiculo,
        "modelo": modelo,
        "patente": patente,
        "online": online,
        "order": order,
        "estado": estado,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "mensaje": List<dynamic>.from(mensaje!.map((x) => x)),
         "idDriver": idDriver,
    };
}

