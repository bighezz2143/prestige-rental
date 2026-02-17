-- Script per aggiungere la colonna images alla tabella cars
-- Esegui questo script nel SQL Editor di Supabase

-- Aggiungi la colonna images (array JSON) alla tabella cars
ALTER TABLE cars
ADD COLUMN IF NOT EXISTS images JSONB DEFAULT '[]'::jsonb;

-- Aggiorna le righe esistenti che hanno image_url per popolare images
UPDATE cars
SET images = jsonb_build_array(image_url)
WHERE image_url IS NOT NULL AND (images IS NULL OR images = '[]'::jsonb);

-- Verifica che la colonna sia stata aggiunta correttamente
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'cars' AND column_name = 'images';
