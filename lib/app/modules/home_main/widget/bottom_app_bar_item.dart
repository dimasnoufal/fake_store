import 'package:fake_store/app/helper/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomAppBarItem extends StatelessWidget {
  final String iconLocation;
  final String name;
  final bool isActive;
  final void Function() onTap;

  const BottomAppBarItem({
    super.key,
    required this.iconLocation,
    required this.name,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconLocation,
            colorFilter: ColorFilter.mode(
              isActive ? AppColor.kLightColor : AppColor.kSecondaryColor,
              BlendMode.srcIn,
            ),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isActive
                      ? AppColor.kLightColor
                      : AppColor.kSecondaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
