Kandy iOS SDK
=============

Introduction
------------

Kandy's cloud-based features enable developers to seamlessly embed voice, video, rich messaging, presence, co-browsing, and screen sharing into Web and mobile applications – creating a more engaging experience for customers and boosting collaboration and productivity with employees. Kandy's suite of Sample Code, SDKs, APIs, and applications - enables developers to cost effectively and efficiently speed the deployment of real time communications (RTC) into existing workflows and new offerings.

Cross Platform Support

Kandy supports [JavaScript SDK], [REST API], [iOS] and [Android SDKs] and makes it easier for web and mobile developers to embed real time communications with in their applications.


Kandy Features Supported
------------------------

* Provisioning
* User Login
* Push
* Location
* IP Calls (Voice & Video)
* Rich Messaging
* Group Messaging
* Presence
* Contacts


Requirements
------------

* You will need Xcode and can be downloaded from [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)
* The Kandy SDK for iOS versions supports iOS7 and higher.

Installation
------------

Kandy is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Kandy"
```

or

Add the Kandy SDK for iOS to your project and configure project file

Add the following Kandy framework:

* KandySDK.framework

You can do so by either dragging them to the Project Navigator, or by choosing “Add files” from the Project Navigator Context Menu.

Required frameworks and libraries:

* VideoToolbox.framework
* CoreTelephony.framework
* GLKit.framework
* libstdc++.6.dylib
* libicucore.dylib
* CoreMedia.framework
* AudioToolbox.framework
* libsqlite3.dylib
* SystemConfiguration.framework
* AVFoundation.framework
* AddressBook.framework
* ImageIO.framework
* MobileCoreServices.framework
* Libc++.dylib
* CoreLocation.framework

Release Notes
-------------
v1.6.4

* Subscriber Provisioning
 * Added possibility to set the caller phone number prefix when requesting code by IVR. Phone number will be a combination of the provided prefix and the validation code.

* Chat Service
 * Added possibility to attach custom data to chat messages. See KandyMediaItemProtocol and docs (`Attaching custom data to message`).

* Presence
 *  Presence State Updates
   * Enable user to update his presence status and listening to other users presence status updates
 * Get Last Seen
   * Method signature [retreivePresenceForRecords: responseCallback:]
    Changed [getLastSeenForRecords: responseCallback:]
 * Update Presence State
   * Method signature [updateSelfPresenceState:presenceActivityType: withResponseCallback:]
 * Start Watch Presence
   * Method signature [startWatchPresenceForRecords: withResponseCallback:]
 * Stop Watch Presence
   * Method signature [stopWatchPresenceForRecords: withResponseCallback:]

[JavaScript SDK]: <https://developer.kandy.io/docs/js-sdk/>
[iOS]: <https://developer.kandy.io/docs/ios-sdk/>
[Android SDKs]: <https://developer.kandy.io/docs/android-sdk/>
[REST API]: <https://developer.kandy.io/docs/rest-api>
