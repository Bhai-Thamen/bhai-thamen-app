List selectedLanguage = ['english', 'bangla'];
int languageIndex = 1;

Map<String, String> english = {
  'welcome': 'Welcome to Bhai Thamen',
  'title': 'Bhai Thamen',
  'terms': 'Terms and conditions',
  'termsA':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate ut pharetra sit amet aliquam id diam. Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Habitasse platea dictumst vestibulum rhoncus. Eget egestas purus viverra accumsan in nisl nisi. Mattis vulputate enim nulla aliquet.',
  'termsB':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate ut pharetra sit amet aliquam id diam. Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Habitasse platea dictumst vestibulum rhoncus. Eget egestas purus viverra accumsan in nisl nisi. Mattis vulputate enim nulla aliquet.',
  'termsC':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate ut pharetra sit amet aliquam id diam. Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Habitasse platea dictumst vestibulum rhoncus. Eget egestas purus viverra accumsan in nisl nisi. Mattis vulputate enim nulla aliquet.',
  'accept': 'Accept',
  'enterCode': 'Enter code from SMS',
  'signInPrompt': 'Sign in with a valid Bangladeshi Phone Number',
  'loginBtn': 'Sign in',
  'whatIs': 'What is Bhai Thamen?',
  'invalidNumber': 'invalid number',
  'enterNumber': 'enter number',
  'unlockDevice': 'Unlock your device to access Bhai Thamen',
  'safetyZones': 'Safety Zones',
  'sos': 'SOS',
  'home': 'Home',
  'reminder': 'Reminder',
  'username': 'username',
  'age': 'age',
  'email': 'email',
  'yes': 'yes',
  'no': 'no',
  'confirm': 'confirm',
  'deleteAccount': 'Delete Account?',
  'deleteReason1': 'No longer needed',
  'deleteReason2': 'Privacy concerns',
  'deleteReason3': 'App does not work',
  'checkConfirm': 'Check to confirm',
  'deleteReason': 'Reason (optional)',
  'deleteExplain':
      '*We will need to check whether any cases are pending in your account befor we can permanently delete your data. We will let you know via SMS when the data had been checked and your account deleted',
  'deleteReview':
      'We will review your account and be in touch soon. You can continue using the app in the meantime.',
  'reallyDeleteBtn': 'Really Delete?',
  'testOn': 'Test mode on',
  'testOff': 'Test mode off',
  'checkSignOut1': 'Do you want to sign out?',
  'checkSignOut2': 'Emergency SMS sending will no longer be avaialble',
  'stay': 'STAY',
  'signOut': 'SIGN OUT',
  'trustedContacts': 'Trusted Contacts',
  'setProfile': 'My profile and trusted contacts',
  'setEvents': 'App Events',
  'setReports': 'Submited Reports',
  'setSecret': 'Pick Secret Screen',
  'setLanguage': 'Language: English',
  'setFeedback': 'App Feedback',
  'setDelete': 'Delete Account',
  'setSignOut': 'Sign Out',
  'reportId': 'Report ID',
  'reportSuccess': 'Report submitted successfully',
  'reportFail': 'There was an error submitting report. Please try again.',
  'Me': 'Myself',
  'Someone else': 'Someone else',
  'incidentDate': 'Incident Date',
  'incidentLocation': 'Incident Location',
  'incidentDescription': 'Incident Description',
  'associatedEvents': 'Associated Events',
  'noAssociatedEvents': 'There are no associated events for this date',
  'alarm': 'Alarm',
  'zone': 'Left safe zone',
  'sms': 'SMS',
  'sms-sent': 'SMS Sent',
  'sms-failed': 'SMS Failed',
  'recording': 'Recording',
  'welfare': 'Welfare Check',
  'typeOfIncident': 'Incident type',
  'Violence': 'Violence',
  'Harassment': 'Harassment',
  'Sexual Violence': 'Sexual Violence',
  'secretInstructions':
      'Tap below to select an image to use as your secret screen',
  'useDefault': 'Use Default',
  'welcomeFeedback': 'We welcome your feedback',
  'feedbackThankYou': 'Thank you for your feedback',
  'feedbackError': 'There was an error, please try again.',
  'submitError': 'There was an error submitting request. Please try again.',
  'selectTopic': 'Select a topic',
  'feedbackTopic1': 'App Design',
  'feedbackTopic2': 'Bug Report',
  'feedbackTopic3': 'Idea Suggestion',
  'cameraImage': ' Image from Camera',
  'galleryImage': ' Image from Gallery',
  'message': 'message',
  'ok': 'ok',
  'tapRecord': 'Tap to record voice message (only if you are unable to write)',
  'tapPhoto': 'Tap to include a photo/screenshot',
  'canContact': 'Can we contact you?',
  'anonymous': 'No send anonymously',
  'byEmail': 'By email',
  'byPhone': 'By phone',
  'submitBtn': 'Submit',
  'timer': 'Timer',
  'interval': 'Interval',
  '10sec': '10 sec',
  '1min': '1 min',
  '2min': '2 min',
  '5min': '5 mins',
  '10min': '10 mins',
  '15min': '15 mins',
  '20min': '20 mins',
  '30min': '30 mins',
  '60min': '1 hour',
  '90min': '1.5 hours',
  '120min': '2 hours',
  'stop': 'Stop',
  'cancel': 'Cancel',
  'restart': 'Restart',
  'confront': 'Confront',
  'report': 'report',
  'secrecy': 'secrecy',
  'notShare': 'SMS will not be sent',
  'doShare': 'SMS will be sent',
  'stopIt': 'Stop it',
  'goAway': 'Go away',
  'leaveAlone': 'Leave me alone',
  'pleaseLeave': 'Please leave',
  'alert': 'ALERT',
  'checkLeave': 'Do you want to leave this screen?',
  'leave': 'LEAVE',
  'date': 'Incident date',
  'type': 'Type of incident',
  'whoReporting': 'Who are you reporting for?',
  'where': 'Where did it take place?',
  'describe': 'Briefly describe the incident',
  'selectActions': 'Select any related app actions',
  'noActions': 'No associated app actions found for this date',
  'dummyScreenOff': 'Dummy screen off',
  'dummyScreenOn': 'Dummy screen on',
  'snoozeAlarm': 'Snooze alarm - delay sending SMS',
  'leftZone': 'You have left your safe zone',
  'snooze': 'SNOOZE',
  'location': 'location',
  'description': 'description',
  'settings': 'settings',
  'instructions': 'instructions',
  'needInternetTitle': 'No Internet Connection',
  'needInternetDesc': 'You need an active internet connection to login.',
  'tutorialPage': 'App Tutorial',
  'flashSMSSentTitle': 'SMS sending...',
  'flashSMSSentBody': 'SMS sent to trusted contacts',
  'flashSMSSFailTitle': 'SMS FAIL...',
  'flasSMSFailBody': 'SMS was not sent',
  'flashNoContactsTitle': 'No Trusted Contacts found',
  'flashNoContactsBody': 'Setup Trusted Contacts in Settings/Profile',
  'flashLongPressTitle': 'LONG PRESS',
  'flashLongPressBody': 'Hold Button down to send SMS',
  'flashConfirmTitle': 'CONFIRMATION NEEDED',
  'flashConfirmBody': 'Check box to confirm you want to delete',
  'flashZoneLimitTitle': 'Safe zone Limit',
  'flashZoneLimitBody': 'Maximum number of safe zones reached',
  'deleteData': 'Delete My Data',
  'deleteDataExplain':
      'You can request that we delete all your app generated data. This includes all photos and voice recordings you may have made. For security we will delete this data after 15 days to ensure it is not part of on any ongoing case. If you wish to delete your account please use the Delete Account option from the settings menu',
  'deleteDataReview':
      'We will review your request and inform you when your data has been deleted.',
  'setupProfile': 'Set up Profile',
  'expiredTextEN':
      'Thank you for testing Bhai Thamen. The trial period if now over and the app will no longer work. Please unintsall the app. If you would like to keep up-to-date with news about the release of the final version please visit the website below:',
  'expiredTextBN':
      'Thank you for testing Bhai Thamen. The trial period if now over and the app will no longer work. Please unintsall the app. If you would like to keep up-to-date with news about the release of the final version please visit the website below:',
  'loginErrorTitle': 'Problem logging in',
  'loginErrorBody': 'Try again after 10 minutes',
  'setPincodeOFF': 'Pin code OFF',
  'setPincodeON': 'Pin code ON',
  'news': 'News',
  'info': 'Info',
  'warn': 'Alert',
  'community': 'Community',
  'proximity': 'Distance',
  'popular': 'Popular',
  'recent': 'Recent',
  'myposts': 'My Posts',
  'askDeletePost1': 'DELETE POST',
  'askDeletePost2': 'Do you want to delete this post?',
  'locationSharingStatusOff': 'Location Sharing OFF',
  'locationSharingStatusOn': 'Location Sharing ON',
  'welfareCheckTitle': 'Welfare Check',
  'welfareCheckSubTitle': 'We noticed you might need help.',
  'welfareCheckQ1': 'Do you need help right now?',
  'welfareCheckQ2': 'Do you need to report an incident?',
  'notificationTitle': 'Bhai Thamen Welfare Check',
  'notificationBody': 'Do you need help right now?',
  'sideMenu1': 'News & Alerts',
  'sideMenu2': 'Personal Safety',
  'sideMenu3': 'Safe Places',
  'giveRating': 'Rate these details',
  'toilets': 'toilets',
  'medical': 'medical',
  'pharmacy': 'pharmacy',
  'shopping': 'shopping',
  'leisure': 'leisure',
  'food': 'food',
  'beauty': 'beauty',
  'reportScreenTitle': 'Report this location',
  'reportDescription':
      'Please only submit a report if you think this is a serious issue that will affect other users of Bhai Thamen',
  'reportReason1': 'Could not use toilet',
  'reportReason2': 'Inappropriate behaviour',
  'reportReason3': 'Other',
  'reportButton': 'Send Report',
  'reportPlaceSubmitted': 'Thank you. We have received your report.',
  'reportPlaceBtn': 'Report',
  'fullDetails': 'Full Details',
  'lowcost': 'Low Cost',
  'reasonable': 'Reasonable',
  'slightlyexpensive': 'Slightly Expensive',
  'expensive': 'Expensive',
  'notapplicable': 'N/A',
  'notsure': 'Not Sure',
  'free': 'Free',
  'getDirections': 'Get Directions',
  'price': 'Price: ',
  'facilities': 'Facilities',
};

