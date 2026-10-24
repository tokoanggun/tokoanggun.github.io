-- Adds the default WhatsApp template used by the redesigned public site and admin settings.
-- Safe to run repeatedly; preserves any already configured message and WhatsApp number.
ALTER TABLE public.settings
    ADD COLUMN IF NOT EXISTS default_wa_message text NOT NULL
    DEFAULT 'Halo Toko Anggun, saya ingin bertanya mengenai layanan/produk Anda.';

UPDATE public.settings
SET whatsapp_number = '6285643454205',
    default_wa_message = COALESCE(
        NULLIF(default_wa_message, ''),
        'Halo Toko Anggun, saya ingin bertanya mengenai layanan/produk Anda.'
    ),
    updated_at = now()
WHERE whatsapp_number IS DISTINCT FROM '6285643454205'
   OR default_wa_message IS NULL
   OR default_wa_message = '';
