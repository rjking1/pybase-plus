
// export async function doFetchGet(db, sql) {
//   let resp = await fetch(
//     'https://www.artspace7.com.au/dsql/json_helper_get.php?db=' +
//       db +
//       '&sql=' +
//       sql,
//   )
//   return await resp.json()
// }

export async function doFetch(db, sql, auditText) {
  let formData = new FormData()
  formData.append('db', db)
  formData.append('sql', encodeURI(sql))
  if (auditText) {
    formData.append('audit_text', auditText)
  }
  //formData.append('noenc', 'true') 

  let resp = await fetch(
    `https://www.artspace7.com.au/dsql/json_helper_post.php`,
    {
      method: 'POST',
      body: formData,
    },
  )
  let j = await resp.json()
  //console.log(j)
  return j
}


export function titleCase(s) {
  return s.toLowerCase()
    .replace('$', ' ')
    .replace(/^[-_]*(.)/, (_, c) => c.toUpperCase())       // Initial char (after -/_)
    .replace(/[-_]+(.)/g, (_, c) => ' ' + c.toUpperCase()) // First char after each -/_
}

export function viewDetail(views, viewName) {
  return views.find(view => view.name === viewName);
}

export function isAllowedTo(permissions, sFunc) {
  // eg if sFunc = 'staff.*' and have allCapabs exceptFor 'staff.*,patient.new' then result is false
  // at the moment ~.* is not expanded and matched -- must test exactly

  // console.log(permissions, sFunc)

  if (permissions.cap === 'D') {
    // console.log( !(permissions.ex.includes(sFunc)) )
    return !(permissions.ex.includes(sFunc))
  }

  if (permissions.cap === 'Y') {
    // all except those starting py_ unless py_ listed !  Others listed are not allowed
    return (!(permissions.ex.includes(sFunc)) && !(sFunc.startsWith('py_')))
      || (sFunc.startsWith('py_') && (permissions.ex.includes(sFunc)))
  }

  return (permissions.ex.includes(sFunc))
}

function setSqlParams(sql, params) {

}

export async function writeAuditText(db, user_id, user_name, auditText, k = '', v = '') {
  // todo: change to logging user_name one day
  await doFetch(db,
    "insert into py_logs (user_id, description, key_, value_) values ("
    + user_id + ",'" + auditText.replaceAll("'", "''") + "','" + k + "','" + v.replaceAll("'", "''") + "')"
    // don't add auditText as that is what we are inserting with no SQL
  )
}
