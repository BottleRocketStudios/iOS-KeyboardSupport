# KeyboardSupport
[![CI Status](http://img.shields.io/travis/BottleRocketStudios/iOS-KeyboardSupport.svg?style=flat)](https://travis-ci.org/BottleRocketStudios/iOS-KeyboardSupport)
[![Version](https://img.shields.io/cocoapods/v/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![License](https://img.shields.io/cocoapods/l/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)
[![Platform](https://img.shields.io/cocoapods/p/KeyboardSupport.svg?style=flat)](http://cocoapods.org/pods/KeyboardSupport)

## Purpose
This library provides conveniences for dealing with common keyboard tasks. There are a few main goals:

* Make it easy to auto-dismiss the keyboard via tap on screen.
* Auto-scrolling to the active text field.
* Make navigation between text fields worry free with your own view.
* Allow keyboard "Return" key to navigate between text fields.

## Key Concepts
* KeyboardInputAccessory - A protocol your custom view conforms to that gets callbacks for "back", "next", and "done" when moving between text fields.
* KeyboardSupportViewController - A sublcass of UIViewController which handles different keyboard support options.
* KeyboardSupportConfiguration - A struct composed of different options which include:
        * Auto scrollling when keyboard appears by passing in your UIScrollView
        * Moving a view when keyboard appears by passing in a bottom constraint and constraint offest if necessary
        * Easy dismissal of the keyboard by tapping outside a text field
        * Use of the keyboard's "Return" key to navigate between text fields
        * Use of your custom keyboard toolbar to navigate between text fields
        * Callback when the "Done" button of your custom toolbar or keyboard "Return" button is tapped
        
## Usage
### KeyboardSupportViewController can be configured with different options.

1. Supporting a UIScrollView or one of its subclasses.
``` swift
import KeyboardSupport

class ViewController: KeyboardSupportViewController {
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFields: [UITextField] = [textField1, textField2]
        
        let configuration = KeyboardSupportConfiguration(textFields: textFields, scrollView: scrollView, usesDismissalView: true, usesKeyboardNextButtons: true)
        configureKeyboardSupport(with: configuration)
    }
}
```

2. Supporting a bottom constraint of a view.
    Passing a constraint offset can be useful when dealing with tab bars.
``` swift
import KeyboardSupport

class ViewController: KeyboardSupportViewController {
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = KeyboardSupportConfiguration(bottomConstraint: bottomConstraint, constraintOffset: 49, usesDismissalView: true)
        configureKeyboardSupport(with: configuration)
    }
}
```

3. Supporting dismissal of the keyboard by tapping outside a text field.
    Make sure usesDismissalView is set to true.
``` swift
var configuration = KeyboardSupportConfiguration()
configuration.usesDismissalView = true
configureKeyboardSupport(with: configuration)
```

4. Supporting the keyboard's "Return" key to navigate linearly from one text field to the next.
    Make sure usesKeyboardNextButtons is set to true.
``` swift
var configuration = KeyboardSupportConfiguration()
configuration.usesKeyboardNextButtons = true
configureKeyboardSupport(with: configuration)
```

5. Supporting your custom toolbar above the keyboard.
    Create your custom view and conform to KeyboardInputAccessory. Pass it in.
``` swift
import KeyboardSupport
    
class ViewController: KeyboardSupportViewController {
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let textFields: [UITextField] = [textField1, textField2]
        let keyboardToolbar = KeyboardToolbar() // A custom view conforming to KeyboardInputAccessory
        
        let configuration = KeyboardSupportConfiguration(textFields: textFields, usesDismissalView: true, usesKeyboardNextButtons: true, keyboardInputAccessoryView: keyboardToolbar)
        configureKeyboardSupport(with: configuration)
    }
}
```

6. Get callbacks when the "Done" button is tapped through delegation.
``` swift
import KeyboardSupport

class ViewController: KeyboardSupportViewController {
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let textFields: [UITextField] = [textField1, textField2]
        
        let configuration = KeyboardSupportConfiguration(textFields: textFields, usesDismissalView: true, usesKeyboardNextButtons: true)
        configureKeyboardSupport(with: configuration)
        keyboardSupportDelegate = self
    }
}

extension ViewController: KeyboardSupportDelegate {
    func didTapDoneButton() {
        // Execute code for "Done" button tap such as validation or login.
    }
}
```

7. If you need to invoke navigation yourself between text fields, use these provided methods.
``` swift
moveToNextTextField()
moveToPreviousTextField()
resignCurrentTextField()
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
