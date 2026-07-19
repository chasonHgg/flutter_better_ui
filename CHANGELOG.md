
## 2.0.17

* Add `BetterIndexBar.onChanged` to listen for active index changes from scrolling or touching the index bar.
* Fix `BetterToast` in global toast mode so rapid repeated calls update the existing toast content instead of recreating the overlay, preventing flicker.
* Fix `BetterToast` global toast auto-dismiss timing during rapid updates so the latest toast can disappear normally after updates stop.
* Guard toast animation controllers from being used after disposal when toast instances are replaced or removed asynchronously.

## 2.0.16

* Fix `BetterSwipeCell` calling its animation controller after disposal when an asynchronous action completes.
* Prevent animation listener accumulation in `BetterSwipeCell`.

## 2.0.15

* Change `BetterToast.showLoading` to block clicks by default.

## 2.0.14

* Add `BetterDialog` for alert and confirmation dialogs with optional title, content, cancel/confirm buttons, callbacks, disabled button states, custom bottom content, and global context fallback.

## 2.0.12

* Rename `BetterButton`, `BetterCell`, and `BetterSwipeCellAction` click callbacks from `onClick` to `onTap`.
* Add `onLongPress` support to `BetterButton`.
* Update examples and documentation to use the new tap callback APIs.

## 2.0.10

* Fix `BetterToast` in global toast mode so normal toast overlays no longer intercept taps on underlying widgets when `forbidClick` is disabled.

## 2.0.9

* Add `BetterSlideAction`, a slide-to-complete action button with controller reset support.
* Add reverse sliding with `reverse`, from right to left when enabled.
* Add `color`, `boxDecoration`, custom knob/content, disabled state, and auto-reset examples for `BetterSlideAction`.
* Add `BetterSlideAction` example page, route, home entry, and i18n labels.

## 2.0.7

* Fix state synchronization when `BetterSwitch.defaultValue` changes after parent rebuilds.
* Optimize update handling for `BetterSwiper`, `BetterSwipeCell`, `BetterMarquee`, and `Spinner` when related widget parameters change.

## 2.0.6

* Fix global `BetterToast` replacement so the new toast is inserted before existing toast instances are dismissed.
* Update toast dismissal tracking to avoid stale delayed callbacks hiding newer global toast instances.

## 2.0.5

* Add `BetterAssets` for generating Dart asset constant classes from image directories.
* Add test usage for `BetterAssets.generate`, including temporary project setup and generated output assertions.

## 2.0.4

* Update `BetterCollapse` to render a single `BetterCollapseItem` so it can be composed inside page-level scroll views more easily.
* Add `expansibleController` support for controlling `BetterCollapse` expand and collapse from outside.
* Update `BetterCollapse` examples in README and README_ZH.

## 2.0.2

* Add `BetterCollapse` theme support for background, collapsed background, arrow icon colors, and ripple color.
* Add `BetterCollapse` accordion mode with `accordion`.
* Add `BetterCollapse` title spacing controls with `minTitleHeight` and `titleMinVerticalPadding`.

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
