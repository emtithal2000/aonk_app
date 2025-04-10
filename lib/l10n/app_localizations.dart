import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appbarTitle.
  ///
  /// In en, this message translates to:
  /// **'Associations'**
  String get appbarTitle;

  /// No description provided for @aboutAonk.
  ///
  /// In en, this message translates to:
  /// **'About Aonk'**
  String get aboutAonk;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @loyaltyProgram.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Program'**
  String get loyaltyProgram;

  /// No description provided for @loyaltyProgramSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get loyaltyProgramSoon;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @orderStatusSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get orderStatusSoon;

  /// No description provided for @aonk.
  ///
  /// In en, this message translates to:
  /// **'Aonk'**
  String get aonk;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @welcomeToAonk.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Aonk'**
  String get welcomeToAonk;

  /// No description provided for @enterYourData.
  ///
  /// In en, this message translates to:
  /// **'Enter your data...'**
  String get enterYourData;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login...'**
  String get login;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get pleaseEnter;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @streetNumber.
  ///
  /// In en, this message translates to:
  /// **'Street Number'**
  String get streetNumber;

  /// No description provided for @buildingNumber.
  ///
  /// In en, this message translates to:
  /// **'Building Number'**
  String get buildingNumber;

  /// No description provided for @floorNumber.
  ///
  /// In en, this message translates to:
  /// **'Floor Number'**
  String get floorNumber;

  /// No description provided for @oman.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get oman;

  /// No description provided for @uae.
  ///
  /// In en, this message translates to:
  /// **'UAE'**
  String get uae;

  /// No description provided for @ksa.
  ///
  /// In en, this message translates to:
  /// **'KSA'**
  String get ksa;

  /// No description provided for @kuwait.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get kuwait;

  /// No description provided for @bahrain.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get bahrain;

  /// No description provided for @qatar.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get qatar;

  /// No description provided for @whatIsAonk.
  ///
  /// In en, this message translates to:
  /// **'What is Aonk?'**
  String get whatIsAonk;

  /// No description provided for @aonkDescription.
  ///
  /// In en, this message translates to:
  /// **'Smart app to get rid of everything that is old and surplus'**
  String get aonkDescription;

  /// No description provided for @aonkDescription2.
  ///
  /// In en, this message translates to:
  /// **'You can get rid of everything that is old and surplus'**
  String get aonkDescription2;

  /// No description provided for @aonkDescription3.
  ///
  /// In en, this message translates to:
  /// **'Like clothes and shoes and bags and curtains and blankets and cushions and children\'s toys and kitchenware and books and novels and electronic devices'**
  String get aonkDescription3;

  /// No description provided for @aonkDescription4.
  ///
  /// In en, this message translates to:
  /// **'For the good of the associations in Oman, our goal is to '**
  String get aonkDescription4;

  /// No description provided for @aonkDescription5.
  ///
  /// In en, this message translates to:
  /// **'To raise your information about us, you can browse our social media sites'**
  String get aonkDescription5;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'No notifications found'**
  String get notificationsDescription;

  /// No description provided for @donationType.
  ///
  /// In en, this message translates to:
  /// **'Select donation type'**
  String get donationType;

  /// No description provided for @personalDonation.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personalDonation;

  /// No description provided for @giftDonation.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get giftDonation;

  /// No description provided for @clothes.
  ///
  /// In en, this message translates to:
  /// **'Clothes'**
  String get clothes;

  /// No description provided for @shoesAndBags.
  ///
  /// In en, this message translates to:
  /// **'Shoes and Bags'**
  String get shoesAndBags;

  /// No description provided for @curtainsAndBlankets.
  ///
  /// In en, this message translates to:
  /// **'Curtains and Blankets'**
  String get curtainsAndBlankets;

  /// No description provided for @childrenToys.
  ///
  /// In en, this message translates to:
  /// **'Children\'s Toys'**
  String get childrenToys;

  /// No description provided for @kitchenware.
  ///
  /// In en, this message translates to:
  /// **'Kitchenware'**
  String get kitchenware;

  /// No description provided for @booksAndpapers.
  ///
  /// In en, this message translates to:
  /// **'Books and Papers'**
  String get booksAndpapers;

  /// No description provided for @electronicDevices.
  ///
  /// In en, this message translates to:
  /// **'Electronic Devices'**
  String get electronicDevices;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @attachImages.
  ///
  /// In en, this message translates to:
  /// **'Attach Images'**
  String get attachImages;

  /// No description provided for @confirmDonation.
  ///
  /// In en, this message translates to:
  /// **'Confirm '**
  String get confirmDonation;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @errorDescription.
  ///
  /// In en, this message translates to:
  /// **'Please select an image'**
  String get errorDescription;

  /// No description provided for @successDescription.
  ///
  /// In en, this message translates to:
  /// **'We will contact you soon'**
  String get successDescription;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @enterPersonalData.
  ///
  /// In en, this message translates to:
  /// **'Enter personal data'**
  String get enterPersonalData;

  /// No description provided for @donationDetail1.
  ///
  /// In en, this message translates to:
  /// **'Clothes'**
  String get donationDetail1;

  /// No description provided for @donationDetail2.
  ///
  /// In en, this message translates to:
  /// **'Kitchenware'**
  String get donationDetail2;

  /// No description provided for @donationDetail3.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get donationDetail3;

  /// No description provided for @donationDetail4.
  ///
  /// In en, this message translates to:
  /// **'Curtains & Blankets'**
  String get donationDetail4;

  /// No description provided for @donationDetail5.
  ///
  /// In en, this message translates to:
  /// **'Shoes & Bags'**
  String get donationDetail5;

  /// No description provided for @donationDetail6.
  ///
  /// In en, this message translates to:
  /// **'Books & Papers'**
  String get donationDetail6;

  /// No description provided for @pleaseEnterCity.
  ///
  /// In en, this message translates to:
  /// **'Please enter city'**
  String get pleaseEnterCity;

  /// No description provided for @pleaseEnterCountry.
  ///
  /// In en, this message translates to:
  /// **'Please enter country'**
  String get pleaseEnterCountry;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Valid Email'**
  String get validEmail;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filterOrders.
  ///
  /// In en, this message translates to:
  /// **'Filter Orders'**
  String get filterOrders;

  /// No description provided for @allOrders.
  ///
  /// In en, this message translates to:
  /// **'All Orders'**
  String get allOrders;

  /// No description provided for @inProgressOrders.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressOrders;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
