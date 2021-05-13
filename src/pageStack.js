
let stack = []

export function gotoPage(pg, viewName, id, fk) {
  // eg gotoPage('list', 'All members', 0) 
  // eg gotoPage('record', 'member', 1234) 
  stack.push({ page: pg, viewName: viewName, id: id, fk: fk })
  return pg
}

export function updateId(id) {
  stack[stack.length - 1].id = id
}

export function canGoBack() {
  return stack.length > 1
}

export function goBack() {
  stack.pop()
  return stack[stack.length - 1].page
}

export function pageDetails() {
  return stack[stack.length - 1]
}

export function clearPageHistory() {
  stack.length = 0;
}