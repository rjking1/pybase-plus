<script>
  import { onMount } from "svelte";
  import { dbN, page, permissions, views, emailDetails } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
    writeAuditText,
  } from "../../common/dbutils.js";
  import FullCalendar from "svelte-fullcalendar";
  import dayGridPlugin from "@fullcalendar/daygrid";
  // import interactionPlugin from "@fullcalendar/interaction"; // needed for dateClick
  // there is a @fullcalendar/rrule plugin but i cannot make it work
  import { RRule } from "rrule";

  let eventDesc = "";
  let options = {
    editable: true,
    eventClick: handleEventClick,
    events: [],
    initialView: "dayGridMonth",
    plugins: [dayGridPlugin],
    headerToolbar: {
      left: "today",
      center: "title",
      right: "prev,next",
    },
    height: "600px", //'auto',
    weekends: true,
    eventMouseEnter: function (info) {
      eventDesc = info.event.extendedProps.description;
    },
    eventMouseLeave: function (info) {
      eventDesc = "";
      ("");
    },
  };

  // let calendarComponentRef;

  let p;
  let v;
  let fields = [];
  // let viewIsEditable = false;
  let viewName;
  // let entityName;
  let qresult = null;
  let aresult = null;

  // a lot of this should go into common as membersPage and CalendarPage have thee 3 functions in common
  onMount(async () => {
    p = pageDetails();
    viewName = p.viewName;
    v = viewDetail($views, viewName);
    // console.log(v);
    // todo fix to_view for events table
    // viewIsEditable =
    // !!v.to_view && isAllowedTo($permissions, viewName + "_edit"); // handle v.to_view being null (=undefined?) or '' (empty string)
    // entityName = titleCase(viewName) || "";
    doListEvents();
    // doGetActions();
  });

  async function doListEvents() {
    fields = JSON.parse(v.fields);
    if (fields === null) {
      fields = [];
    }
    fields.push({ fieldName: "id", visibility: false });
    console.log(fields);
    let sql = v.get_sql.replace("%d", p.id);
    qresult = await doFetch($dbN, sql);

    addToCalendar();
  }

  async function doGetActions() {
    aresult = await doFetch(
      $dbN,
      "select * from py_actions where view_id=" + v.id
    ); // optimization..load all actions at login time
  }

  function addToCalendar() {
    qresult.forEach((row) => {
      // console.log(row.from_date);
      let ev = {
        id: row.id,
        title: row.name,
        allDay: true,
        editable: false,
        color: row.colour,
        // extended prop
        description: row.description,
      };

      if (!row.rrule) {
        ev.start = row.from_date;
        ev.end = addDays(row.to_date, 1); // todo default to start_date + 1 if not in result row
        myAddEvent(ev);
      } else {
        // add repeating events
        let rule = RRule.fromText(row.rrule);
        // set seq start date -- tricky; as there seems to be no way to set DTSTART in the "English-like" text form
        let s = rule.toString();
        s = "DTSTART:" + row.from_date.replace(/\-/g, "") + "T000000Z\n" + s;
        // console.log(s);
        rule = RRule.fromString(s);
        rule.all().forEach((d, index) => {
          ev.start = d.toISOString().replace(/T.*/, "");
          ev.end = addDays(d, 1).toISOString().replace(/T.*/, "");
          myAddEvent({ ...ev });
        });
      }
    });
  }

  function myAddEvent(event) {
    const { events } = options;
    const calendarEvents = [...events, event];
    options = {
      ...options,
      events: calendarEvents,
    };
  }

  function addDays(date, days) {
    let result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
  }

  function handleSelect(event) {
    // alert(event.startStr + ':' + event.endStr);
    const { events } = options;
    const calendarEvents = [
      ...events,
      {
        title: "New Event",
        start: event.start,
        end: event.end,
        allDay: event.allDay,
      },
    ];
    options = {
      ...options,
      events: calendarEvents,
    };
  }

  function handleDateClick(event) {
    // if (confirm("Would you like to add an event ?")) {
    // }
    //   const { events } = options;
    //   const calendarEvents = [
    //     ...events,
    //     {
    //       title: "New Event",
    //       start: event.date,
    //       allDay: event.allDay,
    //     },
    //   ];
    //   options = {
    //     ...options,
    //     events: calendarEvents,
    //   };
    // }
  }

  function handleEventClick(info) {
    // see https://fullcalendar.io/docs/event-object
    // alert(info.event.id);
    $page = gotoPage("memberEdit", v.to_view, info.event.id, 0);
  }

  function addEvent() {
    $page = gotoPage("memberEdit", v.to_view, 0, 0);
  }
</script>

<button on:click={addEvent}>+ Add</button>
<FullCalendar {options} />
{#if eventDesc}
  <p>Description: {eventDesc}</p>
{/if}
