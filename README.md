<p align="center">
  <img width="420" src="assets/logo.png"/>
</p>

[![CocoaPods](https://img.shields.io/cocoapods/v/ATTipTextField.svg)](http://www.cocoapods.org/?q=attiptextfield)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift 3](https://img.shields.io/badge/swift-3-orange.svg)

UITextField subclass that can drop down a customizable message. Good for data validation UI.

:warning: This was just an excuse to try out IBDesignable and to build a framework in Swift. This code is kinda wack and I don't maintain this library so use at your own risk.

# Screenshot
<p align="center">
  <img width="420" src="assets/screenshot.gif"/>
</p>

# Setup with CocoaPods

```
pod 'ATTipTextField'

use_frameworks!
```

## Usage

Just use a subclass of TipTextField for your UITextField. You can set the class of your UITextField in your storyboard, or programmatically create a TipTextField instance.

Use `animateTip(visible: Bool)` to animate a tip below the TipTextField.

#### Swift
```swift
func showTip(success: Bool) {
  if success == true {
          emailTextField.tipBackgroundColor = // color for correct input
          emailTextField.tipText = // success message
          emailTextField.animateTip(visible: true)
   } else {
        emailTextField.tipBackgroundColor = // color for bad input
        emailTextField.tipText = // error message
        emailTextField.animateTip(visible: true)
    }
}

```

# Author
[@admtcl](https://twitter.com/admtcl)

# MIT License
    The MIT License (MIT)

    Copyright (c) 2016 Adam Tecle

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
