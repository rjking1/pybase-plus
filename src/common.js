
export async function doFetch(db, sql) {
  let resp = await fetch(
    'https://www.artspace7.com.au/dsql/json_helper_get.php?db=' +
      db +
      '&sql=' +
      sql,
  )
  return await resp.json()
}

export function isAllowedTo(what, permissions) {
  // to do
  // check!!
  return true
}

export function titleCase(s) {
  return s.toLowerCase()
    .replace(/^[-_]*(.)/, (_, c) => c.toUpperCase())       // Initial char (after -/_)
    .replace(/[-_]+(.)/g, (_, c) => ' ' + c.toUpperCase()) // First char after each -/_
}

export function viewDetail(views, viewName) {
    return views.find(view => view.name === viewName);
}
