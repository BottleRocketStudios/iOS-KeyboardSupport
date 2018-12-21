## Master

## 2.0.0 (2018-12-21)

##### Enhancements

* Added `KeyboardToolbar` for fast creation of input accessorty views. Renamed `KeyboardManager` to `KeyboardNavigator`. `KeyboardNavigator` supports navigating between `UITextView`s. Renamed `KeyboardInputAccessory` to `KeyboardAccessory`. Renaming of methods in `KeyboardDismissable` and methods in `KeyboardScrollable`. Animations added when keyboard appears when using `KeyboardScrollable`.
[Earl Gaspard](https://github.com/earlgaspard)
[#](https://github.com/BottleRocketStudios/iOS-KeyboardSupport/pull/)

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
