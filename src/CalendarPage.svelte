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
  } from "./Common.js";
  import FullCalendar, { Draggable } from "svelte-fullcalendar";
  import dayGridPlugin from "@fullcalendar/daygrid";
  import interactionPlugin from "@fullcalendar/interaction"; // needed for dateClick ??
  import { RRule } from "rrule";

  let eventDesc = "";
  let options = {
    // droppable: true,
    editable: true,
    // selectable: true,
    // dateClick: handleDateClick,
    // select: handleSelect,
    eventClick: handleEventClick,
    events: [],
    initialView: "dayGridMonth",
    plugins: [dayGridPlugin, interactionPlugin],
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
    // var tooltip = new Tooltip(info.el, {
    //   title: info.event.extendedProps.description,
    //   placement: 'top',
    //   trigger: 'hover',
    //   container: 'body'
    // });
  };

  let calendarComponentRef;

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  let entityName;
  let qresult = null;
  let aresult = null;

  // a lot of this should go into common as membersPage and CalendarPage have thee 3 functions in common
  onMount(async () => {
    p = pageDetails();
    viewName = p.viewName;
    v = viewDetail($views, viewName);
    // todo fix to_view for events table
    viewIsEditable =
      !!v.to_view && isAllowedTo($permissions, viewName + "_edit"); // handle v.to_view being null (=undefined?) or '' (empty string)
    entityName = titleCase(viewName) || "";
    doListMembers();
    // doGetActions();
  });

  async function doListMembers() {
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
        start: row.from_date,
        end: addDays(row.to_date, 1), // todo default to start_date + 1 if not in result row
        allDay: true,
        editable: false,
        color: row.colour,
        // extended prop
        description: row.description,
      };

      if (!row.rrule) {
        myAddEvent(ev);
      } else {
        // add repeating events
        let rule = RRule.fromText(row.rrule);
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
<div class="xdemo-app">
  <!-- <div class="demo-app-top">
  </div> -->

  <!-- <div>
    <Draggable {eventData} class="draggable">
      Drag me in Week or Day view!
    </Draggable>
  </div> -->

  <div class="xdemo-app-calendar">
    <FullCalendar bind:this={calendarComponentRef} {options} />
  </div>
  {#if eventDesc}
    <p>Description: {eventDesc}</p>
  {/if}
</div>

<style>
  .demo-app {
    width: 100vw;
    height: 100vh;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  .demo-app-top {
    margin: 0 0 3em;
  }

  .demo-app-calendar {
    margin: 0 auto;
    max-width: 1000px;
  }

  /* :global(.draggable) {
    color: white;
    background: #3788d8;
    width: fit-content;
    padding: 1rem;
    margin: 1rem;
    cursor: pointer;
  } */
</style>
