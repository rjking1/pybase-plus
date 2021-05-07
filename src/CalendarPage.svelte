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
  import interactionPlugin from "@fullcalendar/interaction"; // needed for dateClick

  let options = {
    dateClick: handleDateClick,
    droppable: true,
    editable: true,
    selectable: true,
    select: handleSelect,
    eventClick: handleEventClick,
    events: [
      // initial event data
      // { title: "New Event", start: new Date() },
    ],
    initialView: "dayGridMonth",
    plugins: [dayGridPlugin, interactionPlugin],
    headerToolbar: {
      left: "prev,next today",
      center: "title",
      right: "dayGridMonth",
    },
    height: "600px", //'auto',
    weekends: true,
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
    qresult.forEach(row => {
      let ev = { title: row.name, start: row.from_date, end: row.to_date, allDay: true, editable: true };
      myAddEvent(ev);
    });
  }

  function myAddEvent(event) {
    const { events } = options;
    const calendarEvents = [
      ...events,
      event
    ];
    options = {
      ...options,
      events: calendarEvents,
    };  
  }

  function handleSelect(event) {
    // alert(event.startStr + ':' + event.endStr);
    const { events } = options;
    const calendarEvents = [
      ...events,
      {
        title: "New Event 2",
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
    if (confirm("Would you like to add an event to " + event.dateStr + " ?")) {
      const { events } = options;
      const calendarEvents = [
        ...events,
        {
          title: "New Event",
          start: event.date,
          allDay: event.allDay,
        },
      ];
      options = {
        ...options,
        events: calendarEvents,
      };
    }
  }

  function handleEventClick(info) {
    // see https://fullcalendar.io/docs/event-object 
    alert(info.event.title);
  }
</script>

<div class="demo-app">
  <div class="demo-app-top">
    <!-- <button on:click={addEvent}>Add +</button> -->
  </div>

  <!-- <div>
    <Draggable {eventData} class="draggable">
      Drag me in Week or Day view!
    </Draggable>
  </div> -->

  <div class="demo-app-calendar">
    <FullCalendar bind:this={calendarComponentRef} {options} />
  </div>
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
