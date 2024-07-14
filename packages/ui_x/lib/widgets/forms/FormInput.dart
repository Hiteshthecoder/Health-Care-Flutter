import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Icon? leading;
  final bool isPassword;
  final TextInputType type;
  final int rows;
  final TextInputAction action;
  final bool? autoFocus;
  final bool onlyRead;
  final int? maxLength;
  final inputFormatters;

  const FormInput({
    Key? key,
    this.controller,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
    this.inputFormatters,
  })  : type = TextInputType.text,
        isPassword = false,
        super(key: key);

  const FormInput.text({
    Key? key,
    this.controller,
    this.placeholder = "Input hint",
    this.validator,
    this.labelText,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
    this.inputFormatters,
  })  : type = TextInputType.text,
        isPassword = false,
        super(key: key);

  const FormInput.password({
    Key? key,
    this.controller,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.inputFormatters,
    this.action = TextInputAction.next,
  })  : type = TextInputType.text,
        isPassword = true,
        super(key: key);

  const FormInput.number({
    Key? key,
    this.controller,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
    this.inputFormatters,
    this.type = TextInputType.number,
  })  : isPassword = false,
        super(key: key);

  const FormInput.email({
    Key? key,
    this.controller,
    this.inputFormatters,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
  })  : type = TextInputType.emailAddress,
        isPassword = false,
        super(key: key);

  const FormInput.datetime({
    Key? key,
    this.controller,
    this.inputFormatters,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.onlyRead = false,
    this.autoFocus,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
  })  : type = TextInputType.datetime,
        isPassword = false,
        super(key: key);

  const FormInput.url({
    Key? key,
    this.controller,
    this.inputFormatters,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 1,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
  })  : type = TextInputType.url,
        isPassword = false,
        super(key: key);

  const FormInput.multiline({
    Key? key,
    this.inputFormatters,
    this.controller,
    this.placeholder = "Input hint",
    this.labelText,
    this.validator,
    this.leading,
    this.autoFocus,
    this.onlyRead = false,
    this.rows = 4,
    this.onSaved,
    this.maxLength,
    this.action = TextInputAction.next,
  })  : type = TextInputType.multiline,
        isPassword = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: type,
      minLines: type == TextInputType.multiline ? rows : 1,
      maxLines: type == TextInputType.multiline ? null : 1,
      decoration: InputDecoration(
        counterText: '',
        hintText: placeholder,
        labelText: labelText,
        prefixIcon: leading,
      ),
      autofocus: autoFocus ?? false,
      readOnly: onlyRead,
      obscureText: isPassword,
      validator: validator,
      onSaved: onSaved,
      textInputAction: action,
      maxLength: maxLength,
    );
  }
}
