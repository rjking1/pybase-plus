import { writable } from 'svelte/store';

export const page = writable("login");
export const dbN = writable("")
export const loggedIn = writable("false")
