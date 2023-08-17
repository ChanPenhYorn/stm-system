import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:stm_report_app/Entity/Register/Post/RegisterPostModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController firstNameKhCon = TextEditingController();
  TextEditingController lastNameKhCon = TextEditingController();
  TextEditingController firstNameEnCon = TextEditingController();
  TextEditingController lastNameEnCon = TextEditingController();
  TextEditingController userNameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  TextEditingController positionCon = TextEditingController();
  TextEditingController orgCon = TextEditingController();

  void InvalidUser() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ព័ត៌មាន',
              style: TextStyle(fontFamily: 'Khmer OS Moul Light'),
            ),
            content: Text(
              'ឈ្មោះ ឬ លេខសំងាត់ដែលបានបញ្ជូលមិនត្រឹមត្រូវទេ។ \n',
              style: StyleColor.textStyleKhmerContent,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'យល់ព្រម',
                  style: StyleColor.textStyleKhmerContentAuto(
                    color: StyleColor.appBarColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  passwordInputController.clear();
                },
              )
            ],
          );
        });
  }

  void ServerError() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'ព័ត៌មាន',
              style: TextStyle(fontFamily: 'Khmer OS Moul Light'),
            ),
            content: Text(
                'ប្រព័ន្ឋមានបញ្ហាសូមព្យាយាមម្តងទៀត ។ ​\nសូមព្យាយាមម្តងទៀត'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'យល់ព្រម',
                  style: StyleColor.textStyleKhmerContentAuto(
                    color: StyleColor.appBarColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  usernameInputController.clear();
                  passwordInputController.clear();
                },
              )
            ],
          );
        });
  }

  // bool checkInput() {
  //   if (firstNameCon.text.trim().length == 0 ||
  //       lastNameCon.text.trim().length == 0) {
  //     PopupDialog.showPopup(context, "សូមបញ្ជូល នាមត្រកូល នាមខ្លួន");
  //     return false;
  //   } else if (userNameCon.text.trim().length == 0) {
  //     PopupDialog.showPopup(context, "សូមបញ្ជូល ឈ្មោះគណនីប្រើប្រាស់");
  //     return false;
  //   } else if (passwordCon.text.length == 0 ||
  //       confirmPasswordCon.text.length == 0) {
  //     PopupDialog.showPopup(context, "សូមបញ្ជូល លេខសំងាត់");
  //     return false;
  //   } else if (passwordCon.text.length < 8) {
  //     PopupDialog.showPopup(context, "លេខសំងាត់យ៉ាងតិច៨ខ្ទង់");
  //   } else if (passwordCon.text != confirmPasswordCon.text) {
  //     PopupDialog
  //         .showPopup(context, "សូមផ្ទៀងផ្ទាត់លេខសំងាត់ឲ្យបានត្រឹមត្រូវ");
  //     return false;
  //   } else if (phoneCon.text.trim().length == 0) {
  //     PopupDialog.showPopup(context, "សូមបញ្ជូល លេខទូរស័ព្ឋ");
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // _getLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/image/login_background.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            SafeArea(
                child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/image/stm_report_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'ចុះឈ្មោះប្រើប្រាស់',
                        style: StyleColor.textStyleKhmerDangrek18,
                      ),
                    ),
                    Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        margin: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /// Name in Khmer
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regExp = RegExp(
                                                r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                            if (value!.isEmpty) {
                                              return "Message.PleaseInputLastNameKH"
                                                  .tr();
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return "Message.PleaseInputCorrectly"
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: lastNameKhCon,
                                          decoration: InputDecoration(
                                            errorStyle: StyleColor
                                                .textStyleKhmerContent12Red,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                                    color: Colors.grey),
                                            hintText: 'នាមត្រកូល',
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 10,
                                                top: 13,
                                                right: 10,
                                                bottom: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regExp = RegExp(
                                                r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                            if (value!.isEmpty) {
                                              return 'Message.PleaseInputFirstNameKH'
                                                  .tr();
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return "Message.PleaseInputCorrectly"
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: firstNameKhCon,
                                          decoration: InputDecoration(
                                            errorStyle: StyleColor
                                                .textStyleKhmerContent12Red,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                                    color: Colors.grey),
                                            hintText: 'នាមខ្លួន',
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            contentPadding: EdgeInsets.only(
                                                left: 10,
                                                top: 13,
                                                right: 10,
                                                bottom: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //  Name in english
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regExp =
                                                RegExp(r"^[a-zA-Z]");
                                            if (value!.isEmpty) {
                                              return 'Message.PleaseInputLastNameEN'
                                                  .tr();
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return "Message.PleaseInputCorrectly"
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: lastNameEnCon,
                                          decoration: InputDecoration(
                                            errorStyle: StyleColor
                                                .textStyleKhmerContent12Red,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                                    color: Colors.grey),
                                            hintText: 'នាមត្រកូល (ឡាតាំង)',
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 10,
                                                top: 13,
                                                right: 10,
                                                bottom: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regExp =
                                                RegExp(r"^[a-zA-Z]");

                                            if (value!.isEmpty) {
                                              return 'Message.PleaseInputFirstNameEN'
                                                  .tr();
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return "Message.PleaseInputCorrectly"
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: firstNameEnCon,
                                          decoration: InputDecoration(
                                            errorStyle: StyleColor
                                                .textStyleKhmerContent12Red,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                                    color: Colors.grey),
                                            hintText: 'នាមខ្លួន (ឡាតាំង)',
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            contentPadding: EdgeInsets.only(
                                                left: 10,
                                                top: 13,
                                                right: 10,
                                                bottom: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //  Position with org
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regExp = RegExp(
                                                r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                            if (value!.isEmpty) {
                                              return "Message.PleaseInputPosition"
                                                  .tr();
                                            } else if (!regExp
                                                    .hasMatch(value) ||
                                                value.contains(
                                                    RegExp("[A-Za-z]"))) {
                                              return "Message.PleaseInputCorrectly"
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: positionCon,
                                          decoration: InputDecoration(
                                            errorStyle: StyleColor
                                                .textStyleKhmerContent12Red,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                                    color: Colors.grey),
                                            hintText: 'តួនាទី',
                                            prefixIcon:
                                                Icon(Icons.work_outline),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: 10,
                                                top: 13,
                                                right: 10,
                                                bottom: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: double.infinity,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // override textfield's icon color when selected
                                          primaryColor: StyleColor.appBarColor,
                                        ),
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regExp = RegExp(
                                                r"^[ក-អ ា-ោះ្់៊ឧឫឳឱឳឩឪ៌​ឥឯឭឮឬ ៉ៈំាំ័៍ ៌ៅ៏ ៌ៗ៍័៏៎ឦាំឰ]");
                                            if (value!.isEmpty) {
                                              return 'Message.PleaseInputOrg'
                                                  .tr();
                                            } else if (!regExp
                                                    .hasMatch(value) ||
                                                value.contains(
                                                    RegExp("[A-Za-z]"))) {
                                              return "Message.PleaseInputCorrectly"
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              StyleColor.textStyleKhmerContent,
                                          controller: orgCon,
                                          decoration: InputDecoration(
                                            errorStyle: StyleColor
                                                .textStyleKhmerContent12Red,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color:
                                                      StyleColor.appBarColor),
                                            ),
                                            hintStyle: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                                    color: Colors.grey),
                                            hintText: 'អង្គភាព',
                                            prefixIcon:
                                                Icon(Icons.business_outlined),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            contentPadding: EdgeInsets.only(
                                                left: 10,
                                                top: 13,
                                                right: 10,
                                                bottom: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              /// User Account
                              // Container(
                              //   width: double.infinity,
                              //   child: Theme(
                              //     data: Theme.of(context).copyWith(
                              //       // override textfield's icon color when selected
                              //       primaryColor: StyleColor.appBarColor,
                              //     ),
                              //     child: TextFormField(
                              //         validator: (value) {
                              //           if (value!.isEmpty) {
                              //             return 'សូមបញ្ជូលឈ្មោះគណនី';
                              //           }
                              //           return null;
                              //         },
                              //         enableSuggestions: false,
                              //         autocorrect: false,
                              //         style: StyleColor.textStyleKhmerContent,
                              //         controller: userNameCon,
                              //         decoration: InputDecoration(
                              //             errorStyle: StyleColor
                              //                 .textStyleKhmerContent12Red,
                              //             focusedBorder: OutlineInputBorder(
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(10)),
                              //               borderSide: BorderSide(
                              //                   width: 2,
                              //                   color: StyleColor.appBarColor),
                              //             ),
                              //             hintStyle: StyleColor
                              //                 .textStyleKhmerDangrekAuto(color: Colors.grey),
                              //             hintText: 'ឈ្មោះគណនី ',
                              //             prefixIcon: Icon(Icons.person),
                              //             border: OutlineInputBorder(
                              //                 borderRadius: BorderRadius.all(
                              //                     Radius.circular(10))),
                              //             contentPadding: EdgeInsets.only(
                              //                 left: 10,
                              //                 top: 13,
                              //                 right: 10,
                              //                 bottom: 15))),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 15,
                              // ),

                              /// Pwd
                              // Container(
                              //   child: Theme(
                              //     data: Theme.of(context).copyWith(
                              //       // override textfield's icon color when selected
                              //       primaryColor: StyleColor.appBarColor,
                              //     ),
                              //     child: TextFormField(
                              //       style: StyleColor.textStyleKhmerContent,
                              //       controller: passwordCon,
                              //       obscureText: !_passwordVisible,
                              //       validator: (value) {
                              //         if (value!.isEmpty) {
                              //           return 'សូមបញ្ជូលលេខសំងាត់';
                              //         }
                              //         return null;
                              //       },
                              //       autovalidateMode:
                              //           AutovalidateMode.onUserInteraction,
                              //       decoration: InputDecoration(
                              //         errorStyle:
                              //             StyleColor.textStyleKhmerContent12Red,
                              //         focusedBorder: OutlineInputBorder(
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(10)),
                              //           borderSide: BorderSide(
                              //               width: 2,
                              //               color: StyleColor.appBarColor),
                              //         ),
                              //         prefixIcon: Icon(Icons.security),
                              //         hintStyle: StyleColor
                              //             .textStyleKhmerDangrekAuto(),
                              //         hintText: 'ពាក្យសំងាត់',
                              //         border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(10))),
                              //         contentPadding: EdgeInsets.symmetric(
                              //             vertical: 10.0, horizontal: 10.0),
                              //         suffixIcon: IconButton(
                              //           icon: Icon(
                              //             // Based on passwordVisible state choose the icon
                              //             _passwordVisible
                              //                 ? Icons.visibility
                              //                 : Icons.visibility_off,
                              //             color: Colors.grey,
                              //           ),
                              //           onPressed: () {
                              //             // Update the state i.e. toogle the state of passwordVisible variable
                              //             setState(() {
                              //               _passwordVisible =
                              //                   !_passwordVisible;
                              //             });
                              //           },
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 15,
                              // ),

                              /// Phone Number
                              Container(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: StyleColor.appBarColor,
                                  ),
                                  child: TextFormField(
                                    style: StyleColor.textStyleKhmerContent,
                                    controller: phoneCon,
                                    // maxLength: 10,
                                    validator: (value) {
                                      value = value!.replaceAll(" ", "");
                                      String pattern =
                                          r'^\$?(([1-9]\d{0,2}(,\d{3})*)|0)';
                                      RegExp regExp = RegExp(pattern);
                                      if (value.isEmpty) {
                                        return 'Message.PleaseInputPhoneNumber'
                                            .tr();
                                      } else if (!regExp.hasMatch(value) ||
                                          value.length < 9) {
                                        return "Message.PleaseInputCorrectly"
                                            .tr();
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      MaskTextInputFormatter(
                                          mask: "### ### ### #")
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      counter: Offstage(),
                                      errorStyle:
                                          StyleColor.textStyleKhmerContent12Red,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: StyleColor.appBarColor),
                                      ),
                                      hintStyle:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                              color: Colors.grey),
                                      hintText: 'លេខទូរស័ព្ទ',
                                      prefixIcon: Icon(Icons.phone),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              /// Password
                              Container(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: StyleColor.appBarColor,
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Message.PleaseInputPassword"
                                            .tr();
                                      } else if (value.trim().length < 6) {
                                        return "Message.PasswordMoreThan6Char"
                                            .tr();
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: StyleColor.textStyleKhmerContent14,
                                    controller: passwordCon,
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      labelText: "Login.password".tr(),
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                minWidth: 100,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(0),
                                clipBehavior: Clip.antiAlias,
                                onPressed: () async {
                                  Extension.clearFocus(context);
                                  bool available =
                                      _formKey.currentState!.validate();
                                  if (available) {
                                    if (Singleton.instance.userAccountCache
                                                .username !=
                                            null &&
                                        Singleton.instance.userAccountCache
                                                .username !=
                                            "") {
                                      // if (phone ==
                                      //     Singleton.instance.userAccountCache
                                      //         .username!) {
                                      //   phone = "";
                                      // }
                                      // await PopupDialog.showPopup(context,
                                      //     "បន្ទាប់ពីចុះឈ្មោះគណនីថ្មី ${phone}\n នោះគណនីបច្ចុប្បន្ន ${Singleton.instance.userAccountCache.username}\nនឹងមិនអាចចូលប្រើប្រាស់កម្មវិធីក្នុងឧបករណ៍នេះបានទេ លុះត្រាតែមានការអនុញ្ញាតជាថ្មី!",
                                      //     success: 2);
                                    }
                                    var prompt =
                                        await PopupDialog.yesNoPrompt(context);
                                    if (prompt) {
                                      _userRegister();
                                    }
                                    // _popUpDownloadForm();
                                  }
                                  // LoginUser();
                                },
                                child: Text(
                                  'បន្ត',
                                  style: StyleColor.textStyleKhmerDangrek18,
                                  textAlign: TextAlign.center,
                                ),
                                color: StyleColor.appBarColor,
                                textColor: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'មានគណនីហើយ ? ',
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 16,
                                    color: StyleColor.appBarColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }


  Future<void> _userRegister() async {
    var body = RegisterPostModel(
      firstNameEn: firstNameEnCon.text.trim(),
      firstNameKh: firstNameKhCon.text.trim(),
      lastNameEn: lastNameEnCon.text.trim(),
      lastNameKh: lastNameKhCon.text.trim(),
      password: passwordCon.text,
      phoneNumber: MaskTextInputFormatter(mask: "### ### ### #")
          .unmaskText(phoneCon.text.trim()),
      position: positionCon.text.trim(),
      udid: Singleton.instance.udid,
      org: orgCon.text.trim(),
      modelName: Singleton.instance.modelName,
      modelVersion: Singleton.instance.modelVersion,
      qrType: "USER_APPROVAL",
    ).toJson();
    var res = await Singleton.instance.apiExtension.userRegister(
      context,
      body,
    );
    if (res.success!) {
      print(res.data!.toJson());
      await PopupDialog.showSuccess(context, layerContext: 2);
    } else {
      if (res.description == "Invalid input value") {
        PopupDialog.showPopup(context, "Message.Account.InvalidCredential".tr(),
            success: 0);
        return;
      } else {
        PopupDialog.showPopup(
            context, res.description ?? "Message.ServerError".tr(),
            success: 0);
      }
    }
  }
}