Map<String, String> bangla = {
  'language': 'বাংলা',
  'welcome': 'ভাই থামেন অ্যাপে আপনাকে স্বাগতম',
  'title': 'ভাই থামেন',
  'terms': 'BN Terms and conditions',
  'termsA':
      'BN Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate ut pharetra sit amet aliquam id diam. Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Habitasse platea dictumst vestibulum rhoncus. Eget egestas purus viverra accumsan in nisl nisi. Mattis vulputate enim nulla aliquet.',
  'termsB':
      'BN Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate ut pharetra sit amet aliquam id diam. Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Habitasse platea dictumst vestibulum rhoncus. Eget egestas purus viverra accumsan in nisl nisi. Mattis vulputate enim nulla aliquet.',
  'termsC':
      'BN Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate ut pharetra sit amet aliquam id diam. Elit pellentesque habitant morbi tristique senectus et netus et malesuada. Habitasse platea dictumst vestibulum rhoncus. Eget egestas purus viverra accumsan in nisl nisi. Mattis vulputate enim nulla aliquet.',
  'accept': 'গ্রহণ করুণ',
  'enterCode': 'এসএমএস এর কোডটি লিখেন',
  'signInPrompt': 'বাংলাদেশী নম্বর দিয়ে সাইন ইন করুণ',
  'loginBtn': 'সাইন ইন করুণ',
  'whatIs': 'ভাই থামেন অ্যাপে সম্পর্কে জানতে ভিজিট করুনঃ',
  'invalidNumber': 'সঠিক নম্বর দিন',
  'enterNumber': 'আপনার নম্বর দিন',
  'unlockDevice': 'ভাই থামেন প্রবেশ করার জন্য আপনার ফোনটি খুলুন',
  'sos': 'এসওএস',
  'home': 'হোম',
  'reminder': 'স্মরণ',
  'safetyZones': 'নিরাপদ এলাকা',
  'username': 'ব্যবহারকারীর নাম',
  'email': 'ই-মেল',
  'age': 'বয়স',
  'yes': 'হ্যাঁ',
  'no': 'না',
  'confirm': 'নিশ্চিত করুন',
  'deleteAccount': 'অ্যাকাউন্ট ডিলিট',
  'checkConfirm': 'নিশ্চিত করতে চেক করুন',
  'deleteReason1': 'আর দরকারি নয়',
  'deleteReason2': 'গোপনীয়তার চিন্তা',
  'deleteReason3': 'অ্যাপ্লিকেশন কাজ করছে না',
  'deleteReason': 'কারণ',
  'deleteExplain':
      'আপনার তথ্য পুরোপুরি শরিয়ে ফেলার আগে আমাদের কিছু জিনিশ দেখে নিতে হবে। দেখে আপনার অ্যাকাউন্ট ডিলিট করার পরে আপনাকে এস এম এস এর মাধ্যমে জানানো হবে।',
  'deleteReview':
      'আপনাার অ্যাকাউন্ট পর্যালোচনা করা হবে। আপনি আপনার অ্যাকাউন্ট ব্যাবহার করতে থাকতে পারেন।',
  'reallyDeleteBtn': 'সত্যিই ডিলিট করবেন?',
  'testOn': 'টেস্ট মোড চালু', //'পরটাল মোড অন',
  'testOff': 'টেস্ট মোড বন্ধ', //'পরটাল মোড অফ',
  'checkSignOut1': 'আপনি কি অ্যাকাউন্ট থেকে বের হয়ে আসতে চান?',
  'checkSignOut2': 'তাহলে কোন জরুরি এস এম এস পাঠানো হবে না',
  'stay': 'থাকুন',
  'signOut': 'বেড় হয়ে যান',
  'trustedContacts': 'বিশ্বাসী ফোন নাম্বার',
  'setProfile': 'আমার প্রোফাইল এবং বিশ্বাসী নাম্বার',
  'setEvents': 'অ্যাপ্লিকেশন এর ঘটনা',
  'setReports': 'জমা দেয়া রিপোর্ট',
  'setSecret': 'গোপন স্ক্রীন বাছাই করুণ',
  'setFeedback': 'অ্যাপ্লিকেশন প্রতিক্রিয়া',
  'setLanguage': 'ভাষা: বাংলা',
  'setDelete': 'একাউন্ট মুছে ফেলুন',
  'setSignOut': 'একাউন্ট থেকে বের হন',
  'typeOfIncident': 'ঘটনার ধরণ',
  'reportId': 'রিপোর্ট আইডি',
  'reportSuccess': 'রিপোর্ট সফলভাবে জমা দেওয়া হয়েছে',
  'reportFail': 'রিপোর্ট জমা দেওয়ার সময় ক্রটি হয়েছি। আবার চেষ্টা করুন।',
  'Me': 'আমি',
  'Someone else': 'অন্য কেউ',
  'incidentDate': 'ঘটনার তারিখ',
  'incidentLocation': 'ঘটনা অবস্থান',
  'incidentDescription': 'সম্পর্কিত ঘটনা',
  'associatedEvents': 'এই তারিখের সাথে কোনও সম্পর্কিত ইভেন্ট নেই',
  'noAssociatedEvents': 'অ্যালার্ম',
  'alarm': 'অ্যালার্ম',
  'zone': 'নিরাপদ সীমানা অতিক্রম হয়েছে',
  'sms': 'এসএমএস',
  'sms-sent': 'এসএমএস পাঠানো হয়েছে',
  'sms-failed': 'এসএমএস ব্যর্থ হয়েছে',
  'Violence': 'সহিংসতা',
  'Harassment': 'হয়রানি',
  'Sexual Violence': 'যৌন সহিংসতা',
  'recording': 'রেকর্ডিং',
  'welfare': 'Welfare Check',
  'secretInstructions':
      'নিচে একটি চিত্র নির্বাচন করুন আপনার গোপন স্ক্রিন হিসাবে ব্যবহার করতে',
  'useDefault': 'ডিফল্ট ব্যবহার করুন',
  'welcomeFeedback': 'আমরা আপনার মতামত স্বাগত জানাই',
  'feedbackThankYou': 'আপনার মতামতের জন্য ধন্যবাত',
  'feedbackError': 'একটি ত্রুটি ছিল, অনুগ্রহ করে আবার চেষ্টা করুন.',
  'submitError':
      'অনুরোধ জমা দেওয়ার সময় একটি ত্রুটি হয়েছিল। আবার চেষ্টা করুন.',
  'selectTopic': 'একটি বিষয় নির্বাচন করুন',
  'feedbackTopic1': 'এপ্লিকেশন চিত্র/ডিসাইন',
  'feedbackTopic2': 'বাগ রিপোর্ট',
  'feedbackTopic3': 'ধারণা পরামর্শ',
  'cameraImage': 'ক্যামেরা থেকে চিত্র',
  'galleryImage': 'গ্যালারী থেকে চিত্র',
  'message': 'বার্তা',
  'ok': 'ঠিক আছে',
  'tapRecord':
      'ভয়েস বার্তা রেকর্ড করার জন্য চাপ দিন (কেবলমাত্র আপনি লিখতে ব্যর্থ হলে)',
  'tapPhoto': 'কোনও ছবি/স্ক্রিনশট অন্তর্ভুক্ত করতে চাপ দিন',
  'canContact': 'আমরা কি আপনার সাথে যোগাযোগ করতে পারি?',
  'anonymous': 'বেনামে পাঠাবেন না',
  'byEmail': 'ইমেইল এর মাধ্যমে',
  'byPhone': 'ফোন এর মাধ্যমে',
  'submitBtn': 'জমা দিন',
  'timer': 'সময় নির্ণায়ক',
  'interval': 'বিরতি',
  '10sec': '১০ সেকেন্ড',
  '1min': '১ মিনিট',
  '2min': '২ মিনিট',
  '5min': '৫ মিনিট',
  '10min': '১০ মিনিট',
  '15min': '১৫ মিনিট',
  '20min': '২০ মিনিট',
  '30min': '৩০ মিনিট',
  '60min': '১ ঘন্টা',
  '90min': '১.৫ ঘন্টা',
  '120min': '২ ঘন্টা',
  'stop': 'থামুন',
  'cancel': 'বাতিল',
  'restart': 'পুনরায় আরম্ভ করুন',
  'confront': 'মুখোমুখি',
  'report': 'রিপোর্ট',
  'secrecy': 'গোপনীয়তা',
  'notShare': 'বিশ্বস্ত ব্যক্তিকে এসএমএস পাঠানো হবে না',
  'doShare': 'বিশ্বস্ত ব্যক্তিকে এসএমএস পাঠানো হবে',
  'stopIt': 'থামুন',
  'goAway': 'চলে যান',
  'leaveAlone': 'আমাকে একা থাকতে দিন',
  'pleaseLeave': 'দয়া করে চলে যান',
  'alert': 'সতর্কতা',
  'checkLeave': 'আপনি কি স্ক্রীন থেকে বের হতে চান?',
  'leave': 'চলে যান',
  'date': 'ঘটনার তারিখ',
  'type': 'ঘটনাার ধরণ',
  'whoReporting': 'কার জন্য রিপোর্ট করছেন?',
  'where': 'কোথায় ঘটনাটি ঘটেছে?',
  'describe': 'সংক্ষেপে ঘটনাটি বর্ণনা করুন',
  'selectActions': 'যে কোন সম্পর্কিত অ্যাপ নির্বাচন করুন',
  'noActions': 'কোন সম্মিলিত অ্যাপ এটার সাথে সংযুক্ত নয়',
  'dummyScreenOff': 'নকল স্ক্রীন বন্ধ',
  'dummyScreenOn': 'নকল স্ক্রীন চালু',
  'snoozeAlarm': 'সময় বিরতি- এসএমএস পাঠাতে দেরি করা',
  'leftZone': 'আপনি আপনার নিরাপদ এলাকা থেকে চলে গিয়েছেন',
  'snooze': 'বিপদ সংকেত বিরতি',
  'location': 'অবস্থান',
  'description': 'বিবরণ',
  'settings': 'সেটিংস',
  'instructions': 'নির্দেশনা',

  'needInternetTitle': 'ইন্টারনেট নেই',
  'needInternetDesc': 'প্রবেশের জন্য ইন্টারনেটের প্রয়োজন।',
  'tutorialPage': 'অ্যাপ্লিকেশন প্রশিক্ষন',
  'flashSMSSentTitle': 'এসএমএস...',
  'flashSMSSentBody': 'বিশ্বস্ত ব্যক্তির নম্বরে এসএমএস পাঠানো হচ্ছে',
  'flashSMSSFailTitle': 'এসএমএসে সমস্যা...',
  'flasSMSFailBody': 'এস এম এস পৌঁছেনি',
  'flashNoContactsTitle': 'কোন বিশ্বাসী নাম্বার নেই',
  'flashNoContactsBody': 'সেটিংস/প্রোফাইলে বিশ্বাসী নাম্বার সেটআপ করুন',
  'flashLongPressTitle': 'অনেকক্ষণ চাপ দিয়ে ধরে রাখুন',
  'flashLongPressBody': 'এসএমএস পাঠানোর জন্য বাটন চাপ দিয়ে ধরে রাখুন',
  'flashConfirmTitle': 'নিশ্চিতকরণ জরুরী',
  'flashConfirmBody': 'মোছা নিশ্চিত করতে টিক চিহ্ন দিন',
  'flashZoneLimitTitle': 'নিরাপদ এলাকার সর্বোচ্চ সংখ্যা',
  'flashZoneLimitBody': 'নিরাপদ এলাকার সর্বোচ্চ সংখ্যা পৌঁছে গেছে',

  'deleteData': 'আমার তথ্য মুছে ফেলুন',
  'deleteDataExplain':
      'আপনি আমাদের জানাতে পারেন যদি এই এপ থেকে সৃষ্টি সকল তথ্য আপানি মুছে ফেলতে চান। এতে এই এপে তোলা ছবি ও ভয়েস রেকর্ডিং প্রযোজ্য। আপনার তথ্য সমুহ সুরক্ষার জন্য ১৫ দিন পর এটি মুছে ফেলা হবে যাতে এটি কোন চলমান কেসের তথ্য না হয়। যদি আপনি একাউন্ট মুছে ফেলতে চান তাহলে সেটিংস মেনুতে প্রবেশ করে মুছে ফেলার অপশন ব্যবহার করতে পারবেন।',
  'deleteDataReview':
      'আমরা আপনার আবেদনটি যাচাই করে তথ্য মুছে ফেলার পর আপনাকে জানাব',
  'setupProfile': 'প্রফাইল সেট করুন',
  'expiredTextEN':
      'Thank you for testing Bhai Thamen. The trial period if now over and the app will no longer work. Please unintsall the app. If you would like to keep up-to-date with news about the release of the final version please visit the website below:',
  'expiredTextBN':
      'Thank you for testing Bhai Thamen. The trial period if now over and the app will no longer work. Please unintsall the app. If you would like to keep up-to-date with news about the release of the final version please visit the website below:',
  'loginErrorTitle': 'Problem logging in',
  'loginErrorBody': 'Try again after 10 minutes',
  'setPincodeOFF': 'পিন কোড বন্ধ',
  'setPincodeON': 'পিন কোড চালু',

  'news': 'খবর',
  'info': 'তথ্য',
  'warn': 'সতর্কতা',
  'community': 'সম্প্রদায়',
  'proximity': 'Distance BD',
  'popular': 'Popular BD',
  'recent': 'Recent BD',
  'myposts': 'My Posts BD',
  'locationSharingStatusOff': 'Location Sharing OFF BD',
  'locationSharingStatusOn': 'Location Sharing ON BD',

  'askDeletePost1': 'DELETE POST BD',
  'askDeletePost2': 'Do you want to delete this post? BD',

  'welfareCheckTitle': 'Welfare Check BD',
  'welfareCheckSubTitle': 'We noticed you might need help. BD',
  'welfareCheckQ1': 'Do you need help right now? BD',
  'welfareCheckQ2': 'Do you need to report an incident? BD',

  'notificationTitle': 'Bhai Thamen Welfare Check BD',
  'notificationBody': 'Do you need help right now? BD',

  'sideMenu1': 'News & Alerts BD',
  'sideMenu2': 'Personal Safety BD',
  'sideMenu3': 'Safe Places BD',
  'giveRating': 'Rate these details BD',
  'toilets': 'টয়লেট',
  'medical': 'চিকিৎসা',
  'pharmacy': 'চিকিৎসা',
  'shopping': 'কেনাকাটা',
  'leisure': 'অবসর',
  'food': 'খাদ্য',
  'beauty': 'সৌন্দর্য',

  'reportScreenTitle': 'Report this location BD',
  'reportDescription':
      'Please only submit a report if you think this is a serious issue that will affect other users of Bhai Thamen BD',
  'reportReason1': 'Could not use toilet BD',
  'reportReason2': 'Inappropriate behaviour BD',
  'reportReason3': 'Other BD',
  'reportButton': 'Send Report BD',
  'reportPlaceSubmitted': 'Thank you. We have received your report. BD',
  'reportPlaceBtn': 'Report BD',
  'lowcost': 'Low Cost BD',
  'fullDetails': 'Full Details BD',
  'reasonable': 'Reasonable BD',
  'slightlyexpensive': 'Slightly Expensive BD',
  'expensive': 'Expensive BD',
  'notapplicable': 'N/A BD',
  'notsure': 'Not Sure BD',
  'free': 'Free BD',
  'getDirections': 'Get Directions BD',
  'price': 'Price BD: ',
  'facilities': 'Facilities BD',
};

Map<String, Map<String, String>> languages = {
  'english': english,
  'bangla': bangla
};
