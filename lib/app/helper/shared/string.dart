import 'package:fake_store/app/data/models/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String storeBaseUrl = 'https://fakestoreapi.com';

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

const String kTosContent = '''
Welcome to Store!

1. **Acceptance of Terms**  
   By accessing or using our application, you agree to be bound by these Terms.

2. **Account Responsibility**  
   You are responsible for maintaining the confidentiality of your login credentials.

3. **Prohibited Activities**  
   You may not use the app for any illegal or unauthorized purpose.

4. **Privacy**  
   We respect your privacy. Please review our Privacy Policy for details.

5. **Changes to Terms**  
   We may update these Terms at any time. Continued use constitutes acceptance.

If you have questions, contact us at support@example.com.
''';

const String kPrivacyPolicyContent = '''
Your privacy matters to us.

1. **Information We Collect**  
   We collect the personal data you provide (e.g., email, profile details) and anonymous usage statistics to improve our services.

2. **How We Use Information**  
   • To operate and maintain app functionality  
   • To personalize content and recommendations  
   • To communicate updates, offers, or critical notices  

3. **Data Sharing**  
   We do **not** sell your data. We may share it only with trusted service providers under confidentiality agreements or when required by law.

4. **Security**  
   We employ industry-standard safeguards to protect your information. However, no method of transmission or storage is 100 % secure.

5. **Your Choices & Rights**  
   You can review, update, or delete your personal information via account settings at any time. You may also opt out of non-essential communications.

6. **Children’s Privacy**  
   Our services are not directed to children under 13. We do not knowingly collect data from children. If you become aware of such data, please contact us.

7. **Changes to This Policy**  
   We may revise this Privacy Policy periodically. Continued use after updates means you accept the revised terms.

If you have questions or concerns, contact us at support@example.com.
''';

List<String> backgroundSpecial = [
  'https://www.shutterstock.com/image-photo/closeup-womans-hand-holding-cell-260nw-2192933767.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh-mUEXYUJ9RdlULH_DQ-LiSy4Q_E6bCTIlw&s',
  'https://img.freepik.com/premium-photo/sport-composition-with-modern-elements_23-2147914166.jpg',
];

List<String> tittleSpecial = [
  'Smartphone',
  'Fashion',
  'Sports & Fitness',
];

List<String> subtitleSpecial = [
  '10 Brands',
  '7 Brands',
  '5 Brands',
];

List<String> newProduct = [
  'https://pngimg.com/uploads/dress/dress_PNG65.png', // Dress :contentReference[oaicite:1]{index=1}
  'https://pngimg.com/uploads/suit/suit_PNG93219.png', // Suit :contentReference[oaicite:2]{index=2}
  'https://pngimg.com/uploads/dress/dress_PNG191.png', // Coat (generic) :contentReference[oaicite:3]{index=3}
  'https://pngimg.com/uploads/dress_shirt/dress_shirt_PNG8091.png', // Dress Shirt :contentReference[oaicite:4]{index=4}
  'https://pngimg.com/uploads/coat/coat_PNG80.png', // Sweater :contentReference[oaicite:5]{index=5}
];

List<String> tittleNewProduct = [
  'Elegant Dress',
  'Business Suit',
  'Wedding Dress',
  'Classic Dress Shirt',
  'Coat Sweater',
];

List<String> priceNewProduct = [
  '\$120',
  '\$220',
  '\$180',
  '\$90',
  '\$85',
];
