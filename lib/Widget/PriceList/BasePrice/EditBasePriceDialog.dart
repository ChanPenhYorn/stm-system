import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/PriceList/PriceListModel.dart';
import 'package:stm_report_app/Entity/PriceList/PricePostModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class EditBasePriceDialog extends StatefulWidget {
  final DefaultPrice price;
  const EditBasePriceDialog({Key? key, required this.price}) : super(key: key);

  @override
  State<EditBasePriceDialog> createState() => _EditBasePriceDialogState();
}

class _EditBasePriceDialogState extends State<EditBasePriceDialog> {
  //Instance
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceCon = TextEditingController();

  //Method
  void onClickSubmit() async {
    priceCon.text = priceCon.text.replaceAll(",", ".");
    Extension.clearFocus(context);

    var result = _formKey.currentState!.validate();
    if (result) {
      var prompt = await PopupDialog.yesNoPrompt(context);
      if (prompt) {
        var body = PricePostModel(
          priceUnit: "usd",
          price: double.parse(
            priceCon.text.trim(),
          ),
        ).toJson();
        var res = await Singleton.instance.apiExtension.post<String, String>(
          context: context,
          baseUrl: ApiEndPoint.priceDefaultUpdate,
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
  void initState() {
    // TODO: implement initState
    priceCon.text = widget.price.price!.toStringAsFixed(2);
    super.initState();
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
                'តម្លៃមូលដ្ឋាន',
                style: StyleColor.textStyleKhmerContentAuto(fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: priceCon,
                validator: (value) {
                  String pattern = r'^\d+(?:[\.,]\d{0,2})?$';
                  RegExp regExp = new RegExp(pattern);
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