# UTS PEMROGRAMAN MOBILE 2

1. Jelaskan bagaimana state management dengan Cubit dapat membantu dalam pengelolaan transaksi yang memiliki logika diskon dinamis
Jawab:
Cubit membantu karena semua perubahan pesanan—nambah menu, ngurangin, atau ngitung diskon—dipusatkan di satu tempat.
Misalnya Ayam Geprek ada diskon 10% dan Jus Mangga 5%, Cubit langsung ngitung harga akhirnya dan ngasih state baru ke UI. Jadi tampilan total harga selalu ikut berubah tanpa hitung manual di tiap widget. Intinya: logika diskon tetap rapi, gampang diubah, dan UI otomatis update

2. Apa perbedaan antara diskon per item dan diskon total transaksi? Berikan contoh penerapannya dalam aplikasi kasir.
Jawab:
Diskon per item → Berlaku pada menu tertentu.
Contoh:
- Ayam Geprek diskon 10%
- Jus Mangga diskon 5%
Diskon dihitung per menu, satu-satu.
Diskon total transaksi → Berlaku kalau total belanja mencapai syarat tertentu.

Dan untuk Poin C (bonus)
Jika total lebih dari Rp100.000 → diskon 10% untuk seluruh transaksi.
Bedanya: item discount kena ke produk tertentu, sedangkan total discount ngurangin harga seluruh belanja

3.  Jelaskan manfaat penggunaan widget Stack pada tampilan kategori menu di aplikasi Flutter.
Jawab:
Stack bikin tampilan kategori lebih fleksibel. Jadi bisa taruh background dan chip kategori bertumpuk sehingga kelihatan lebih menarik, tidak monoton. Cocok untuk menu seperti "Makanan", "Minuman", dan "Snack" yang ingin ditonjolkan di bagian atas. Dengan Stack, kategori kelihatan lebih rapi dan mudah ditekan pengguna

## SCREENSHOTS
!image[alt](https://github.com/Adchrisa/UTS-pemrograman-mobile2/blob/d5bf77bbe2487548c26354be6dd6e977a871f8a8/screenshot%20uts.PNG)

!image[alt](https://github.com/Adchrisa/UTS-pemrograman-mobile2/blob/d5bf77bbe2487548c26354be6dd6e977a871f8a8/screenshot%20ringkasan.PNG)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
