# KeyboardSupport
[![CI Status](http://img.shields.io/travis/BottleRocketStudios/iOS-KeyboardSupport.svg?style=flat)](https://travis-ci.org/BottleRocketStudios/iOS-KeyboardSupport)
[![Version](https://img.shields.io/cocoapods/v/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![License](https://img.shields.io/cocoapods/l/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![Platform](https://img.shields.io/cocoapods/p/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![codecov](https://codecov.io/gh/BottleRocketStudios/iOS-KeyboardSupport/branch/master/graph/badge.svg)](https://codecov.io/gh/BottleRocketStudios/iOS-KeyboardSupport)
[![codebeat badge](https://codebeat.co/badges/3ef15dda-15d5-4bb6-a7f1-13f22da10813)](https://codebeat.co/projects/github-com-bottlerocketstudios-ios-keyboardsupport-master)


## Purpose

This library provides conveniences for dealing with common keyboard tasks. There are a few main goals:

* Make it easy to auto-dismiss the keyboard via tap on screen.
* Auto-scrolling to the active `UITextField` or `UITextView`.
* Make navigation between text inputs worry free with your own view.
* Allow keyboard "return" key to navigate between `UITextField`s.
* Provide a `UIToolbar` subclass so you can create your own input accessory views faster.

## Key Concepts

* **KeyboardDismissable** - A protocol that enables automatic keyboard dismissal via tapping the screen when the keyboard is displayed.
* **KeyboardScrollable** - A protocol that enables scrolling views to the first responder when a keyboard is shown. Must be used with a `UIScrollView` or one of its subclasses.
* **KeyboardRespondable** - Inherits from both `KeyboardDismissable` and `KeyboardScrollable` for convenience.
* **KeyboardToolbar** - A subclass of `UIToolbar` with customization options to quickly create your own input accessroy views.
* **KeyboardAccessory** - Have your custom view conform to this protocol to get callbacks for "back", "next", and "done" for moving between text fields.
* **KeyboardNavigator** - Handles navigaton between text inputs by providing your `KeyboardToolbar` or using the keyboard's return key.

## Usage

### KeyboardDismissable
Conform to this protocol to enable keyboard dismissal via tapping the screen when the keyboard is displayed.
``` swift
class ViewController: UIViewController, KeyboardDismissable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismissal()
    }
}
```

### KeyboardScrollable
Conform to this protocol to enable scrolling to the first responder when the keyboard is shown. Must be used with a `UIScrollView` or one of its subclasses.
``` swift
class ViewController: UIViewController, KeyboardScrollable {

    @IBOutlet private var scrollView: UIScrollView!
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardScrollableScrollView = scrollView
        addKeyboardObservers()
    }

    deinit {
        removeKeyboardObservers()
    }
}
```

### KeyboardToolbar
Create your own input accessory view quickly with `UIBarButtonItem`s.
``` swift
let keyboardToolbar = KeyboardToolbar()
keyboardToolbar.addBackButton(title: "Back")
keyboardToolbar.addNextButton(title: "Next")
keyboardToolbar.addFlexibleSpace()
keyboardToolbar.addSystemDoneButton()
}
```
Check out KeyboardToolbar for other button adding options.


### KeyboardNavigator - when using a KeyboardToolbar
Create a KeyboardToolbar. Create a KeyboardNavigator. Pass in your text inputs and toolbar. The order of the text fields determines the navigation order for traversing from one to the next. Optionaly, set the KeyboardNavigator's delegate to receive call backs when tapping "Back", "Next", and "Done" in your KeyboardToolbar. **Please see the example project for tips when using `UITextViews`.**
``` swift
class ViewController: UIViewController {

    @IBOutlet private var textInput1: UITextField!
    @IBOutlet private var textInput2: UITextView!
    private var keyboardNavigator: KeyboardNavigator?

    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardToolbar = KeyboardToolbar()
        keyboardNavigator = KeyboardNavigator(textInputs: [textInput1, textInput2], keyboardToolbar: keyboardToolbar)
        keyboardNavigator?.delegate = self
    }
}

extension ViewController: KeyboardNavigatorDelegate {

    func keyboardNavigatorDidTapBack(_ navigator: KeyboardNavigator) {
        // Your code here
    }

    func keyboardNavigatorDidTapNext(_ navigator: KeyboardNavigator) {
        // Your code here
    }

    func keyboardNavigatorDidTapDone(_ navigator: KeyboardNavigator) {
        // Your code here
    }
}
```

### KeyboardNavigator - when using the keyboard's "Return" key
Create a KeyboardNavigator. Pass in your text inputs. The order of the text fields determines the navigation order for traversing from one to the next. Make sure returnKeyNavigationEnabled is set to `true`.  **You can have a KeyboardNavigator use both a KeyboardToolbar and the keyboard's "Return" keys.**
``` swift
class ViewController: UIViewController {

    @IBOutlet private var textInput1: UITextField!
    @IBOutlet private var textInput2: UITextField!
    private var keyboardManager: KeyboardManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardNavigator = KeyboardNavigator(textInputs: [textInput1, textInput2], returnKeyNavigationEnabled: true)
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0+
* Swift 4.1

## Installation

KeyboardSupport is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KeyboardSupport'
```

## Author

[Bottle Rocket Studios](https://www.bottlerocketstudios.com/)

## License

Hyperspace is available under the Apache 2.0 license. See the LICENSE.txt file for more info.

## Contributing

See the [CONTRIBUTING] document. Thank you, [contributors]!

[CONTRIBUTING]: CONTRIBUTING.md
[contributors]: https://github.com/BottleRocketStudios/iOS-KeyboardSupport/graphs/contributors
