import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart' as format;
import 'package:stm_report_app/Enum/ValueDataTypeEnum.dart';

final dollarFormat = new format.NumberFormat("#,##0.00", "en_US");
final numberFormat = new format.NumberFormat("#,###", "en_US");
final numberDoubleFormat = new format.NumberFormat("#,##0", "en_US");
final percentFormat = new format.NumberFormat.percentPattern('en');
final khmerFormat = new format.NumberFormat("###,### ####", "en_US");

var engKhMonth = [
  {
    "en": "January",
    "kh": "មករា",
  },
  {
    "en": "February",
    "kh": "កុម្ភៈ",
  },
  {
    "en": "March",
    "kh": "មិនា",
  },
  {
    "en": "April",
    "kh": "មេសា",
  },
  {
    "en": "May",
    "kh": "ឧសភា",
  },
  {
    "en": "June",
    "kh": "មិថុនា",
  },
  {
    "en": "July",
    "kh": "កក្កដា",
  },
  {
    "en": "August",
    "kh": "សីហា",
  },
  {
    "en": "September",
    "kh": "កញ្ញា",
  },
  {
    "en": "October",
    "kh": "តុលា",
  },
  {
    "en": "November",
    "kh": "វិច្ឆិកា",
  },
  {
    "en": "December",
    "kh": "ធ្នូ",
  },
];

extension numberParsing on double {
  String toDollarCurrency() {
    return "\$ " + dollarFormat.format(this);
  }

  String toKhmerCurrency() {
    return "\៛ " + khmerFormat.format(this);
  }

  String toPercentFormat() {
    return percentFormat.format(this);
  }

  String toNumberDoubleFormat() {
    return numberDoubleFormat.format(this);
  }
}

extension numberQtyParsing on int {
  String toNumberFormat() {
    return numberFormat.format(this);
  }
}

extension getMonth on String {
  int getMonthNo() {
    for (int i = 0; i < engKhMonth.length; i++) {
      if (engKhMonth[i].containsValue(this)) {
        print("-------");
        print(this);
        print(i + 1);
        print("-------");
        return (i + 1);
      }
    }
    return 0;
  }
}

extension dateParsing on String {
  DateTime getDateByMonth() {
    return DateTime.parse(
        "0000-${this.getMonthNo().toString().padLeft(2, '0')}-01");
  }

  String getKhmerMonth() {
    for (int i = 0; i < engKhMonth.length; i++) {
      if (engKhMonth[i].containsValue(this)) {
        return engKhMonth[i].values.toList()[1].toString();
      }
    }
    return "";
  }

  String toDateDMY() {
    return format.DateFormat('dd/MM/yyyy').format(
      DateTime.parse(this),
    );
  }

  String toDateStandardMPWT() {
    return format.DateFormat('yyyy-MM-dd HH:mm:ss').format(
      DateTime.parse(this),
    );
  }

  String toDateYYYYMMDD() {
    return format.DateFormat('yyyy-MM-dd').format(
      DateTime.parse(this),
    );
  }

  String toDateYYYYMMDD_NoDash() {
    return format.DateFormat('yyyyMMdd').format(
      DateTime.parse(this),
    );
  }

  String toDateYYYYMM() {
    return format.DateFormat('yyyy-MM').format(
      DateTime.parse(this),
    );
  }

  String toDateYYYY() {
    return format.DateFormat('yyyy').format(
      DateTime.parse(this),
    );
  }

  VALUE_DATA_TYPE getDataType() {
    try {
      var isDate = DateTime.parse(this);
      // var isDate = new DateFormat('dd/MM/yy').parse(this);
      // ignore: unnecessary_null_comparison
      if (isDate != null)
        return VALUE_DATA_TYPE.DATE_TIME;
      else if (double.tryParse(this) != null)
        return VALUE_DATA_TYPE.NUMERIC;
      else if (this.contains("%"))
        return VALUE_DATA_TYPE.PERCENT;
      else
        return VALUE_DATA_TYPE.STRING;
    } catch (err) {
      if (double.tryParse(this) != null)
        return VALUE_DATA_TYPE.NUMERIC;
      else if (this.contains("%"))
        return VALUE_DATA_TYPE.PERCENT;
      else
        return VALUE_DATA_TYPE.STRING;
    }
  }
}

extension dateCustomFormat on DateTime {
  String toYYYYMMDD() {
    return format.DateFormat('yyyy-MM-dd').format(this);
  }

  String toYYYYMMDD_NoDash() {
    return format.DateFormat('yyyyMMdd').format(this);
  }

  String toDateKhmerMonthYear() {
    return DateFormat('MMMM', "km").format(this) +
        " " +
        DateFormat('yyyy').format(this);
  }

  String toYear() {
    return DateFormat('yyyy').format(this);
  }
}
