## Master

##### Enhancements

* None

##### Bug Fixes

* None


## 2.1.3 (2021-01-21)

##### Enhancements

* Adds support to not offset a KeyboardScrollable view if the viewController is presented in a popover.

##### Bug Fixes

* None

## 2.1.2 (2020-12-09)

##### Enhancements

* Added Swift Package Manager support.
[Wil Turner](https://github.com/WSTurner)
[#44](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/issues/44)

##### Bug Fixes

* Allowed setting the originalContentInsets before and after setting up the kyboard observers in KeyboardScrollable. This allows us to do things like setting content insets in viewDidLayoutSubviews() and such
[Fernando Arocho](https://github.com/Specialist17)
[#57](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/57)

* Fix issue with calculating content inset when scrollview is not constrained to bottom of safe area
[Dimitar Milinski](https://github.com/dmilinski08)
[#58](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/58)

## 2.1.1 (2020-01-16)

##### Enhancements

* Added Carthage support.
[Ryan Gant](https://github.com/ganttastic)
[#46](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/46)

##### Bug Fixes

* Addressed issue where scrolling to the focused text field would not work properly.
[Daniel Larsen](https://github.com/grandlarseny)
[#48](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/48)

## 2.1.0 (2019-04-30)

##### Enhancements

* Move protocols and extensions in KeyboardRespondable to separate files.
* Migrate to Swift 5.0.
[Earl Gaspard](https://github.com/earlgaspard)
[#41](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/41)

* `KeyboardRespondable` and `KeyboardDismissable` setup methods now return the generated gesture recognizer so consumers can work with it.
* Modified `KeyboardToolbar` to track the next, back, and done buttons so they can be hidden / enabled / disabled as needed. 
* Modified `KeyboardScrollable` to support an additional padding around a text input when moving it into view.
* Added a `KeyboardAutoNavigator` that is initialized with a toolbar. It will apply this toolbar to all text inputs, unless those inputs provide their own via implementing the `KeyboardToolbarProviding` protocol. The autonavigator will walk the view hiearchy and seek out text inputs before and after the current field to provide navigation via the toolbar. 
[John Davis](https://github.com/br-johndavis)
[#36](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/36)

##### Bug Fixes

* None

## 2.0.2 (2019-01-09)

##### Enhancements

* None

##### Bug Fixes

* Fix protocol extension function signature mismatch in `KeyboardScrollable`.
[Earl Gaspard](https://github.com/earlgaspard)
[#34](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/34)

## 2.0.1 (2019-01-09)

##### Enhancements

* None

##### Bug Fixes

* Declare `KeyboardAccessoryDelegate` extension as public. Declare `KeyboardInfo`'s properties as public.
[Earl Gaspard](https://github.com/earlgaspard)
[#32](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/32)

## 2.0.0 (2019-01-07)

##### Enhancements

* Added `KeyboardToolbar` for fast creation of input accessorty views. Renamed `KeyboardManager` to `KeyboardNavigator`. `KeyboardNavigator` supports navigating between `UITextView`s. Renamed `KeyboardInputAccessory` to `KeyboardAccessory`. Renaming of methods in `KeyboardDismissable` and methods in `KeyboardScrollable`. Animations added when keyboard appears when using `KeyboardScrollable`.
[Earl Gaspard](https://github.com/earlgaspard)
[#29](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/29)

* Adjusted project structure to better support Travis-CI. CI is fully up-and-running on all supported platforms.
[Earl Gaspard](https://github.com/earlgaspard)
[#10](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/10)

* Added SwiftLint.
[Earl Gaspard](https://github.com/earlgaspard)
[#10](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/10)

##### Bug Fixes

* None


## 1.0.2 (2018-09-19)

##### Enhancements

* **[BREAKING]** Renamed `KeyboardScrollable`'s `shouldPreserveContentInsetWhenKeyboardVisible` to `preservesContentInsetWhenKeyboardVisible` in order to fix a SwiftLint warning.
[Tyler Milner](https://github.com/tylermilner)
[#26](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/26)

 * Updated Travis-CI to Xcode 9.4 image.
   [Tyler Milner](https://github.com/tylermilner)
   [#21](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/21)
   
* On UITextView's, KeyboardRespondable now scrolls to cursor/selection.
  [Cuong Leo Ngo ](https://github.com/cuongcngo)
  [#23](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/23)

* Updated project for Xcode 10.
  [Tyler Milner](https://github.com/tylermilner)
  [#25](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/25)

##### Bug Fixes

 * None


## 1.0.1 (2018-08-20)

##### Enhancements

 * Adjusted project structure to better support Travis-CI. CI is fully up-and-running on all supported platforms.
  [Earl Gaspard](https://github.com/earlgaspard)
  [#10](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/10)
  
  * Added SwiftLint.
  [Earl Gaspard](https://github.com/earlgaspard)
  [#10](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/10)
  
  * Add option to disregard original content inset when keyboard is visible.
  [Cuong Leo Ngo ](https://github.com/cuongcngo)
  [#17](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/17)
  
   * Added conditional compilation for Swift 4.2 compatibility.
   [Tyler Milner](https://github.com/tylermilner)
   [#19](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/19)
  
##### Bug Fixes
  
  * Fix issue where bottom contentInset is added more than once when user taps on first responder view again.
  [Cuong Leo Ngo ](https://github.com/cuongcngo)
  [#12](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/12)
  
  * Now subtracting the Safe Area bottom inset when calculating additional bottom inset since the keyboard frame encompasses the safe area and scroll views' insets are typically automatically adjusted to account for safe area.
  [Cuong Leo Ngo ](https://github.com/cuongcngo)
  [#13](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/13)

 * Add KeyboardSafeAreaAdjustable protocol, and KeyboardScrollable restores original content inset
 [Cuong Leo Ngo ](https://github.com/cuongcngo)
 [#16](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/16)
 
 
## 1.0.0 (2017-12-28)

##### Initial Release

This is our initial release of KeyboardSupport. Enjoy!
