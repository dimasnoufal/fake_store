import 'package:fake_store/app/data/models/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String StorebaseUrl = 'https://fakestoreapi.com';

List<OnboardingModel> items(BuildContext context) {
  final strings = AppLocalizations.of(context)!;

  return [
    OnboardingModel(
      imgPath: 'assets/images/ilustration_1.png',
      tittle: strings.tittleOnboarding1,
      subtitle: strings.subTittleOnboarding1,
    ),
    OnboardingModel(
      imgPath: 'assets/images/ilustration_2.png',
      tittle: strings.tittleOnboarding2,
      subtitle: strings.subTittleOnboarding2,
    ),
    OnboardingModel(
      imgPath: 'assets/images/ilustration_3.png',
      tittle: strings.tittleOnboarding3,
      subtitle: strings.subTittleOnboarding3,
    )
  ];
}
