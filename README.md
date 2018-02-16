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
        
        let configuration = KeyboardSupportConfiguration(textFields: textFields, scrollView: scrollView)
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

        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let configuration = KeyboardSupportConfiguration(bottomConstraint: bottomConstraint, constraintOffset: tabBarHeight, usesKeyboardNextButtons: false)
        configureKeyboardSupport(with: configuration)
    }
}
```

3. Supporting dismissal of the keyboard by tapping outside a text field is the default behavior.
    To opt out, set usesDismissalView to false.
``` swift
var configuration = KeyboardSupportConfiguration()
configuration.usesDismissalView = false
configureKeyboardSupport(with: configuration)
```

4. Supporting the keyboard's "Return" key to navigate linearly from one text field to the next is the default behavior.
    To opt out, set usesKeyboardNextButtons to false.
``` swift
var configuration = KeyboardSupportConfiguration()
configuration.usesKeyboardNextButtons = false
configureKeyboardSupport(with: configuration)
```

5. Supporting a custom toolbar above the keyboard.
Create a custom UIToolbar or UIView that conforms to KeyboardInputAccessory. Then pass or set keyboardInputAccessoryView with this custom toolbar.
``` swift
import KeyboardSupport
    
class ViewController: KeyboardSupportViewController {
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let textFields: [UITextField] = [textField1, textField2]
        let keyboardToolbar = KeyboardToolbar() // A custom view conforming to KeyboardInputAccessory
        
        let configuration = KeyboardSupportConfiguration(textFields: textFields, keyboardInputAccessoryView: keyboardToolbar)
        configureKeyboardSupport(with: configuration)
    }
}
```
<img src="https://raw.githubusercontent.com/BottleRocketStudios/iOS-KeyboardSupport/master/Screenshots/KeyboardToolbar.png" width="320px" />

6. Get callbacks when the "Done" button is tapped through delegation.
``` swift
import KeyboardSupport

class ViewController: KeyboardSupportViewController {
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let textFields: [UITextField] = [textField1, textField2]
        
        let configuration = KeyboardSupportConfiguration(textFields: textFields)
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
