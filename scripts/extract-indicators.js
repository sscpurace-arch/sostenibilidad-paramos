const xlsx = require('xlsx');

try {
  const workbook = xlsx.readFile('data_import/Calificacion indicadores sotará.xlsx');
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const data = xlsx.utils.sheet_to_json(sheet);
  
  const indicators = {};
  data.forEach(row => {
    const label = row['CARACTERIZACION'];
    if (!label) return;
    const match = label.match(/^(\d+)\.\s*(.*)/);
    if (match) {
      const id = parseInt(match[1]);
      const name = match[2].trim();
      indicators[id] = name;
    }
  });

  console.log('Indicadores encontrados:', Object.keys(indicators).length);
  console.log(JSON.stringify(indicators, null, 2));
} catch (e) {
  console.error(e);
}
