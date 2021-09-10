
export function roundedDateTimeToISO(dt) {
	if (!dt) {
		dt = new Date();
	}
	const ms = 1000 * 60 * 5;
	let roundedDate = new Date(
		Math.round((dt.getTime() + 1.5 * 60 * 1000) / ms) * ms // push slightly into the future in addition to rounding
	); 

	return roundedDate
		.toLocaleString("en-GB", { hour12: false })
		.slice(0, 17)
		.replace(",", "")
		.replace(/(\d+)\/(\d+)\/(\d+)/, "$3-$2-$1"); // eg "2021-09-10 12:00";
}
