# Toko Anggun

Website katalog jasa/produk dengan halaman beranda, katalog, detail item, dashboard admin, dan pemesanan WhatsApp menggunakan template khusus per item.

## Isi repository
- `index.html` — website publik, katalog, detail item, login admin, dan dashboard.
- `.github/workflows/pages.yml` — deployment otomatis ke GitHub Pages.
- `supabase/migrations/20261025_toko_anggun_deployment_readiness.sql` — schema dan kebijakan keamanan Supabase.
- `supabase/admin-bootstrap.sql` — SQL untuk mengizinkan akun admin pertama.

## Supabase
Project URL: https://gpkzvhngcccqksuhyoxw.supabase.co

Frontend menggunakan publishable key yang memang dirancang untuk browser. Jangan memasukkan service-role key atau kredensial admin ke frontend.

## Setup akun admin
1. Buka Supabase Dashboard → Authentication → Users.
2. Buat user menggunakan email yang kamu kuasai. Jangan mengaktifkan pendaftaran publik untuk membuat admin.
3. Buka SQL Editor lalu jalankan `supabase/admin-bootstrap.sql` setelah mengganti `GANTI_DENGAN_EMAIL_ADMIN` dengan email akun tersebut.
4. Masuk ke website pada route `#admin`.
5. Isi nomor WhatsApp bisnis yang benar di Pengaturan Website.
6. Tambahkan katalog pertama. Tiap item dapat memiliki template WhatsApp sendiri.

## Deploy
Workflow GitHub Actions menerbitkan `index.html` dari branch `main` ke GitHub Pages setiap kali ada push.

Saat repository bernama `tokoanggun`, project site biasanya ada di:
https://tokoanggun.github.io/tokoanggun/

Agar alamat menjadi persis https://tokoanggun.github.io/, repository harus bernama `tokoanggun.github.io` pada akun pemilik `tokoanggun` (profile/organization Pages site).

## Checklist setelah deploy
- Pastikan GitHub Pages workflow sukses.
- Setelah membuat akun admin, masukkan user ke `public.admin_users` melalui SQL bootstrap.
- Isi nomor WhatsApp bisnis.
- Uji login admin, tambah/edit/hapus item, upload foto, dan pesan WhatsApp dari halaman detail.
- Verifikasi URL redirect Supabase Auth sesuai alamat Pages yang akhirnya digunakan.

## Catatan
Katalog awal masih kosong hingga admin menambahkan produk atau jasa. Nomor WhatsApp asli belum diatur supaya nomor contoh tidak dipakai untuk menerima pesanan.
