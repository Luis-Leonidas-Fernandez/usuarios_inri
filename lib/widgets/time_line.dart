import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usuario_inri/blocs/blocs.dart';
import 'package:usuario_inri/responsive/responsive_ui.dart';

import 'package:usuario_inri/service/addresses_service.dart';
import 'package:usuario_inri/service/message_service.dart';
import 'package:usuario_inri/service/storage_service.dart';

class TimeLineAddress extends StatelessWidget {

  final MessageService messageService; 
  const TimeLineAddress({super.key, required this.messageService});

  @override
  Widget build(BuildContext context) {

    late ResponsiveUtil responsiveUtil = ResponsiveUtil(context);
    double responsiveTop = responsiveUtil.getResponsiveHeight(0.25);  
    late AddressService addressService = AddressService();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    final storageService = StorageService.instance;

    return addressBloc.state.existOrder == false && addressBloc.state.isAccepted == true? 
    BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              margin: EdgeInsets.only(top: responsiveTop , bottom: 50),
              width: 300,
              height: 400,
              decoration: _cardBorders(),
              child: Stack(
                children: [
                  _AddressDetails(),
                  Align(
                    alignment: Alignment(-0.9, -0.35),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  lineTime(),
                  Align(
                    alignment: Alignment(-0.9, 0),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, 0.35),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  lineTimeTwo(),
                  Align(
                    alignment: Alignment(0, -1.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 18, bottom: 12),
                      height: 50,
                      width: 68,
                      color: Colors.transparent,
                      child: Image.asset('assets/person.jpg'),
                    ),
                  ),
                  Align(
                    alignment: Alignment(
                      -0.1,
                      0.8,
                    ),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.purple,
                        onPressed: () async {

                          //extrae token y idUser del State
                          final String? token = authBloc.state.usuario?.token; 
                          final String? idUser = authBloc.state.usuario?.uid;

                          // Eliminando viaje de base de datos
                          await addressService.finishTravel(token!, idUser!);
                          await storageService.deleteIdDriver();
                          await storageService.deleteIdOrder();  

                          //desactiva mensajes de la address
                          messageService.cancelPeriodicMessage();

                          //eliminar order de state
                          addressBloc.add(OnClearStateEvent());

                          
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 12),
                          child: Text(
                            'CANCELAR',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        )),
                  )
                ],
              ),
            ));
      },
    ): const SizedBox(); 
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.grey[100],       
        border: Border.all(color: Colors.grey)
      );
}

class _AddressDetails extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    late ResponsiveUtil responsiveUtil = ResponsiveUtil(context);   
    final responsiveFont = responsiveUtil.getResponsiveFontSize(31.0);

    const procesado = 'Pedido exitoso';
    const buscando = 'Buscando un Conductor';
    const encontrado = 'Conductor encontrado';

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment(-0.2, 1.0),
              child: Text(
                procesado,
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: responsiveFont,
                    fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment(0.3, 0),
              child: Text(
                buscando,
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: responsiveFont,
                    fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment(0.1, -0.9),
              child: Text(
                encontrado,
                style: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontSize: responsiveFont,
                    fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget lineTime() {
  return Align(
    alignment: Alignment(-0.79, -0.18),
    child: Container(
      height: 25,
      width: 2,
      color: Color.fromARGB(255, 4, 158, 9),
    ),
  );
}

Widget lineTimeTwo() {
  return Align(
    alignment: Alignment(-0.79, 0.15),
    child: Container(
      height: 25,
      width: 2,
      color: Colors.grey,
    ),
  );
}

Widget buttonCancel() {
  return Align(
    alignment: Alignment(
      -0.1,
      0.8,
    ),
    child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        disabledColor: Colors.grey,
        elevation: 0,
        color: Colors.purple,
        onPressed: () async {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
          child: Text(
            'CANCELAR',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        )),
  );
}
