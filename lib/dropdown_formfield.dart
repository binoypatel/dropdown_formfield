library dropdown_formfield;

import 'package:flutter/material.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final String iconField;
  final Function onChanged;
  final InputDecoration decoration;
  final TextStyle hintStyle;
  final TextStyle errorStyle;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.hintStyle,
      this.required = false,
      this.errorText = 'Please select one option',
      this.errorStyle,
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.iconField,
      this.onChanged,
      this.decoration})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: decoration ??
                        InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                          labelText: titleText,
                          filled: true,
                        ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        hint: Text(
                          hintText,
                          style: hintStyle ??
                              TextStyle(color: Colors.grey.shade500),
                        ),
                        value: value == '' ? null : value,
                        onChanged: (dynamic newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item[valueField],
                            child: (iconField != null && iconField.isNotEmpty
                                ? Row(
                                    children: <Widget>[
                                      item[iconField],
                                      const SizedBox(width: 5),
                                      Text(item[textField])
                                    ],
                                  )
                                : Text(item[textField])),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: errorStyle ??
                        TextStyle(
                            color: Colors.redAccent.shade700,
                            fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}
