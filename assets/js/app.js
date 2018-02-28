// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";

function update_buttons() {
  console.log("Inside update buttons")
  $('.timeblock-button').each( (_, bb) => {
    let task_id = $(bb).data('task-id');
    let timeblock = $(bb).data('timeblock');
    console.log(timeblock);
    console.log(task_id);
    if (timeblock != "") {
      $(bb).text("Stop Working");
    }
    else {
      $(bb).text("Start Working");
    }
  });
}

function set_button(task_id, value) {

  $('.timeblock-button').each( (_, bb) => {
    console.log(" button" + task_id + "bb id" + $(bb).data('task-id'))
    if (task_id == $(bb).data('task-id')) {
      console.log("updating button")
      $(bb).data('timeblock', value);
    }
  });
  update_buttons();
}

function starttimer(curr_task_id, curr_start_time) {
  console.log("Inside start")
  var d = new Date();
  let text = JSON.stringify({
    time_block: {
        starttime:curr_start_time,
      //starttime: "time",
      //endtime: "time",
        //endtime:0 ,
        task_id: curr_task_id
      },
  });

  console.log(text)

  $.ajax(time_block_path, {
    method: "POST",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(curr_task_id, resp.data.id);
      alert("Time Block started. Please check the task view page");},
  });

}

function stoptimer(curr_task_id, timeblock_id,curr_end_time) {

  let text = JSON.stringify({
    time_block: {
        endtime: curr_end_time,
        task_id: curr_task_id
      },
  });

  $.ajax(time_block_path + "/" + timeblock_id, {
    method: "PATCH",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: () => { set_button(curr_task_id, "");
    alert("Time Block stopped. Please check the task view page to check timespent");},
  });
}

function timeblock_click(ev) {
  console.log("Inside click")
  let btn = $(ev.target);
  let timeblock_id = btn.data('timeblock');
  let task_id = btn.data('task-id');
  let start_time = btn.data('starttime');
  let end_time = btn.data('endtime');

  console.log("timeblock id"+timeblock_id);
  console.log("task_id"+task_id);
  console.log("start_time"+start_time);
  console.log("end_time"+end_time);

  if (timeblock_id != "") {
    stoptimer(task_id, timeblock_id, end_time);
  }
  else {
    starttimer(task_id, start_time);
  }

}



function init_timeblock() {
  if (!$('.timeblock-button')) {
    return;
  }

  $(".timeblock-button").click(timeblock_click);

  update_buttons();
}

$(init_timeblock);

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
