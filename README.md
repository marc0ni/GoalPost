# GoalPost -- Core Data and UI Extensions

A goal-setting app coded under instruction from the Udemy online course, <i>iOS 11 & Swift 4: From Beginning to Paid Professional</i>. The main focus of this project is Core Data. But it also includes three UI extensions which are built to bring Navigation Controller transitioning triggered by keyboard-bound buttons. These extensions are:

1. UIViewControllerExt -- includes these functions:
  a. presentDetail() -- Pushes the detail view of the current viewcontroller.
  b. presentSecondaryDetail() -- Unwinds the FinishGoalVC directly back to the GoalsVC
  c. dismissDetail() -- Unwinds the CreateGoalVC back to the GoalsVC

2. UIButtonExt -- Indicates selected/deselected state of buttons by change of color

3. UIViewExt -- Binds a keyboard/keyboard to the NEXT or CREATE GOAL button. When the user has finished entering data, pressing either of those buttons activates the appropriate function on UIViewControllerExt.
