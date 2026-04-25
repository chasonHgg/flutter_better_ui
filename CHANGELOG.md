## 2.0.1

* Add `BetterButton` content alignment controls with `alignment`, `runAlignment`, and `crossAxisAlignment`.
* Fix `BetterButton` custom `child` visibility when `loading` and `hideContentWhenLoading` are enabled.

## 2.0.0

* Breaking change: initialize Better UI with `BetterUi` as the app wrapper instead of calling `BetterUtil.init` manually.
* Add `BetterUi.navigatorKey` and global context/overlay support for route-based popups, pickers, and toast.
* Update `BetterToast` APIs to support global usage without passing a `BuildContext`, including text, success, error, and loading toast variants.
* Update `BetterPicker`, `BetterPopup`, `BetterDatePicker`, and `BetterTimePicker` to use an optional named `context` parameter and fall back to `BetterUi.currentContext`.
* Update the example app and documentation to show `MaterialApp` configured with `navigatorKey: BetterUi.navigatorKey`.

## 1.0.14

* Add BetterIndexBar
* BetterToast add isGlobalToast property

## 1.0.13

* Fix the shadow issue of the button

## 1.0.12

* Optimize the use of BetterButton

## 1.0.11

* BetterToast add OnHide callback
* Add BetterSwiper
* Add BetterMarquee

## 1.0.10

* Add BetterTimePicker
* Optimize BetterButton
* Optimize BetterPopup to not require fixed height for pop-up in the middle

## 1.0.9

* Add BetterDatePicker
* BetterSwipeCell Add isStretch attribute


## 1.0.8

* BetterButton Add isShowBorder attribute

## 1.0.7

* Update document content

## 1.0.6

* add BetterSwipeCell
* Fix the height issue of BetterCell

## 1.0.5

* Fix theme errors

## 1.0.4

* Modify the usage document
* No breaking changes

## 1.0.3

* Add BetterSwitch
* Fix the background color of the Better Cell theme

## 1.0.2

* Documentation updates and minor cleanup
* No breaking changes

## 1.0.0

* add BetterButton
* add BetterCell
* add BetterPicker
* add BetterPopup
* add BetterToast
* add BetterTextButton

## 1.0.1

* Fix picker issue, add default parameter values
