import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Role/PermissionGrant.dart';
import 'package:stm_report_app/Entity/Token.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';

enum DeviceType { PHONE, TABLET }

class Extension {
  static void clearFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static Widget getNoImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/image/noimage.jpg',
      ),
    );
  }

  static Widget getNoImageProfile() {
    return Icon(
      Icons.person,
      color: Colors.white,
    );
  }

  static DeviceType getDeviceType() {
    // ignore: deprecated_member_use
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 700 ? DeviceType.PHONE : DeviceType.TABLET;
  }

  static String getTitleBySegmentIndex(
      {required int selectedSegmentType, required DateTime date}) {
    if (selectedSegmentType == 0)
      return "ប្រចាំថ្ងៃ - " + date.toDateKhmerMonthYear();
    else if (selectedSegmentType == 1)
      return "ប្រចាំខែ - " + date.toYear();
    else if (selectedSegmentType == 2) return "ប្រចាំឆ្នាំ - " + date.toYear();
    return "";
  }

  static var jsonSTMReport = {
    "from-date": "2023-01-01",
    "to-date": "2023-01-31",
    "data": [
      {
        "date": "2023-01-01",
        "vehicle-trx": 500,
        "vehicle-total-percent": 0.0345,
        "weight-tonne": 8787.52,
        "weight-total-percent": 0.0315,
        "income-dollar": 907342.6,
        "income-total-percent": 0.0323
      },
      {
        "date": "2023-01-02",
        "vehicle-trx": 370,
        "vehicle-total-percent": 0.0256,
        "weight-tonne": 8725.63,
        "weight-total-percent": 0.0313,
        "income-dollar": 936034.46,
        "income-total-percent": 0.0333
      },
      {
        "date": "2023-01-03",
        "vehicle-trx": 441,
        "vehicle-total-percent": 0.0304,
        "weight-tonne": 9192.84,
        "weight-total-percent": 0.033,
        "income-dollar": 859330.23,
        "income-total-percent": 0.0306
      },
      {
        "date": "2023-01-04",
        "vehicle-trx": 558,
        "vehicle-total-percent": 0.0385,
        "weight-tonne": 8850.09,
        "weight-total-percent": 0.0317,
        "income-dollar": 887157.58,
        "income-total-percent": 0.0316
      },
      {
        "date": "2023-01-05",
        "vehicle-trx": 595,
        "vehicle-total-percent": 0.041,
        "weight-tonne": 9630.47,
        "weight-total-percent": 0.0345,
        "income-dollar": 898032.22,
        "income-total-percent": 0.032
      },
      {
        "date": "2023-01-06",
        "vehicle-trx": 399,
        "vehicle-total-percent": 0.0276,
        "weight-tonne": 8614.76,
        "weight-total-percent": 0.0309,
        "income-dollar": 882478.7,
        "income-total-percent": 0.0314
      },
      {
        "date": "2023-01-07",
        "vehicle-trx": 497,
        "vehicle-total-percent": 0.0343,
        "weight-tonne": 9241.99,
        "weight-total-percent": 0.0331,
        "income-dollar": 912783.58,
        "income-total-percent": 0.0325
      },
      {
        "date": "2023-01-08",
        "vehicle-trx": 405,
        "vehicle-total-percent": 0.0279,
        "weight-tonne": 9238.81,
        "weight-total-percent": 0.0331,
        "income-dollar": 864183.6,
        "income-total-percent": 0.0308
      },
      {
        "date": "2023-01-09",
        "vehicle-trx": 468,
        "vehicle-total-percent": 0.0323,
        "weight-tonne": 8643.31,
        "weight-total-percent": 0.031,
        "income-dollar": 927513.67,
        "income-total-percent": 0.033
      },
      {
        "date": "2023-01-10",
        "vehicle-trx": 467,
        "vehicle-total-percent": 0.0322,
        "weight-tonne": 8798.74,
        "weight-total-percent": 0.0315,
        "income-dollar": 894631.88,
        "income-total-percent": 0.0319
      },
      {
        "date": "2023-01-11",
        "vehicle-trx": 552,
        "vehicle-total-percent": 0.0381,
        "weight-tonne": 9199.08,
        "weight-total-percent": 0.033,
        "income-dollar": 887107.7,
        "income-total-percent": 0.0316
      },
      {
        "date": "2023-01-12",
        "vehicle-trx": 489,
        "vehicle-total-percent": 0.0337,
        "weight-tonne": 9329.46,
        "weight-total-percent": 0.0334,
        "income-dollar": 881424.75,
        "income-total-percent": 0.0314
      },
      {
        "date": "2023-01-13",
        "vehicle-trx": 484,
        "vehicle-total-percent": 0.0334,
        "weight-tonne": 8940.47,
        "weight-total-percent": 0.032,
        "income-dollar": 861135.65,
        "income-total-percent": 0.0307
      },
      {
        "date": "2023-01-14",
        "vehicle-trx": 423,
        "vehicle-total-percent": 0.0292,
        "weight-tonne": 9264.14,
        "weight-total-percent": 0.0332,
        "income-dollar": 934855.8,
        "income-total-percent": 0.0333
      },
      {
        "date": "2023-01-15",
        "vehicle-trx": 419,
        "vehicle-total-percent": 0.0289,
        "weight-tonne": 8878.35,
        "weight-total-percent": 0.0318,
        "income-dollar": 911962.02,
        "income-total-percent": 0.0325
      },
      {
        "date": "2023-01-16",
        "vehicle-trx": 457,
        "vehicle-total-percent": 0.0315,
        "weight-tonne": 8742.27,
        "weight-total-percent": 0.0313,
        "income-dollar": 884223.95,
        "income-total-percent": 0.0315
      },
      {
        "date": "2023-01-17",
        "vehicle-trx": 494,
        "vehicle-total-percent": 0.0341,
        "weight-tonne": 9384.49,
        "weight-total-percent": 0.0336,
        "income-dollar": 938014.73,
        "income-total-percent": 0.0334
      },
      {
        "date": "2023-01-18",
        "vehicle-trx": 384,
        "vehicle-total-percent": 0.0265,
        "weight-tonne": 9024.77,
        "weight-total-percent": 0.0323,
        "income-dollar": 922296.69,
        "income-total-percent": 0.0329
      },
      {
        "date": "2023-01-19",
        "vehicle-trx": 392,
        "vehicle-total-percent": 0.027,
        "weight-tonne": 8891.59,
        "weight-total-percent": 0.0319,
        "income-dollar": 930247.27,
        "income-total-percent": 0.0331
      },
      {
        "date": "2023-01-20",
        "vehicle-trx": 455,
        "vehicle-total-percent": 0.0314,
        "weight-tonne": 8811.67,
        "weight-total-percent": 0.0316,
        "income-dollar": 896110.23,
        "income-total-percent": 0.0319
      },
      {
        "date": "2023-01-21",
        "vehicle-trx": 468,
        "vehicle-total-percent": 0.0323,
        "weight-tonne": 9077.41,
        "weight-total-percent": 0.0325,
        "income-dollar": 867183.78,
        "income-total-percent": 0.0309
      },
      {
        "date": "2023-01-22",
        "vehicle-trx": 506,
        "vehicle-total-percent": 0.0349,
        "weight-tonne": 8852.15,
        "weight-total-percent": 0.0317,
        "income-dollar": 973294.81,
        "income-total-percent": 0.0347
      },
      {
        "date": "2023-01-23",
        "vehicle-trx": 560,
        "vehicle-total-percent": 0.0386,
        "weight-tonne": 9648.33,
        "weight-total-percent": 0.0346,
        "income-dollar": 941433.75,
        "income-total-percent": 0.0335
      },
      {
        "date": "2023-01-24",
        "vehicle-trx": 394,
        "vehicle-total-percent": 0.0272,
        "weight-tonne": 9109.43,
        "weight-total-percent": 0.0327,
        "income-dollar": 904464.12,
        "income-total-percent": 0.0322
      },
      {
        "date": "2023-01-25",
        "vehicle-trx": 458,
        "vehicle-total-percent": 0.0316,
        "weight-tonne": 8737.17,
        "weight-total-percent": 0.0313,
        "income-dollar": 868572.13,
        "income-total-percent": 0.0309
      },
      {
        "date": "2023-01-26",
        "vehicle-trx": 576,
        "vehicle-total-percent": 0.0397,
        "weight-tonne": 8636.22,
        "weight-total-percent": 0.031,
        "income-dollar": 902309.77,
        "income-total-percent": 0.0321
      },
      {
        "date": "2023-01-27",
        "vehicle-trx": 439,
        "vehicle-total-percent": 0.0303,
        "weight-tonne": 9213.32,
        "weight-total-percent": 0.033,
        "income-dollar": 933995.06,
        "income-total-percent": 0.0333
      },
      {
        "date": "2023-01-28",
        "vehicle-trx": 469,
        "vehicle-total-percent": 0.0323,
        "weight-tonne": 8926.61,
        "weight-total-percent": 0.032,
        "income-dollar": 927065.13,
        "income-total-percent": 0.033
      },
      {
        "date": "2023-01-29",
        "vehicle-trx": 448,
        "vehicle-total-percent": 0.0309,
        "weight-tonne": 8822.43,
        "weight-total-percent": 0.0316,
        "income-dollar": 944475.32,
        "income-total-percent": 0.0336
      },
      {
        "date": "2023-01-30",
        "vehicle-trx": 447,
        "vehicle-total-percent": 0.0308,
        "weight-tonne": 8543.09,
        "weight-total-percent": 0.0306,
        "income-dollar": 894731.39,
        "income-total-percent": 0.0319
      },
      {
        "date": "2023-01-31",
        "vehicle-trx": 486,
        "vehicle-total-percent": 0.0335,
        "weight-tonne": 9231.84,
        "weight-total-percent": 0.0331,
        "income-dollar": 896582.58,
        "income-total-percent": 0.0319
      }
    ],
    "total": {
      "vehicle-trx": 14372,
      "weight-tonne": 280847,
      "income-dollar": 27814993.12,
      "maximum-value-vehicle-trx": 559,
      "maximum-value-weight-tonne": 9684,
      "maximum-value-income-dollar": 960769,
      "minimum-value-vehicle-trx": 350,
      "minimum-value-weight-tonne": 8455,
      "minimum-value-income-dollar": 868263
    }
  };

  static var jsonDataTopup = {
    "from-date": "2022-12-01",
    "to-date": "2023-01-01",
    "data": [
      {
        "date": "2022-12-01",
        "amount-obu-total": 6216.85,
        "amount-obu-percent": 0.84,
        "amount-anpr-total": 1187.66,
        "amount-anpr-percent": 0.16,
        "amount-total": 7404.51,
        "transaction-obu-txn": 176,
        "transaction-obu-percent": 0.78,
        "transaction-anpr-txn": 50,
        "transaction-anpr-percent": 0.22,
        "transaction-total": 226,
        "traffic-total": 8354
      },
      {
        "date": "2022-12-02",
        "amount-obu-total": 6033.94,
        "amount-obu-percent": 0.68,
        "amount-anpr-total": 2903.64,
        "amount-anpr-percent": 0.32,
        "amount-total": 8937.58,
        "transaction-obu-txn": 176,
        "transaction-obu-percent": 0.52,
        "transaction-anpr-txn": 163,
        "transaction-anpr-percent": 0.48,
        "transaction-total": 339,
        "traffic-total": 9452
      },
      {
        "date": "2022-12-03",
        "amount-obu-total": 5158.3,
        "amount-obu-percent": 0.58,
        "amount-anpr-total": 3773.12,
        "amount-anpr-percent": 0.42,
        "amount-total": 8931.42,
        "transaction-obu-txn": 200,
        "transaction-obu-percent": 0.47,
        "transaction-anpr-txn": 225,
        "transaction-anpr-percent": 0.53,
        "transaction-total": 425,
        "traffic-total": 11514
      },
      {
        "date": "2022-12-04",
        "amount-obu-total": 5929.79,
        "amount-obu-percent": 0.66,
        "amount-anpr-total": 3117.41,
        "amount-anpr-percent": 0.34,
        "amount-total": 9047.2,
        "transaction-obu-txn": 263,
        "transaction-obu-percent": 0.54,
        "transaction-anpr-txn": 227,
        "transaction-anpr-percent": 0.46,
        "transaction-total": 490,
        "traffic-total": 13614
      },
      {
        "date": "2022-12-05",
        "amount-obu-total": 6555.87,
        "amount-obu-percent": 0.83,
        "amount-anpr-total": 1323.67,
        "amount-anpr-percent": 0.17,
        "amount-total": 7879.54,
        "transaction-obu-txn": 196,
        "transaction-obu-percent": 0.67,
        "transaction-anpr-txn": 95,
        "transaction-anpr-percent": 0.33,
        "transaction-total": 291,
        "traffic-total": 9237
      },
      {
        "date": "2022-12-06",
        "amount-obu-total": 4996.89,
        "amount-obu-percent": 0.75,
        "amount-anpr-total": 1684.58,
        "amount-anpr-percent": 0.25,
        "amount-total": 6681.47,
        "transaction-obu-txn": 188,
        "transaction-obu-percent": 0.65,
        "transaction-anpr-txn": 103,
        "transaction-anpr-percent": 0.35,
        "transaction-total": 291,
        "traffic-total": 8333
      },
      {
        "date": "2022-12-07",
        "amount-obu-total": 5566,
        "amount-obu-percent": 0.55,
        "amount-anpr-total": 4557.04,
        "amount-anpr-percent": 0.45,
        "amount-total": 10123.04,
        "transaction-obu-txn": 200,
        "transaction-obu-percent": 0.45,
        "transaction-anpr-txn": 249,
        "transaction-anpr-percent": 0.55,
        "transaction-total": 449,
        "traffic-total": 8500
      },
      {
        "date": "2022-12-08",
        "amount-obu-total": 6618.84,
        "amount-obu-percent": 0.62,
        "amount-anpr-total": 3988.15,
        "amount-anpr-percent": 0.38,
        "amount-total": 10606.99,
        "transaction-obu-txn": 217,
        "transaction-obu-percent": 0.53,
        "transaction-anpr-txn": 190,
        "transaction-anpr-percent": 0.47,
        "transaction-total": 407,
        "traffic-total": 8987
      },
      {
        "date": "2022-12-09",
        "amount-obu-total": 6826.91,
        "amount-obu-percent": 0.57,
        "amount-anpr-total": 5062.79,
        "amount-anpr-percent": 0.43,
        "amount-total": 11889.7,
        "transaction-obu-txn": 270,
        "transaction-obu-percent": 0.5,
        "transaction-anpr-txn": 270,
        "transaction-anpr-percent": 0.5,
        "transaction-total": 540,
        "traffic-total": 10852
      },
      {
        "date": "2022-12-10",
        "amount-obu-total": 5989.74,
        "amount-obu-percent": 0.42,
        "amount-anpr-total": 8379.8,
        "amount-anpr-percent": 0.58,
        "amount-total": 14369.54,
        "transaction-obu-txn": 282,
        "transaction-obu-percent": 0.37,
        "transaction-anpr-txn": 490,
        "transaction-anpr-percent": 0.63,
        "transaction-total": 772,
        "traffic-total": 13397
      },
      {
        "date": "2022-12-11",
        "amount-obu-total": 7623.35,
        "amount-obu-percent": 0.59,
        "amount-anpr-total": 5217.01,
        "amount-anpr-percent": 0.41,
        "amount-total": 12840.36,
        "transaction-obu-txn": 333,
        "transaction-obu-percent": 0.47,
        "transaction-anpr-txn": 379,
        "transaction-anpr-percent": 0.53,
        "transaction-total": 712,
        "traffic-total": 15482
      },
      {
        "date": "2022-12-12",
        "amount-obu-total": 12223.44,
        "amount-obu-percent": 0.77,
        "amount-anpr-total": 3709.48,
        "amount-anpr-percent": 0.23,
        "amount-total": 15932.92,
        "transaction-obu-txn": 523,
        "transaction-obu-percent": 0.66,
        "transaction-anpr-txn": 271,
        "transaction-anpr-percent": 0.34,
        "transaction-total": 794,
        "traffic-total": 9927
      },
      {
        "date": "2022-12-13",
        "amount-obu-total": 5929.35,
        "amount-obu-percent": 0.69,
        "amount-anpr-total": 2651.57,
        "amount-anpr-percent": 0.31,
        "amount-total": 8580.92,
        "transaction-obu-txn": 238,
        "transaction-obu-percent": 0.64,
        "transaction-anpr-txn": 132,
        "transaction-anpr-percent": 0.36,
        "transaction-total": 370,
        "traffic-total": 8740
      },
      {
        "date": "2022-12-14",
        "amount-obu-total": 7559.36,
        "amount-obu-percent": 0.81,
        "amount-anpr-total": 1731.73,
        "amount-anpr-percent": 0.19,
        "amount-total": 9291.09,
        "transaction-obu-txn": 275,
        "transaction-obu-percent": 0.72,
        "transaction-anpr-txn": 109,
        "transaction-anpr-percent": 0.28,
        "transaction-total": 384,
        "traffic-total": 8909
      },
      {
        "date": "2022-12-15",
        "amount-obu-total": 6137.69,
        "amount-obu-percent": 0.7,
        "amount-anpr-total": 2655.63,
        "amount-anpr-percent": 0.3,
        "amount-total": 8793.32,
        "transaction-obu-txn": 283,
        "transaction-obu-percent": 0.65,
        "transaction-anpr-txn": 153,
        "transaction-anpr-percent": 0.35,
        "transaction-total": 436,
        "traffic-total": 9145
      },
      {
        "date": "2022-12-16",
        "amount-obu-total": 6940.69,
        "amount-obu-percent": 0.65,
        "amount-anpr-total": 3783.77,
        "amount-anpr-percent": 0.35,
        "amount-total": 10724.46,
        "transaction-obu-txn": 277,
        "transaction-obu-percent": 0.55,
        "transaction-anpr-txn": 228,
        "transaction-anpr-percent": 0.45,
        "transaction-total": 505,
        "traffic-total": 10731
      },
      {
        "date": "2022-12-17",
        "amount-obu-total": 8636.67,
        "amount-obu-percent": 0.54,
        "amount-anpr-total": 7263.07,
        "amount-anpr-percent": 0.46,
        "amount-total": 15899.74,
        "transaction-obu-txn": 355,
        "transaction-obu-percent": 0.47,
        "transaction-anpr-txn": 401,
        "transaction-anpr-percent": 0.53,
        "transaction-total": 756,
        "traffic-total": 13803
      },
      {
        "date": "2022-12-18",
        "amount-obu-total": 8148.11,
        "amount-obu-percent": 0.57,
        "amount-anpr-total": 6122.05,
        "amount-anpr-percent": 0.43,
        "amount-total": 14270.16,
        "transaction-obu-txn": 361,
        "transaction-obu-percent": 0.47,
        "transaction-anpr-txn": 412,
        "transaction-anpr-percent": 0.53,
        "transaction-total": 773,
        "traffic-total": 15270
      },
      {
        "date": "2022-12-19",
        "amount-obu-total": 7315.5,
        "amount-obu-percent": 0.73,
        "amount-anpr-total": 2754.43,
        "amount-anpr-percent": 0.27,
        "amount-total": 10069.93,
        "transaction-obu-txn": 286,
        "transaction-obu-percent": 0.61,
        "transaction-anpr-txn": 185,
        "transaction-anpr-percent": 0.39,
        "transaction-total": 471,
        "traffic-total": 10251
      },
      {
        "date": "2022-12-20",
        "amount-obu-total": 7391.37,
        "amount-obu-percent": 0.71,
        "amount-anpr-total": 3079.33,
        "amount-anpr-percent": 0.29,
        "amount-total": 10470.7,
        "transaction-obu-txn": 302,
        "transaction-obu-percent": 0.67,
        "transaction-anpr-txn": 150,
        "transaction-anpr-percent": 0.33,
        "transaction-total": 452,
        "traffic-total": 9144
      },
      {
        "date": "2022-12-21",
        "amount-obu-total": 7055.54,
        "amount-obu-percent": 0.72,
        "amount-anpr-total": 2764.21,
        "amount-anpr-percent": 0.28,
        "amount-total": 9819.75,
        "transaction-obu-txn": 291,
        "transaction-obu-percent": 0.61,
        "transaction-anpr-txn": 185,
        "transaction-anpr-percent": 0.39,
        "transaction-total": 476,
        "traffic-total": 9505
      },
      {
        "date": "2022-12-22",
        "amount-obu-total": 8213.48,
        "amount-obu-percent": 0.71,
        "amount-anpr-total": 3318,
        "amount-anpr-percent": 0.29,
        "amount-total": 11531.48,
        "transaction-obu-txn": 318,
        "transaction-obu-percent": 0.62,
        "transaction-anpr-txn": 196,
        "transaction-anpr-percent": 0.38,
        "transaction-total": 514,
        "traffic-total": 9291
      },
      {
        "date": "2022-12-23",
        "amount-obu-total": 10211.11,
        "amount-obu-percent": 0.67,
        "amount-anpr-total": 5109.25,
        "amount-anpr-percent": 0.33,
        "amount-total": 15320.36,
        "transaction-obu-txn": 366,
        "transaction-obu-percent": 0.57,
        "transaction-anpr-txn": 281,
        "transaction-anpr-percent": 0.43,
        "transaction-total": 647,
        "traffic-total": 10354
      },
      {
        "date": "2022-12-24",
        "amount-obu-total": 12430.69,
        "amount-obu-percent": 0.61,
        "amount-anpr-total": 7910.85,
        "amount-anpr-percent": 0.39,
        "amount-total": 20341.54,
        "transaction-obu-txn": 478,
        "transaction-obu-percent": 0.52,
        "transaction-anpr-txn": 441,
        "transaction-anpr-percent": 0.48,
        "transaction-total": 919,
        "traffic-total": 13788
      },
      {
        "date": "2022-12-25",
        "amount-obu-total": 14335.38,
        "amount-obu-percent": 0.69,
        "amount-anpr-total": 6467.26,
        "amount-anpr-percent": 0.31,
        "amount-total": 20802.64,
        "transaction-obu-txn": 574,
        "transaction-obu-percent": 0.59,
        "transaction-anpr-txn": 396,
        "transaction-anpr-percent": 0.41,
        "transaction-total": 970,
        "traffic-total": 15339
      },
      {
        "date": "2022-12-26",
        "amount-obu-total": 11296.92,
        "amount-obu-percent": 0.77,
        "amount-anpr-total": 3427.1,
        "amount-anpr-percent": 0.23,
        "amount-total": 14724.02,
        "transaction-obu-txn": 500,
        "transaction-obu-percent": 0.7,
        "transaction-anpr-txn": 210,
        "transaction-anpr-percent": 0.3,
        "transaction-total": 710,
        "traffic-total": 10862
      },
      {
        "date": "2022-12-27",
        "amount-obu-total": 12716.78,
        "amount-obu-percent": 0.76,
        "amount-anpr-total": 3925.77,
        "amount-anpr-percent": 0.24,
        "amount-total": 16642.55,
        "transaction-obu-txn": 462,
        "transaction-obu-percent": 0.67,
        "transaction-anpr-txn": 228,
        "transaction-anpr-percent": 0.33,
        "transaction-total": 690,
        "traffic-total": 9700
      },
      {
        "date": "2022-12-28",
        "amount-obu-total": 12386.32,
        "amount-obu-percent": 0.72,
        "amount-anpr-total": 4848.07,
        "amount-anpr-percent": 0.28,
        "amount-total": 17234.39,
        "transaction-obu-txn": 483,
        "transaction-obu-percent": 0.66,
        "transaction-anpr-txn": 246,
        "transaction-anpr-percent": 0.34,
        "transaction-total": 729,
        "traffic-total": 10592
      },
      {
        "date": "2022-12-29",
        "amount-obu-total": 15243.89,
        "amount-obu-percent": 0.75,
        "amount-anpr-total": 5173.95,
        "amount-anpr-percent": 0.25,
        "amount-total": 20417.84,
        "transaction-obu-txn": 558,
        "transaction-obu-percent": 0.66,
        "transaction-anpr-txn": 291,
        "transaction-anpr-percent": 0.34,
        "transaction-total": 849,
        "traffic-total": 10793
      },
      {
        "date": "2022-12-30",
        "amount-obu-total": 20700.73,
        "amount-obu-percent": 0.63,
        "amount-anpr-total": 12015.89,
        "amount-anpr-percent": 0.37,
        "amount-total": 32716.62,
        "transaction-obu-txn": 874,
        "transaction-obu-percent": 0.58,
        "transaction-anpr-txn": 628,
        "transaction-anpr-percent": 0.42,
        "transaction-total": 1502,
        "traffic-total": 14560
      },
      {
        "date": "2022-12-31",
        "amount-obu-total": 22585.28,
        "amount-obu-percent": 0.6,
        "amount-anpr-total": 15040.58,
        "amount-anpr-percent": 0.4,
        "amount-total": 37625.86,
        "transaction-obu-txn": 946,
        "transaction-obu-percent": 0.53,
        "transaction-anpr-txn": 853,
        "transaction-anpr-percent": 0.47,
        "transaction-total": 1799,
        "traffic-total": 18804
      },
      {
        "date": "2023-01-01",
        "amount-obu-total": 24883.21,
        "amount-obu-percent": 0.68,
        "amount-anpr-total": 11620.77,
        "amount-anpr-percent": 0.32,
        "amount-total": 36503.98,
        "transaction-obu-txn": 1254,
        "transaction-obu-percent": 0.59,
        "transaction-anpr-txn": 881,
        "transaction-anpr-percent": 0.41,
        "transaction-total": 2135,
        "traffic-total": 22783
      }
    ],
    "average": {
      "amount-obu-total": 9683.06,
      "amount-obu-percent": 0.67,
      "amount-anpr-total": 4892.74,
      "amount-anpr-percent": 0.33,
      "amount-total": 14575.8,
      "transaction-obu-txn": 391,
      "transaction-obu-percent": 0.58,
      "transaction-anpr-txn": 291,
      "transaction-anpr-percent": 0.42,
      "transaction-total": 682
    }
  };

  static var jsonDataDeduction = {
    "from-date": "2022-12-01",
    "to-date": "2023-01-01",
    "data": [
      {
        "date": "2022-12-15",
        "amount-obu-dollar": 7353.76,
        "amount-obu-total-percent": 0.16,
        "amount-anpr-dollar": 1576.08,
        "amount-anpr-total-percent": 0.03,
        "amount-iccard-dollar": 37646.13,
        "amount-iccard-total-percent": 0.81,
        "amount-total": 46575.97,
        "transaction-obu": 1306,
        "transaction-obu-total-percent": 0.19,
        "transaction-anpr": 173,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 5223,
        "transaction-iccard-total-percent": 0.78,
        "transaction-total": 6702,
        "traffic-total": 9145
      },
      {
        "date": "2022-12-16",
        "amount-obu-dollar": 7911.72,
        "amount-obu-total-percent": 0.06,
        "amount-anpr-dollar": 2506.98,
        "amount-anpr-total-percent": 0.02,
        "amount-iccard-dollar": 116525.93,
        "amount-iccard-total-percent": 0.92,
        "amount-total": 126944.63,
        "transaction-obu": 1375,
        "transaction-obu-total-percent": 0.13,
        "transaction-anpr": 260,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 8659,
        "transaction-iccard-total-percent": 0.84,
        "transaction-total": 10294,
        "traffic-total": 10731
      },
      {
        "date": "2022-12-17",
        "amount-obu-dollar": 8191.92,
        "amount-obu-total-percent": 0.08,
        "amount-anpr-dollar": 5189.88,
        "amount-anpr-total-percent": 0.05,
        "amount-iccard-dollar": 90026.43,
        "amount-iccard-total-percent": 0.87,
        "amount-total": 103408.23,
        "transaction-obu": 1494,
        "transaction-obu-total-percent": 0.11,
        "transaction-anpr": 518,
        "transaction-anpr-total-percent": 0.04,
        "transaction-iccard": 11325,
        "transaction-iccard-total-percent": 0.85,
        "transaction-total": 13337,
        "traffic-total": 13803
      },
      {
        "date": "2022-12-18",
        "amount-obu-dollar": 9085.67,
        "amount-obu-total-percent": 0.08,
        "amount-anpr-dollar": 6516.74,
        "amount-anpr-total-percent": 0.06,
        "amount-iccard-dollar": 94039.57,
        "amount-iccard-total-percent": 0.86,
        "amount-total": 109641.98,
        "transaction-obu": 1566,
        "transaction-obu-total-percent": 0.11,
        "transaction-anpr": 622,
        "transaction-anpr-total-percent": 0.04,
        "transaction-iccard": 11894,
        "transaction-iccard-total-percent": 0.84,
        "transaction-total": 14082,
        "traffic-total": 15270
      },
      {
        "date": "2022-12-19",
        "amount-obu-dollar": 7904.27,
        "amount-obu-total-percent": 0.11,
        "amount-anpr-dollar": 2577.22,
        "amount-anpr-total-percent": 0.03,
        "amount-iccard-dollar": 63686.79,
        "amount-iccard-total-percent": 0.86,
        "amount-total": 74168.28,
        "transaction-obu": 1456,
        "transaction-obu-total-percent": 0.15,
        "transaction-anpr": 259,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 8174,
        "transaction-iccard-total-percent": 0.83,
        "transaction-total": 9889,
        "traffic-total": 10251
      },
      {
        "date": "2022-12-20",
        "amount-obu-dollar": 7131.77,
        "amount-obu-total-percent": 0.11,
        "amount-anpr-dollar": 2082.6,
        "amount-anpr-total-percent": 0.03,
        "amount-iccard-dollar": 53355.59,
        "amount-iccard-total-percent": 0.85,
        "amount-total": 62569.96,
        "transaction-obu": 1402,
        "transaction-obu-total-percent": 0.16,
        "transaction-anpr": 193,
        "transaction-anpr-total-percent": 0.02,
        "transaction-iccard": 7270,
        "transaction-iccard-total-percent": 0.82,
        "transaction-total": 8865,
        "traffic-total": 9144
      },
      {
        "date": "2022-12-21",
        "amount-obu-dollar": 7292.85,
        "amount-obu-total-percent": 0.11,
        "amount-anpr-dollar": 2452.1,
        "amount-anpr-total-percent": 0.04,
        "amount-iccard-dollar": 55539.22,
        "amount-iccard-total-percent": 0.85,
        "amount-total": 65284.17,
        "transaction-obu": 1463,
        "transaction-obu-total-percent": 0.16,
        "transaction-anpr": 255,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 7419,
        "transaction-iccard-total-percent": 0.81,
        "transaction-total": 9137,
        "traffic-total": 9505
      },
      {
        "date": "2022-12-22",
        "amount-obu-dollar": 7516.94,
        "amount-obu-total-percent": 0.12,
        "amount-anpr-dollar": 2423.76,
        "amount-anpr-total-percent": 0.04,
        "amount-iccard-dollar": 52507.16,
        "amount-iccard-total-percent": 0.84,
        "amount-total": 62447.86,
        "transaction-obu": 1464,
        "transaction-obu-total-percent": 0.16,
        "transaction-anpr": 264,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 7206,
        "transaction-iccard-total-percent": 0.81,
        "transaction-total": 8934,
        "traffic-total": 9291
      },
      {
        "date": "2022-12-23",
        "amount-obu-dollar": 8578.82,
        "amount-obu-total-percent": 0.12,
        "amount-anpr-dollar": 2980.21,
        "amount-anpr-total-percent": 0.04,
        "amount-iccard-dollar": 61630.77,
        "amount-iccard-total-percent": 0.84,
        "amount-total": 73189.8,
        "transaction-obu": 1578,
        "transaction-obu-total-percent": 0.16,
        "transaction-anpr": 298,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 8142,
        "transaction-iccard-total-percent": 0.81,
        "transaction-total": 10018,
        "traffic-total": 10354
      },
      {
        "date": "2022-12-24",
        "amount-obu-dollar": 10392.52,
        "amount-obu-total-percent": 0.1,
        "amount-anpr-dollar": 5917.88,
        "amount-anpr-total-percent": 0.06,
        "amount-iccard-dollar": 87232.69,
        "amount-iccard-total-percent": 0.84,
        "amount-total": 103543.09,
        "transaction-obu": 1809,
        "transaction-obu-total-percent": 0.14,
        "transaction-anpr": 574,
        "transaction-anpr-total-percent": 0.04,
        "transaction-iccard": 10964,
        "transaction-iccard-total-percent": 0.82,
        "transaction-total": 13347,
        "traffic-total": 13788
      },
      {
        "date": "2022-12-25",
        "amount-obu-dollar": 12693.88,
        "amount-obu-total-percent": 0.11,
        "amount-anpr-dollar": 6656,
        "amount-anpr-total-percent": 0.06,
        "amount-iccard-dollar": 93383.14,
        "amount-iccard-total-percent": 0.83,
        "amount-total": 112733.02,
        "transaction-obu": 2068,
        "transaction-obu-total-percent": 0.14,
        "transaction-anpr": 645,
        "transaction-anpr-total-percent": 0.05,
        "transaction-iccard": 11587,
        "transaction-iccard-total-percent": 0.81,
        "transaction-total": 14300,
        "traffic-total": 15339
      },
      {
        "date": "2022-12-26",
        "amount-obu-dollar": 9890.23,
        "amount-obu-total-percent": 0.09,
        "amount-anpr-dollar": 2878.36,
        "amount-anpr-total-percent": 0.03,
        "amount-iccard-dollar": 95866.21,
        "amount-iccard-total-percent": 0.88,
        "amount-total": 108634.8,
        "transaction-obu": 1789,
        "transaction-obu-total-percent": 0.17,
        "transaction-anpr": 283,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 8439,
        "transaction-iccard-total-percent": 0.8,
        "transaction-total": 10511,
        "traffic-total": 10862
      },
      {
        "date": "2022-12-27",
        "amount-obu-dollar": 9368.58,
        "amount-obu-total-percent": 0.13,
        "amount-anpr-dollar": 2686.16,
        "amount-anpr-total-percent": 0.04,
        "amount-iccard-dollar": 58020.34,
        "amount-iccard-total-percent": 0.83,
        "amount-total": 70075.08,
        "transaction-obu": 1695,
        "transaction-obu-total-percent": 0.18,
        "transaction-anpr": 263,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 7414,
        "transaction-iccard-total-percent": 0.79,
        "transaction-total": 9372,
        "traffic-total": 9700
      },
      {
        "date": "2022-12-28",
        "amount-obu-dollar": 9198.58,
        "amount-obu-total-percent": 0.12,
        "amount-anpr-dollar": 2512.33,
        "amount-anpr-total-percent": 0.03,
        "amount-iccard-dollar": 62328.82,
        "amount-iccard-total-percent": 0.84,
        "amount-total": 74039.73,
        "transaction-obu": 1701,
        "transaction-obu-total-percent": 0.17,
        "transaction-anpr": 271,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 7926,
        "transaction-iccard-total-percent": 0.8,
        "transaction-total": 9898,
        "traffic-total": 10592
      },
      {
        "date": "2022-12-29",
        "amount-obu-dollar": 11018.16,
        "amount-obu-total-percent": 0.14,
        "amount-anpr-dollar": 2514.6,
        "amount-anpr-total-percent": 0.03,
        "amount-iccard-dollar": 63347.89,
        "amount-iccard-total-percent": 0.82,
        "amount-total": 76880.65,
        "transaction-obu": 1897,
        "transaction-obu-total-percent": 0.18,
        "transaction-anpr": 264,
        "transaction-anpr-total-percent": 0.03,
        "transaction-iccard": 8277,
        "transaction-iccard-total-percent": 0.79,
        "transaction-total": 10438,
        "traffic-total": 10793
      },
      {
        "date": "2022-12-30",
        "amount-obu-dollar": 15326.36,
        "amount-obu-total-percent": 0.14,
        "amount-anpr-dollar": 6610.83,
        "amount-anpr-total-percent": 0.06,
        "amount-iccard-dollar": 89143.36,
        "amount-iccard-total-percent": 0.8,
        "amount-total": 111080.55,
        "transaction-obu": 2441,
        "transaction-obu-total-percent": 0.17,
        "transaction-anpr": 624,
        "transaction-anpr-total-percent": 0.04,
        "transaction-iccard": 11054,
        "transaction-iccard-total-percent": 0.78,
        "transaction-total": 14119,
        "traffic-total": 14560
      },
      {
        "date": "2022-12-31",
        "amount-obu-dollar": 15311.71,
        "amount-obu-total-percent": 0.11,
        "amount-anpr-dollar": 11155.19,
        "amount-anpr-total-percent": 0.08,
        "amount-iccard-dollar": 117765.66,
        "amount-iccard-total-percent": 0.82,
        "amount-total": 144232.56,
        "transaction-obu": 2496,
        "transaction-obu-total-percent": 0.14,
        "transaction-anpr": 1072,
        "transaction-anpr-total-percent": 0.06,
        "transaction-iccard": 14527,
        "transaction-iccard-total-percent": 0.8,
        "transaction-total": 18095,
        "traffic-total": 18804
      },
      {
        "date": "2023-01-01",
        "amount-obu-dollar": 22227.17,
        "amount-obu-total-percent": 0.13,
        "amount-anpr-dollar": 13251.73,
        "amount-anpr-total-percent": 0.08,
        "amount-iccard-dollar": 129913.15,
        "amount-iccard-total-percent": 0.79,
        "amount-total": 165392.05,
        "transaction-obu": 3348,
        "transaction-obu-total-percent": 0.16,
        "transaction-anpr": 1318,
        "transaction-anpr-total-percent": 0.06,
        "transaction-iccard": 16531,
        "transaction-iccard-total-percent": 0.78,
        "transaction-total": 21197
      }
    ],
    "average": {
      "amount-obu-dollar": 8293.68,
      "amount-obu-total-percent": 0.37,
      "amount-anpr-dollar": 3659.1,
      "amount-anpr-total-percent": 0.14,
      "amount-iccard-dollar": 44513.44,
      "amount-iccard-total-percent": 0.48,
      "amount-total": 56466.22,
      "transaction-obu": 1450,
      "transaction-obu-total-percent": 0.43,
      "transaction-anpr": 367,
      "transaction-anpr-total-percent": 0.1,
      "transaction-iccard": 5389,
      "transaction-iccard-total-percent": 0.46,
      "transaction-total": 7206,
      "traffic-total": 11201
    }
  };

  static var jsonTechInspection = [
    {
      "title": "Tech Inspection Penalty Income",
      "from-date": "2021-01-01",
      "to-date": "2022-12-31",
      "year-data": [
        {
          "year": "2021",
          "month-data:": [
            {"month": "May", "value": 490163801},
            {"month": "June", "value": 749039510},
            {"month": "July", "value": 811306003},
            {"month": "August", "value": 919484298},
            {"month": "September", "value": 1216459501},
            {"month": "October", "value": 1482335098},
            {"month": "November", "value": 2984515000},
            {"month": "December", "value": 1781683599}
          ],
          "total": 10434986810
        },
        {
          "year": "2022",
          "month-data:": [
            {"month": "May", "value": 1386623500},
            {"month": "June", "value": 1408797500},
            {"month": "July", "value": 1591411000},
            {"month": "August", "value": 3029794500},
            {"month": "September", "value": 1895364000},
            {"month": "October", "value": 2251570000},
            {"month": "November", "value": 2266161500},
            {"month": "December", "value": 1655853500}
          ],
          "total": 15485575500
        }
      ],
      "change-amount": {
        "month-data": [
          {"month": "May", "value": 896459699},
          {"month": "June", "value": 659757990},
          {"month": "July", "value": 780104997},
          {"month": "August", "value": 2110310202},
          {"month": "September", "value": 678904499},
          {"month": "October", "value": 769234902},
          {"month": "November", "value": -718353500},
          {"month": "December", "value": -125830099}
        ],
        "total": 5050588690
      },
      "change-percent": {
        "month-data": [
          {"month": "May", "value": 182.9},
          {"month": "June", "value": 88.1},
          {"month": "July", "value": 96.2},
          {"month": "August", "value": 229.5},
          {"month": "September", "value": 55.8},
          {"month": "October", "value": 51.9},
          {"month": "November", "value": -24.1},
          {"month": "December", "value": -7.1}
        ],
        "total": 48.40
      }
    },
    {
      "title": "Tech Inspection Income",
      "from-date": "2021-01-01",
      "to-date": "2022-12-31",
      "year-data": [
        {
          "year": "2021",
          "month-data:": [
            {"month": "May", "value": 1453126800},
            {"month": "June", "value": 2088712300},
            {"month": "July", "value": 2032702600},
            {"month": "August", "value": 2073328500},
            {"month": "September", "value": 2440675001},
            {"month": "October", "value": 2494145999},
            {"month": "November", "value": 2792312000},
            {"month": "December", "value": 3977312099}
          ],
          "total": 19352315299
        },
        {
          "year": "2022",
          "month-data:": [
            {"month": "May", "value": 2260418000},
            {"month": "June", "value": 2308550000},
            {"month": "July", "value": 2311016000},
            {"month": "August", "value": 2933736000},
            {"month": "September", "value": 2069606000},
            {"month": "October", "value": 2502419000},
            {"month": "November", "value": 2319184000},
            {"month": "December", "value": 1914979000}
          ],
          "total": 18619908000
        }
      ],
      "change-amount": {
        "month-data": [
          {"month": "May", "value": 807291200},
          {"month": "June", "value": 219837700},
          {"month": "July", "value": 278313400},
          {"month": "August", "value": 860407500},
          {"month": "September", "value": -371069001},
          {"month": "October", "value": 8273001},
          {"month": "November", "value": -473128000},
          {"month": "December", "value": -2062333099}
        ],
        "total": -732407299
      },
      "change-percent": {
        "month-data": [
          {"month": "May", "value": 155.6},
          {"month": "June", "value": 10.5},
          {"month": "July", "value": 13.7},
          {"month": "August", "value": 41.5},
          {"month": "September", "value": -15.2},
          {"month": "October", "value": 0.3},
          {"month": "November", "value": -16.9},
          {"month": "December", "value": -51.9}
        ],
        "total": -3.78
      }
    },
    {
      "title": "Tech Inspection Total Income",
      "from-date": "2021-01-01",
      "to-date": "2022-12-31",
      "year-data": [
        {
          "year": "2021",
          "month-data:": [
            {"month": "May", "value": 1943290601},
            {"month": "June", "value": 2837751810},
            {"month": "July", "value": 2844008603},
            {"month": "August", "value": 2992812798},
            {"month": "September", "value": 3657134502},
            {"month": "October", "value": 3976481097},
            {"month": "November", "value": 5776827000},
            {"month": "December", "value": 5758995698}
          ],
          "total": 29787302109
        },
        {
          "year": "2022",
          "month-data:": [
            {"month": "May", "value": 3647041500},
            {"month": "June", "value": 3717347500},
            {"month": "July", "value": 3902427000},
            {"month": "August", "value": 5963530500},
            {"month": "September", "value": 1895364000},
            {"month": "October", "value": 4753989000},
            {"month": "November", "value": 4585345500},
            {"month": "December", "value": 3570832500}
          ],
          "total": 32035877500
        }
      ],
      "change-amount": {
        "month-data": [
          {"month": "May", "value": 1703750899},
          {"month": "June", "value": 879595690},
          {"month": "July", "value": 1058418397},
          {"month": "August", "value": 2970717702},
          {"month": "September", "value": -1761770502},
          {"month": "October", "value": 777507903},
          {"month": "November", "value": -1191481500},
          {"month": "December", "value": -2188163198}
        ],
        "total": 2248575391
      },
      "change-percent": {
        "month-data": [
          {"month": "May", "value": 87.67},
          {"month": "June", "value": 31.00},
          {"month": "July", "value": 37.22},
          {"month": "August", "value": 99.26},
          {"month": "September", "value": -48.17},
          {"month": "October", "value": 19.55},
          {"month": "November", "value": -20.63},
          {"month": "December", "value": -38.00}
        ],
        "total": 7.54
      }
    },
  ];

  static var jsonDataDeductionWithTrx = {
    "from-date": "2022-12-01",
    "to-date": "2023-01-01",
    "data": [
      {
        "date": "2022-11-01",
        "amount-obu-dollar": 44047.71,
        "amount-obu-total-percent": 0,
        "amount-anpr-dollar": 11243,
        "amount-anpr-total-percent": 0,
        "amount-digital-total-dollar": 55291.37,
        "amount-digital-total-percent": 0.02,
        "amount-iccard-dollar": 2432774.58,
        "amount-iccard-total-percent": 0.97,
        "amount-total": 2488065.95,
        "transaction-obu": 7602,
        "transaction-obu-total-percent": 0,
        "transaction-anpr": 1124,
        "transaction-anpr-total-percent": 0,
        "transaction-digital": 8846,
        "transaction-digital-total-percent": 0.02,
        "transaction-iccard": 315730,
        "transaction-iccard-total-percent": 0.97,
        "transaction-total": 324576
      },
      {
        "date": "2022-12-01",
        "amount-obu-dollar": 242153.59,
        "amount-obu-total-percent": 0,
        "amount-anpr-dollar": 103444.12,
        "amount-anpr-total-percent": 0,
        "amount-digital-total-dollar": 345597.71,
        "amount-digital-total-percent": 0.13,
        "amount-iccard-dollar": 2264323.3,
        "amount-iccard-total-percent": 0.86,
        "amount-total": 2609921.01,
        "transaction-obu": 42882,
        "transaction-obu-total-percent": 0,
        "transaction-anpr": 10398,
        "transaction-anpr-total-percent": 0,
        "transaction-digital": 53280,
        "transaction-digital-total-percent": 0.16,
        "transaction-iccard": 294465,
        "transaction-iccard-total-percent": 0.84,
        "transaction-total": 347745
      },
      {
        "date": "2023-01-01",
        "amount-obu-dollar": 419534.69,
        "amount-obu-total-percent": 0,
        "amount-anpr-dollar": 152542.82,
        "amount-anpr-total-percent": 0,
        "amount-digital-total-dollar": 572077.51,
        "amount-digital-total-percent": 0.18,
        "amount-iccard-dollar": 2448055.62,
        "amount-iccard-total-percent": 0.81,
        "amount-total": 3020133.13,
        "transaction-obu": 73170,
        "transaction-obu-total-percent": 0,
        "transaction-anpr": 6509,
        "transaction-anpr-total-percent": 0,
        "transaction-digital": 79679,
        "transaction-digital-total-percent": 0.20,
        "transaction-iccard": 312174,
        "transaction-iccard-total-percent": 0.79,
        "transaction-total": 391853
      },
    ],
    "average": {
      "amount-obu-dollar": 8293.68,
      "amount-obu-total-percent": 0.37,
      "amount-anpr-dollar": 3659.1,
      "amount-anpr-total-percent": 0.14,
      "amount-digital-total-dollar": 55291.37,
      "amount-digital-total-percent": 0.02,
      "amount-iccard-dollar": 44513.44,
      "amount-iccard-total-percent": 0.48,
      "amount-total": 56466.22,
      "transaction-obu": 1450,
      "transaction-obu-total-percent": 0.43,
      "transaction-anpr": 367,
      "transaction-anpr-total-percent": 0.1,
      "transaction-digital": 8846,
      "transaction-digital-total-percent": 0.02,
      "transaction-iccard": 5389,
      "transaction-iccard-total-percent": 0.46,
      "transaction-total": 7206,
      "traffic-total": 11201
    }
  };

  static PermissionGrant getPermissionByActivity(
      {required String activiyName, bool activityEn = false}) {
    late Permission? obj;
    if (activityEn == false)
      obj = Singleton.instance.token!.permission!
                  .where((f) => f.widgetKh == activiyName.trim())
                  .length >
              0
          ? Singleton.instance.token!.permission!
              .where((f) => f.widgetKh == activiyName.trim())
              .single
          : null;
    else {
      obj = Singleton.instance.token!.permission!
                  .where((f) => f.widgetEn == activiyName.trim())
                  .length >
              0
          ? Singleton.instance.token!.permission!
              .where((f) => f.widgetEn == activiyName.trim())
              .single
          : null;
    }
    if (obj != null) {
      bool get = obj.get == 1 ? true : false;
      bool insert = obj.update == 1 ? true : false;
      bool update = obj.update == 1 ? true : false;
      bool delete = obj.delete == 1 ? true : false;

      return PermissionGrant(
          GET: get, INSERT: insert, UPDATE: update, DELETE: delete);
    } else
      return PermissionGrant(
        GET: false,
        INSERT: false,
        UPDATE: false,
        DELETE: false,
      );
  }
}
