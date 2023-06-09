import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usuario_inri/blocs/blocs.dart';
import 'package:usuario_inri/service/addresses_service.dart';
import 'package:usuario_inri/widgets/button_options.dart';
import 'package:usuario_inri/widgets/custom_message_error.dart';
import 'package:usuario_inri/widgets/custom_message_success.dart';

class ReservarButton extends StatelessWidget {
  const ReservarButton({Key? key}) : super(key: key);

  bool get mounted => true;

  @override
  Widget build(BuildContext context) {
    
    
    late AddressService addressService = AddressService();

    final mapBloc = BlocProvider.of<MapBloc>(context);
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return addressBloc.state.orderUser == null &&
            mapBloc.state.isAccepted == false
        ? Positioned(
            top: 620,
            left: 79,
            right: 60,
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return ButtonOptions(
                    iconData: Icons.thumb_up_alt_outlined,
                    buttonText: 'SOLICITAR UN CONDUCTOR',
                    onTap: () async {


                      //Se reservo un conductor
                      final myLocation = locationBloc.state.lastKnownLocation!;
                      //final ubicacion =  [myLocation.latitude, myLocation.longitude];

                      //final deliveryOk = 
                      await  addressService.postAddresses(myLocation);
                      
                      //final address = deliveryOk.toMap();
                      
                      // ignore: avoid_print
                      //print('*********ADDRESS $address*************'); 

                        if (!mounted) return;

                        if(addressBloc.state.orderUser == null){
                                                 
                        
                         ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: CustomSnackBarContentError(),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          duration: Duration(seconds: 5),
                        ),
                      );

                      }else{

                      //Mostramos mensaje de exito 
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: CustomSnackBarContentSuccess(),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          duration: Duration(seconds: 5),
                        ),
                      );


                      // eventos que manejan la visibilidad de botones
                      mapBloc.add(OnIsAcceptedTravel());
                      mapBloc.add(OnIsAcceptedTravel());    
                        
                      }                      
                      

                    });
              },
            ),
          )
        : const SizedBox();
  }
}


