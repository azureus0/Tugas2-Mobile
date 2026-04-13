const fs = require('fs');
const path = require('path');
const BD = require('../.codex_tmp/balinese-date-js-lib/node/BalineseDate');

const startYear = 1900;
const endYear = 2100;
const outputPath = path.join(__dirname, '..', 'assets', 'data', 'balinese_lookup.json');

function pad(value) {
  return String(value).padStart(2, '0');
}

const data = {};

for (let year = startYear; year <= endYear; year += 1) {
  for (let month = 0; month < 12; month += 1) {
    const maxDay = new Date(year, month + 1, 0).getDate();
    for (let day = 1; day <= maxDay; day += 1) {
      const date = new Date(year, month, day);
      const balineseDate = new BD.BalineseDate(date);
      const key = `${year}-${pad(month + 1)}-${pad(day)}`;
      data[key] = {
        saka: balineseDate.saka,
        sasih: balineseDate.sasih.name,
        sasihDayInfo: balineseDate.sasihDayInfo.name,
        sasihDay: balineseDate.sasihDay.join('/'),
        saptaWara: balineseDate.saptaWara.name,
        pancaWara: balineseDate.pancaWara.name,
        wuku: balineseDate.wuku.name,
      };
    }
  }
}

fs.mkdirSync(path.dirname(outputPath), { recursive: true });
fs.writeFileSync(outputPath, JSON.stringify(data));

console.log(`Generated ${Object.keys(data).length} Balinese dates to ${outputPath}`);
