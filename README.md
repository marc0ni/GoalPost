# GoalPost -- Core Data and UI Extensions

A goal-setting app coded under instruction from the Udemy online course, <i>iOS 11 & Swift 4: From Beginning to Paid Professional</i>. The main focus of this project is Core Data. But it also includes three UI extensions which trigger transitioning (similar to Navigation Controller animation) by pressing keyboard-bound buttons. These extensions are:

<ul>
  <li>UIViewControllerExt -- includes these functions:</li>
  <ul style="list-style-type:disc">
  <li>presentDetail() -- Pushes the detail view of the current viewcontroller.</li><br>
  <li>presentSecondaryDetail() -- Unwinds the FinishGoalVC directly back to the GoalsVC</li><br>
  <li>dismissDetail() -- Unwinds the CreateGoalVC back to the GoalsVC</li></ul><br>

<li>UIButtonExt -- Indicates selected/deselected state of Goal Type buttons by change of color.</li><br>

<li>UIViewExt -- Binds a keyboard/keyboard to the NEXT or CREATE GOAL button. When the user has finished entering data, pressing either of those buttons saves Managed Object data to the Persisent Store, then activates the appropriate function on the UIViewControllerExt.</li>
</ul>
