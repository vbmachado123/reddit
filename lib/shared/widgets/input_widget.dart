import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reddit/core/app_text_styles.dart';
import 'package:reddit/core/core.dart';

/**
 * @author Victor Balbino
 * @date 17/12/2022
 * @description Widget Criado para Ser o Input Padrão para toda a aplicação
 */
class InputWidget extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final String maskType;
  final TextEditingController controller;
  final String mask;
  final IconButton? icon;
  final String? preffix;

  // const InputWidget(
  //     {Key key,
  //     this.label,
  //     this.keyboardType,
  //     this.hint,
  //     this.obscureText = false, this.maskType})
  //     : super(key: key);

  InputWidget.text(
      {required String label, required String hint, required this.controller})
      : this.label = label,
        this.keyboardType = TextInputType.name,
        this.obscureText = false,
        this.maskType = "",
        this.mask = "",
        this.hint = hint,
        this.icon = null,
        this.preffix = null;

  InputWidget.email(
      {required String label, required String hint, required this.controller})
      : this.label = label,
        this.keyboardType = TextInputType.emailAddress,
        this.obscureText = false,
        this.maskType = "",
        this.mask = "",
        this.hint = hint,
        this.icon = null,
        this.preffix = null;

  InputWidget.password({required String label, required this.controller})
      : this.label = label,
        this.keyboardType = TextInputType.visiblePassword,
        this.obscureText = true,
        this.maskType = "",
        this.mask = "",
        this.hint = "**********",
        this.icon = null,
        this.preffix = null;

  InputWidget.number(
      {required String label, required String hint, required this.controller})
      : this.label = label,
        this.keyboardType = TextInputType.number,
        this.obscureText = false,
        this.maskType = label,
        this.mask = "",
        this.hint = hint,
        this.icon = null,
        this.preffix = null;

  InputWidget.mask(
      {required String label,
      required String hint,
      required this.controller,
      required this.mask})
      : this.label = label,
        this.keyboardType = TextInputType.number,
        this.obscureText = false,
        this.maskType = "PERSONALIZADO",
        this.hint = hint,
        this.icon = null,
        this.preffix = null;

  InputWidget.icon({
    required String label,
    required String hint,
    required this.controller,
    required this.icon,
  })  : this.label = label,
        this.keyboardType = TextInputType.name,
        this.obscureText = false,
        this.maskType = "",
        this.mask = "",
        this.hint = hint,
        this.preffix = null;

  InputWidget.iconWithPreffix(
      {required String label,
      required String hint,
      required this.controller,
      required this.icon,
      required this.preffix})
      : this.label = label,
        this.keyboardType = TextInputType.name,
        this.obscureText = false,
        this.maskType = "",
        this.mask = "",
        this.hint = hint;

  @override
  Widget build(BuildContext context) {
    var maskFormatter;
    switch (maskType) {
      case "CPF":
        maskFormatter = new MaskTextInputFormatter(
            mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
        break;
      case "RG":
        maskFormatter = new MaskTextInputFormatter(
            mask: '##.###.###', filter: {"#": RegExp(r'[0-9]')});
        break;
      case "CNPJ":
        maskFormatter = new MaskTextInputFormatter(
            mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
        break;
      case "IE":
        maskFormatter = new MaskTextInputFormatter(
            mask: '###.###.###.###', filter: {"#": RegExp(r'[0-9]')});
        break;
      case "Telefone":
        maskFormatter = new MaskTextInputFormatter(
            mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
        break;
      case "Celular":
        maskFormatter = new MaskTextInputFormatter(
            mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
        break;
      case "PERSONALIZADO":
        maskFormatter = new MaskTextInputFormatter(
            mask: '${mask}', filter: {"#": RegExp(r'[0-9]')});
        break;
      default:
        maskFormatter =
            new MaskTextInputFormatter(mask: '', filter: {"": RegExp('')});
        break;
    }

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: AppTextStyles.h8_regular,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              // AppShadows.shadow0,
            ],
          ),
          child: TextField(
            controller: controller,
            inputFormatters: (maskFormatter != "") ? [maskFormatter] : null,
            obscureText: this.obscureText,
            keyboardType: this.keyboardType,
            style: AppTextStyles.p_regular,
            decoration: InputDecoration(
              suffixIcon: icon != null ? icon : null,
              prefixStyle: AppTextStyles.p_bold,
              prefixText: preffix,
              // fillColor: AppColors.white,
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(4),
                ),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              hoverColor: AppColors.primary_0,
              focusColor: AppColors.primary_0,
              hintText: this.hint,
              // labelText: this.label,
              // labelStyle: AppTextStyles.h6_regular,
              fillColor: AppColors.white,
              filled: false,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              alignLabelWithHint: false,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
