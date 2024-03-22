#  thie funtion for only rooted android

<!-- start:code block -->
# downlading file ota_updater_apk.dart to your Flutter project


# import ota-updater-apk.dart to  Flutter project 
import 'package:[Project_name]/ota_updater_apk.dart';

# upload on your webserver a apk file  file version.josn
1-create on your website Folor Apk/
upload the the version of your apk 
2- create a json file version.json and that have a verson of app
<code>{
  "version": "1.0.2"
}</code>

# call void checkAndUpdateVersion on main.dart 
use <code>await VersionCheckService.checkAndUpdateVersion();</code> 

# Run the app
flutter run

