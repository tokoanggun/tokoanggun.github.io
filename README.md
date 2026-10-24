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
4. Buka https://tokoanggun.github.io/ lalu klik **Admin** di header atau **Dashboard Admin** di footer.
5. Nomor WhatsApp utama sudah diatur ke **+62 856-4345-4205**. Nomor juga dapat diklik dari footer.
6. Tambahkan katalog pertama. Tiap item dapat memiliki template WhatsApp sendiri.

## Deploy
Workflow GitHub Actions menerbitkan `index.html` dari branch `main` ke GitHub Pages setiap kali ada push.

## Alamat website
Website utama diterbitkan ke:
https://tokoanggun.github.io/

Repository ini bernama `tokoanggun.github.io`, sehingga menggunakan GitHub Pages user site.

## Checklist setelah deploy
- Pastikan GitHub Pages workflow sukses.
- Setelah membuat akun admin, masukkan user ke `public.admin_users` melalui SQL bootstrap.
- Nomor WhatsApp sudah dikonfigurasi; uji pesan dari halaman utama dan detail produk.
- Uji login admin, tambah/edit/hapus item, upload foto, dan pesan WhatsApp dari halaman detail.
- Verifikasi URL redirect Supabase Auth sesuai alamat Pages yang akhirnya digunakan.

## Catatan
Katalog awal masih kosong hingga admin menambahkan produk atau jasa. Nomor WhatsApp bisnis sudah disimpan di Supabase. Supabase saat ini belum memiliki akun Auth/admin; buat akun pada Authentication → Users, lalu jalankan `supabase/admin-bootstrap.sql` dengan email akun tersebut agar dapat masuk ke dashboard.
