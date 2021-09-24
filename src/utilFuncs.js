import DataFrame from "dataframe-js";

export function roundedDateTimeToISO(dt) {
  if (!dt) {
    dt = new Date();
    console.log(dt);
  }
  const ms = 1000 * 60 * 5;
  let roundedDate = new Date(
    Math.round((dt.getTime() + 1.5 * 60 * 1000) / ms) * ms // push slightly into the future in addition to rounding
  );

  return abbreviateDate(roundedDate);
}

export function abbreviateDate(roundedDate) {
  return roundedDate
    .toLocaleString("en-GB", { hour12: false })
    .slice(0, 17)
    .replace(",", "")
    .replace(/(\d+)\/(\d+)\/(\d+)/, "$3-$2-$1"); // eg "2021-09-10 12:00";
}

export function pivotTable(dataframe, values = [], index = [], columns = []) {
  if (values.length > 1) {
    throw 'Not implemented';
  }
  const value = values[0];
  const hasSelectedIndex = index && index.length;
  const hasSelectedColumns = columns && columns.length;

  let agg = new Map();
  const aggKeys = index.concat(columns).filter((x) => x);
  const groupedDF = dataframe['groupBy'](...aggKeys);
  let rowKey = value;
  let colKey = value;
  groupedDF.aggregate(group => {
    const row = group.getRow(0);
    if (hasSelectedIndex) {
      rowKey = row.select(...index).toArray().join('_');
    }
    const baseAttrs = Object.fromEntries(index.map((i) => [i, row.get(i)]));
    agg.set(rowKey, agg.get(rowKey) || baseAttrs);
    if (hasSelectedColumns) {
      colKey = row.select(...columns).toArray().join('_');
    }
    agg.get(rowKey)[colKey] = group.stat.sum(value);
  })
  return new DataFrame(Array.from(agg.values()));
}
