# Mini Katalog Uygulaması

Flutter temel eğitim haftası çıktısı olarak geliştirilmiş, yerel JSON veri simülasyonu ve dinamik sepet yönetimi içeren mobil katalog uygulaması.

## 🛠 Kullanılan Teknolojiler & Ortam
- **Flutter SDK:** 3.47.7 (Channel stable)
- **Dart SDK:** Entegre Dart SDK
- **Geliştirme Ortamı:** Visual Studio Code
- **Emülatör:** Android Studio Pixel Emulator (API 36)
- **Paketler:** Ekstra üçüncü taraf paket kullanılmamış, saf `material.dart` kullanılmıştır.

## 📱 Özellikler
- **Keşfet (Discover):** Kategori filtreleme, arama çubuğu ve `GridView` tabanlı dinamik ürün kartları.
- **Asset & JSON Yönetimi:** Ürün verileri yerel `assets/products.json` dosyasından asenkron olarak okunmaktadır.
- **Ürün Detay Sayfası:** `Navigator` ve route parametreleri ile seçilen ürünün detaylarının aktarımı.
- **Sepet Yönetimi (Cart):** Adet artırma/azaltma, toplam tutar hesaplama, boş sepet kontrolü ve sayaç rozeti (badge).


## 🚀 Projeyi Çalıştırma

```bash
git clone https://github.com/mestan4/mini_katalog_app.git
cd mini_katalog_app
flutter pub get
flutter run
```

## 📸 Uygulama Ekran Görüntüleri

| Ana Sayfa (Discover) | Ürün Detayı | Sepet (Cart) |
| :---: | :---: | :---: |
| <img src="screenshots/ana_gorunum.png" width="220" /> | <img src="screenshots/urun_detay.png" width="220" /> | <img src="screenshots/sepet_gorunumu.png" width="220" /> |