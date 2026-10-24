-- Jalankan setelah membuat admin melalui Supabase Dashboard > Authentication > Users.
-- Ganti email placeholder dengan email persis dari akun admin yang kamu buat.
INSERT INTO public.admin_users (user_id)
SELECT id FROM auth.users
WHERE lower(email) = lower('GANTI_DENGAN_EMAIL_ADMIN')
ON CONFLICT (user_id) DO NOTHING;

SELECT au.user_id, u.email, au.created_at
FROM public.admin_users au
JOIN auth.users u ON u.id = au.user_id
WHERE lower(u.email) = lower('GANTI_DENGAN_EMAIL_ADMIN');
