# KeyboardSupport 1.x-2.0 Migration Guide

This guide has been provided in order to ease the transition of existing applications using KeyboardSupport 1.x to the latest APIs, as well as to explain the structure of the new and changed functionality.

## Requirements

- iOS 9.0
- Swift 4.1
- Xcode 9.4

## Overview

KeyboardSupport 2.0 brings several refinements and improvements to the core functionality of KeyboardSupport. There are renaming and simplifications added but the overall functionality has not changed. Code changes should not be immediately neccessary to adopt this new version.

### Breaking Changes

### `KeyboardInputAccessory` and `KeyboardInputAccessoryDelegate` have been renamed

The `KeyboardInputAccessory` protocol has been deprecated and renamed to `KeyboardAccessory`. Similarly, `KeyboardInputAccessoryDelegate` has been renamed to `KeyboardAccessoryDelegate`. Otherwise, their purpose and functionality remains the same.

### `KeyboardManager` and `KeyboardManagerDelegate` have been renamed

The `KeyboardManager` class has been deprecated and renamed to `KeyboardNavigator`. Similarly, `KeyboardManagerDelegate` has been renamed to `KeyboardNavigatorDelegate`. The renaming better describes the class's purpose to assit with navigating back and forth between text inputs. Additionaly, `KeyboardNavigator` now supports navigating between `UITextView`s. Also, `KeyboardToolbar` is now the preferred view to pass into a `KeyboardNavigator` to allow navigating between text inputs.

### Methods in `KeyboardDismissable` and `KeyboardScrollable` have been renamed

Some of the methods in both `KeyboardDismissable` and `KeyboardScrollable` have been renamed to make them simplier and easier to understand. Othewise, their purpose remains the same. Additionaly, an animation for moving views in a scroll view when the keyboard shows or hides has been added.

### Additions

### `KeyboardToolbar` has been added

This new subclass of `UIToolbar` allows you to quickly create an input accessory view for your text inputs. There are several ways you can add `UIBarButtonItem`s to it.
