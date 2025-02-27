import 'package:flutter/material.dart' hide CheckboxListTile;
import 'package:flutter/material.dart' as prefix0;
import 'package:photo/src/entity/options.dart';
import 'package:photo/src/provider/i18n_provider.dart';
import 'package:photo/src/ui/widget/check_tile_copy.dart';

abstract class CheckBoxBuilderDelegate {
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  );
}

class DefaultCheckBoxBuilderDelegate extends CheckBoxBuilderDelegate {
  Color activeColor;
  Color unselectedColor;
  Color checkColor;

  DefaultCheckBoxBuilderDelegate({
    this.activeColor = Colors.white,
    this.unselectedColor = Colors.white,
    this.checkColor = Colors.black,
  });

  @override
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: unselectedColor),
      child: CheckboxListTile(
        value: checked,
        onChanged: (bool check) {},
        activeColor: activeColor,
        checkColor: checkColor,
        title: Text(
          i18nProvider.getSelectedOptionsText(options),
          textAlign: TextAlign.end,
          style: TextStyle(color: options.textColor),
        ),
      ),
    );
  }
}

class RadioCheckBoxBuilderDelegate extends CheckBoxBuilderDelegate {
  Color activeColor;
  Color unselectedColor;

  RadioCheckBoxBuilderDelegate({
    this.activeColor = Colors.white,
    this.unselectedColor = Colors.white,
  });

  @override
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: unselectedColor),
      child: RadioListTile<bool>(
        value: true,
        onChanged: (bool check) {},
        activeColor: activeColor,
        title: Text(
          i18nProvider.getSelectedOptionsText(options),
          textAlign: TextAlign.end,
          style: TextStyle(color: options.textColor, fontSize: 14.0),
        ),
        groupValue: checked,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}

class IconBoxBuilderDelegate extends CheckBoxBuilderDelegate {
  Widget active;
  Widget unselected;

  IconBoxBuilderDelegate({this.active, this.unselected});

  @override
  Widget buildCheckBox(
    BuildContext context,
    bool checked,
    int index,
    Options options,
    I18nProvider i18nProvider,
  ) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 15,
        ),
        Text(
          i18nProvider.getSelectedOptionsText(options),
          style: TextStyle(color: options.textColor, fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: checked ? active : unselected,
        ),
      ],
    );
  }
}
