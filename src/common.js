
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
