// Segundo ping para mantener activo el proyecto de Supabase, independiente de
// GitHub Actions (ver .github/workflows/keep_alive.yml). Lo llama el cron de
// Vercel (vercel.json) una vez al día. Escribe en la tabla dedicada
// keep_alive_ping y lee una tabla real. No expone ningún dato.
export const dynamic = 'force-dynamic';

export async function GET(request) {
  // Si CRON_SECRET está configurada en Vercel, solo el cron de Vercel entra
  const secreto = process.env.CRON_SECRET;
  if (secreto && request.headers.get('authorization') !== `Bearer ${secreto}`) {
    return Response.json({ ok: false, error: 'No autorizado' }, { status: 401 });
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const llave = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !llave) {
    return Response.json({ ok: false, error: 'Sin configuración de Supabase' }, { status: 500 });
  }
  const cabeceras = { apikey: llave, Authorization: `Bearer ${llave}` };

  try {
    const escritura = await fetch(`${url}/rest/v1/keep_alive_ping`, {
      method: 'POST',
      headers: { ...cabeceras, 'Content-Type': 'application/json', Prefer: 'resolution=merge-duplicates,return=minimal' },
      body: JSON.stringify({ id: 1, pinged_at: new Date().toISOString() }),
    });
    const lectura = await fetch(`${url}/rest/v1/indicadores?select=id&limit=5`, { headers: cabeceras });
    const ok = escritura.ok && lectura.ok;
    return Response.json({ ok, escritura: escritura.status, lectura: lectura.status }, { status: ok ? 200 : 502 });
  } catch (e) {
    return Response.json({ ok: false, error: 'Supabase no responde' }, { status: 502 });
  }
}
