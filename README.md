# KeyboardSupport
[![CI Status](http://img.shields.io/travis/BottleRocketStudios/iOS-KeyboardSupport.svg?style=flat)](https://travis-ci.org/BottleRocketStudios/iOS-KeyboardSupport)
[![Version](https://img.shields.io/cocoapods/v/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![License](https://img.shields.io/cocoapods/l/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![Platform](https://img.shields.io/cocoapods/p/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)

## Purpose
This library provides conveniences for dealing with common keyboard tasks. There are a few main goals:

* Make it easy to auto-dismiss the keyboard via tap on screen.
* Auto-scrolling to the active text field/view.
* Make navigation between text views worry free with your own view.
* Allow keyboard "return" key to navigate between text fields.

## Key Concepts
* KeyboardManager - Handles navigaton between text fields by providing your custom view or using the keyboard's return key.
* KeyboardInputAccessory - Your custom view conforms to this protocol to get callbacks for "back", "next", and "done" for moving between text fields.
* KeyboardDismissable - A protocol that enables automatic keyboard dismissal via tapping the screen when the keyboard is displayed.
* KeyboardScrollable - A protocol that enables scrolling views to the first responder when a keyboard is shown. Must be used with a UIScrollView or one of its subclasses.
* KeyboardRespondable - Inherits from both KeyboardDismissable and KeyboardScrollable for convenience.

## Usage
### KeyboardManager for using "Return" key.
Create a KeyboardManager. Pass in your UITextFields. Make sure returnKeyNavigationEnabled is set to `true`. The order of the text fields determines the navigation order for traversing from one to the next.
``` swift
class ViewController: UIViewController {
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!
    private var keyboardManager: KeyboardManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardManager = KeyboardManager(textFields: [textField1, textField2], returnKeyNavigationEnabled: true)
    }
}
```

You can also set the delegate of the KeyboardManager to get a callback when "Done" is tapped on the keyboard.
``` swift
override func viewDidLoad() {
    super.viewDidLoad()

    keyboardManager = KeyboardManager(textFields: [textField1, textField2], configuresReturnKeys: true)
    keyboardManager?.delegate = self
}
```

``` swift
extension ViewController: KeyboardManagerDelegate {
    func keyboardManagerDidTapDone(_ manager: KeyboardManager) {
        // Handle "Done" tap
    }
}
```

### KeyboardManager with custom view above the keyboard.
Create a custom class that is a subclass of UIView or one of its subclasses to pass to the KeyboardManager. Your custom class can conform to KeyboardInputAccessory so the KeyboardManager handles navigation between text fields. Otherwise, your view controller can handle navigation callbacks.
``` swift
class KeyboardToolbar: UIToolbar, KeyboardInputAccessory {
    // Use the delegate
    weak var keyboardInputAccessoryDelegate: KeyboardInputAccessoryDelegate?

    // Example button actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        keyboardInputAccessoryDelegate?.keyboardInputAccessoryDidTapBack(self)
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        keyboardInputAccessoryDelegate?.keyboardInputAccessoryDidTapNext(self)
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        keyboardInputAccessoryDelegate?.keyboardInputAccessoryDidTapDone(self)
    }
}
```

### KeyboardDismissable
Conform to this protocol to enable keyboard dismissal via tapping the screen when the keyboard is displayed.
``` swift
class ViewController: UIViewController, KeyboardDismissable {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissalView()
    }
}
```

### KeyboardScrollable
Conform to this protocol to enable scrolling to the first responder when the keyboard is shown. Must be used with a UIScrollView or one of its subclasses.
``` swift
class ViewController: UIViewController, KeyboardScrollable {

    @IBOutlet private var scrollView: UIScrollView!
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardScrollableScrollView = scrollView
        setupKeyboardDismissalView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}
```

### KeyboardRespondable
Conform to this protocol to utilize both KeyboardDismissable and KeyboardScrollable.
``` swift
class ViewController: UIViewController, KeyboardRespondable {

    @IBOutlet private var scrollView: UIScrollView!
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardScrollableScrollView = scrollView
        setupKeyboardRespondable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 9.0+
* Swift 4

## Installation

KeyboardSupport is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KeyboardSupport'
```

## Contributing

See the [CONTRIBUTING] document. Thank you, [contributors]!

[CONTRIBUTING]: CONTRIBUTING.md
[contributors]: https://github.com/BottleRocketStudios/iOS-KeyboardSupport/graphs/contributors
