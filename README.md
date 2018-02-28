# Tasksmanager

Welcome to Task tracking application:
********************HW07 ****************************************

The System will now have Managers and their Reportees.

Registration process:
While registering User should select their reporting manager. Assuming Manager account is already present in system.
The User must select if he/she is playing role of manager or not by selecting the dropdown available.

**********************************************************
Tasks Assignment:
Only user's manager can assign them a task. That task will show under Task report on Manager's dashboard.
The assigned task will be shown on underlings dashboard.
The underlings cannot reassign the task. they can only update the status and other fields.
The Manager can see:

Task report --> From their Homepage --> Your Underlings report
Underlings Details --> Homepage ---> View your profile ---> View Detailed Profile

*************************************************************
Time Blocks:
The Underlings can create multiple timeblocks for the tasks using Start/Stop working button. It will be on Pending tasks section.
The newly created timeblocks can be viewed from VIEW TASK button.
The Task can be edited using EDIT TASK button. And from there User can manually create new timeblock for that task.
The Timespent will be calculated once timeblock is stopped. And timespent can be seen after clicking VIEW TASK from homepage.

Updating Timeblocks:

Go to Homepage---> View Timeblocks --->
Then select populate start/stop timers and then click on "Update this" button near the timeblock which you want to update
the timeblock.

******************************************************************








**********************************HW:06********************************************
LOG IN SCREEN:

The homepage of application is the log in page.
  -> New user need to register and create account by clicking on register link
  -> Existing user can enter their email id to see their task feed

New User Register steps:
  -> New user needs to enter their email address and name to create an account

******************************************************************************
USER HOME PAGE:

The user homepage will be divided in two sections:
  ->  Pending Tasks
        Tasks with status as In-Progress, Not Started will appear in this section.
  ->  Completed Tasks
        Tasks with status as Completed(Mark completed) will appear in this section.

User will have the option to create new task from their homepage.

Task will have following fields:
* Title [mandatory during creation/update]
* Description [mandatory during creation/update]
* Status (Drop-down: In- Progress, Not Started, Completed)
* Time spent (Integer field. This field will take number multiple of 15)   
* User Assigned (Select user from drop-down to whom you have to assign the task) [mandatory during creation/update]. The drop down will have all users email id in the system. The email id is unique in the system. It means two users cannot register with same email address.

If user tries to enter value which is not multiple of 15 in Time spent field., system will give
validation error message.    

Users can view/show, edit, delete the tasks by clicking on required option from their homepage.
Users can view all system users from their homepage, but can delete only their own user and tasks.

***********************************************************************************************

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
