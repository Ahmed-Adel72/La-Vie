import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_cubit.dart';
import 'package:la_vie/data_layer/bloc/general_cubit/general_states.dart';
import 'package:la_vie/presentation_layer/shared/theme/theme_data.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState()=>_ScanScreenState();
  }
  class _ScanScreenState extends State<ScanScreen> {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    Barcode? result;
    QRViewController? controller;

    void reassemble() {
      super.reassemble();
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralCubit,GeneralStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children:
              [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: primaryColor,
                    borderWidth: 10,
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width*0.65,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:result==null?Align(
                          alignment: AlignmentDirectional.center,
                          child: Text('waiting to scan' ,
                            style:Theme.of(context).textTheme.bodyText2!
                                .copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),
                           ),
                        ):Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Padding(
                              padding: const EdgeInsets.only(left: 35.0),
                              child: Container(
                                  child: Text('Successfully Scan!' ,
                                     style:Theme.of(context).textTheme.bodyText2!
                                         .copyWith(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),
                                 ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Theme.of(context).primaryColor,
                              ),
                              child:const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

    void _onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
          print("////////////fff${result?.code}");
        });
      });
    }

    @override
    void dispose() {
      controller?.dispose();
      super.dispose();
    }

}



