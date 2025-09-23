import 'package:flutter/material.dart';
import 'package:project_common_module/views/widgets/pin_theme.dart';

import '../../core/constants/app_colors.dart';

/// Custom keyboard
class CustomKeyBoard extends StatefulWidget {
  /// Theme for the widget. Read more [PinTheme]
  final PinTheme pinTheme;

  /// special key to be displayed on the widget. Default is '.'
  final Widget? specialKey;

  /// on changed function to be called when the amount is changed.
  final Function(String)? onChanged;

  /// on competed function to be called when the pin code is complete.
  final Function(String)? onCompleted;

  /// function to be called when special keys are pressed.
  final Function()? specialKeyOnTap;

  /// maximum length of the amount.
  final int maxLength;

  final Color? backgroundColor;

  const CustomKeyBoard({
    super.key,
    required this.maxLength,
    this.pinTheme = const PinTheme.defaults(),
    this.specialKey,
    this.onChanged,
    this.specialKeyOnTap,
    this.backgroundColor,
    this.onCompleted,
  }) : assert(maxLength > 0);
  @override
  _CustomKeyBoardState createState() => _CustomKeyBoardState();
}

class _CustomKeyBoardState extends State<CustomKeyBoard> {
  String value = "";
  Widget buildNumberButton({int? number, Widget? icon, Function()? onPressed}) {
    getChild() {
      if (icon != null) {
        return icon;
      } else {
        return Container(
          decoration: BoxDecoration(color: widget.backgroundColor ?? AppColors.primaryColor, borderRadius: BorderRadius.circular(15)),
          width: 107,
          height: 75,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            number?.toString() ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: widget.pinTheme.keysColor),
          ),
        );
      }
    }

    return Expanded(
      child: GestureDetector(
        // padding: EdgeInsets.zero,
        // pressedOpacity: 0.4,
        key: icon?.key ?? Key("btn$number"),
        onTap: onPressed,
        child: getChild(),
      ),
    );
  }

  Widget buildNumberRow(List<int> numbers) {
    List<Widget> buttonList =
        numbers
            .map(
              (buttonNumber) => buildNumberButton(
                number: buttonNumber,
                onPressed: () {
                  if (value.length < widget.maxLength) {
                    setState(() {
                      value = value + buttonNumber.toString();
                    });
                  }
                  widget.onChanged!(value);
                  if (value.length >= widget.maxLength && widget.onCompleted != null) {
                    widget.onCompleted!(value);
                  }
                },
              ),
            )
            .toList();
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.stretch, children: buttonList);
  }

  Widget buildSpecialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildNumberButton(
          icon: widget.specialKey ?? Icon(Icons.circle, key: const Key('specialKey'), color: widget.pinTheme.keysColor, size: 7),
          onPressed:
              widget.specialKeyOnTap ??
              () {
                if (value.isNotEmpty) {
                  setState(() {
                    value = "";
                  });
                }
                widget.onChanged!(value);
              },
        ),
        buildNumberButton(
          number: 0,
          onPressed: () {
            if (value.length < widget.maxLength) {
              setState(() {
                value = value + 0.toString();
              });
            }
            widget.onChanged!(value);
            if (value.length >= widget.maxLength && widget.onCompleted != null) {
              widget.onCompleted!(value);
            }
          },
        ),
        buildNumberButton(
          icon: Container(
            decoration: BoxDecoration(color: widget.backgroundColor ?? AppColors.primaryColor, borderRadius: BorderRadius.circular(15)),
            width: 107,
            height: 75,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            child: Icon(Icons.backspace, key: const Key('backspace'), color: widget.pinTheme.keysColor),
          ),
          onPressed: () {
            if (value.isNotEmpty) {
              setState(() {
                value = value.substring(0, value.length - 1);
              });
            }
            widget.onChanged!(value);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Spacer(),
          SizedBox(height: 75, child: buildNumberRow([1, 2, 3])),
          SizedBox(height: 75, child: buildNumberRow([4, 5, 6])),
          SizedBox(height: 75, child: buildNumberRow([7, 8, 9])),
          SizedBox(height: 75, child: buildSpecialRow()),
        ],
      ),
    );
  }
}
