import { writable } from 'svelte/store';

export const page = writable("login");
export const loggedIn = writable("false")
export const permissions = writable("")
export const society = writable("PyBase")
export const views = writable("")
export const emailDetails = writable("")

let db_local = localStorage.getItem('pybase_db')
export const dbName = writable(db_local || 'hut')
dbName.subscribe((value) => localStorage.setItem('pybase_db', value))

export const dbN = writable("")  // the full name, ie art25..._test