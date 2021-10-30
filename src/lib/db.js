import { createClient } from '@supabase/supabase-js'
import { readable } from 'svelte/store'

export const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_KEY
)