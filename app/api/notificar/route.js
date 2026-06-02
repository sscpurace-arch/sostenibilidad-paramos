export async function POST(request) {
  const body = await request.json();
  const token = process.env.TELEGRAM_BOT_TOKEN;
  const chatId = process.env.TELEGRAM_CHAT_ID;

  if (!token || !chatId) {
    return Response.json({ ok: false, error: 'Sin configuración Telegram' }, { status: 500 });
  }

  const esPrueba = !!body.es_prueba;

  const lineas = [
    esPrueba ? '🧪 *CALIFICACIÓN DE PRUEBA*' : '📋 *Nueva calificación registrada*',
    `👤 *Productor:* ${body.productor}`,
    `📅 *Fecha:* ${body.fecha}`,
    `📊 *Puntaje global:* ${body.puntaje}`,
    `🗺️ *Sector:* ${body.sector || 'No especificado'}`,
    `👨‍💼 *Técnico:* ${body.tecnico || 'No especificado'}`,
  ];

  if (esPrueba) {
    lineas.push('_⚠️ Datos de prueba — no se guardan en el sistema real_');
  }

  const texto = lineas.join('\n');

  const res = await fetch(`https://api.telegram.org/bot${token}/sendMessage`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ chat_id: chatId, text: texto, parse_mode: 'Markdown' }),
  });

  const data = await res.json();
  return Response.json({ ok: data.ok });
}
