import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/PriceList/PricePostModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class AddPriceListDialog extends StatefulWidget {
  const AddPriceListDialog({Key? key}) : super(key: key);

  @override
  State<AddPriceListDialog> createState() => _AddPriceListDialogState();
}

class _AddPriceListDialogState extends State<AddPriceListDialog> {
  //Instance
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  DateTime selectDate = DateTime.now();

  //Method
  void onClickSubmit() async {
    priceCon.text = priceCon.text.replaceAll(",", ".");

    Extension.clearFocus(context);

    var result = _formKey.currentState!.validate();
    if (result) {
      var prompt = await PopupDialog.yesNoPrompt(context);
      if (prompt) {
        var body = PricePostModel(
          date: selectDate.toYYYYMMDD(),
          priceUnit: "usd",
          price: double.parse(
            priceCon.text.trim(),
          ),
        ).toJson();
        var res = await Singleton.instance.apiExtension.post<String, String>(
          context: context,
          baseUrl: ApiEndPoint.priceCreateUpdate,
          body: body,
          loading: true,
          deserialize: (e) => e.toString(),
        );
        if (res.success!) {
          await PopupDialog.showSuccess(
            context,
            data: true,
            layerContext: 2,
          );
        } else {
          await PopupDialog.showFailed(
            context,
            data: false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Extension.clearFocus(context);
        Singleton.instance.handleUserInteraction(context);
      },
      onPanDown: (_) {
        Singleton.instance.handleUserInteraction(context);
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'កាលបរិច្ឆេទ',
                style: StyleColor.textStyleKhmerContentAuto(
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () async {
                  var res = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                      lastDate: DateTime.now().add(
                        Duration(days: 365),
                      ));
                  if (res != null) {
                    print(res);
                    selectDate = res;
                    setState(() {});
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: StyleColor.appBarColor,
                    border: Border.all(color: StyleColor.appBarColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    selectDate.toYYYYMMDD(),
                    style: StyleColor.textStyleDefaultAuto(
                        color: Colors.white, bold: true),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'តម្លៃ',
                style: StyleColor.textStyleKhmerContentAuto(fontSize: 16),
              ),
              TextFormField(
                controller: priceCon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'សូមបញ្ជូលតម្លៃ';
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+(?:[\.,]\d{0,2})?$')),
                ],
                decoration: InputDecoration(
                  prefixText: '\$',
                  errorStyle: StyleColor.textStyleKhmerContent14,
                  labelText: 'តម្លៃទំនិញ',
                  prefixIcon: Icon(
                    Icons.price_change,
                    color: StyleColor.appBarColor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    top: 13,
                    right: 10,
                    bottom: 15,
                  ),
                ),
                style: StyleColor.textStyleKhmerContentAuto(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: StyleColor.appBarColor,
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    child: Text(
                      'បញ្ជូន',
                      style: StyleColor.textStyleKhmerDangrekAuto(
                          fontSize: 16, color: Colors.white),
                    ),
                  ),
                  onPressed: onClickSubmit)
            ],
          ),
        ),
      ),
    );
  }
}
