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
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Material(
        color: isActive ? AppColor.kPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 3,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    iconLocation,
                    colorFilter: ColorFilter.mode(
                      isActive
                          ? AppColor.kLightColor
                          : AppColor.kSecondaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isActive ? 1.0 : 0.0,
                  child: isActive
                      ? Text(
                          name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColor.kLightColor,
                                  ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
