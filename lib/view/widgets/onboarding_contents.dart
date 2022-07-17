class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Cebinizdeki Yaşam Asistanınız",
    image: "asset/image/onboard1_image.png",
    desc: "Site yönetiminize dair tüm işlemler tek dokunuşla eliniizn altında.",
  ),
  OnboardingContents(
    title: "Avantajlar Sizi Bekliyor",
    image: "asset/image/onboard2_image.png",
    desc:
        "Apti’ye kayıt olduktan sonra site yönetiminizin onayıyla kullanmaya başlayabilir, Apti’nin ayrıcaklıklı dünyasıyla tanışabilirsiniz. ",
  ),
  OnboardingContents(
    title: "Pratik Online İşlemler",
    image: "asset/image/onboard3_image.png",
    desc:
        "Yapay zeka ile yaşam alanınızdaki her türlü işlemlerinizde pratik, hızlı ve akılcı çözümlerden yararlanın.",
  ),
  OnboardingContents(
    title: "İnteraktif Site Yaşamı",
    image: "asset/image/onboard4_image.png",
    desc:
        "Kolay erişim, zaman tasarrufu, şeffaf yönetim anlayışı ve katılımcı bir site yaşamı Apti’de sizleri bekliyor.",
  ),
];
