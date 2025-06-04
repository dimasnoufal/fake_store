import 'package:equatable/equatable.dart';

class OnboardingModel extends Equatable {
  final String? tittle;
  final String? subtitle;
  final String? imgPath;

  const OnboardingModel({
    this.tittle,
    this.subtitle,
    this.imgPath,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      tittle: json['tittle'] as String?,
      subtitle: json['subtitle'] as String?,
      imgPath: json['imgPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'tittle': tittle,
        'subtitle': subtitle,
        'imgPath': imgPath,
      };

  OnboardingModel copyWith({
    String? tittle,
    String? subtitle,
    String? imgPath,
  }) {
    return OnboardingModel(
      tittle: tittle ?? this.tittle,
      subtitle: subtitle ?? this.subtitle,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      tittle,
      subtitle,
      imgPath,
    ];
  }
}
