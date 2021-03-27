import {permissions} from "./stores.js"

export async function doFetch(db, sql) {
  let resp = await fetch(
    'https://www.artspace7.com.au/dsql/json_helper_get.php?db=' +
      db +
      '&sql=' +
      sql,
  )
  return await resp.json()
}

export function titleCase(s) {
  return s.toLowerCase()
    .replace(/^[-_]*(.)/, (_, c) => c.toUpperCase())       // Initial char (after -/_)
    .replace(/[-_]+(.)/g, (_, c) => ' ' + c.toUpperCase()) // First char after each -/_
}

export function viewDetail(views, viewName) {
    return views.find(view => view.name === viewName);
}

export function isAllowedTo(sFunc) {
  // eg if sFunc = 'staff.*' and have allCapabs exceptFor 'staff.*,patient.new' then result is false
  // at the moment ~.* is not expanded and matched -- must test exactly
  if ($permissions.caps === 'D') {
    return !(sFunc in $permissions.ex)
  }

  if ($permissions.caps === 'Y') {
    // all except those starting py_ unless py_ listed !  Others listed are not allowed
    return !(sFunc in $permissions.ex) && !(sFunc.StartsText('py_'))
      || (sFunc.StartsText('py_') && (sFunc in $permissions.ex))
  }
  
  return (sFunc in $permissions.ex)
}
