import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:patient_tracking/Services/medication_service.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/kullandığım_ilaçlar_list.dart';
import '../constraints.dart';

class KullandigimIlaclar extends StatefulWidget {
  static const routeName = '/kullandigim-ilaclar';
  @override
  _KullandigimIlaclarState createState() => _KullandigimIlaclarState();
}

class _KullandigimIlaclarState extends State<KullandigimIlaclar> {
  final appbar = AppBar(
    elevation: 0,
  );

  void fetchMedications(BuildContext context) async {
    var medicationProvider = context.read<MedicineProvider>();
    medicationProvider.empty();
    List<MedicationVariant> list = await MedicationService.getMyMedications();
    list.forEach((element) {
      medicationProvider.addMedicineVariant(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchMedications(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: appbar,
      body: Column(
        children: [
          TopContainer(),
          Container(
              height: MediaQuery.of(context).size.height -
                  (appbar.preferredSize.height + 105),
              child: UsedMeds()),
        ],
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: kPrimaryColor),
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
