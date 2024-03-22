import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class VersionCheckService {
  static Future<String> showAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
    //return packageInfo.version;
  }

  static Future<String> getLatestVersion() async {
    const String versionUrl = 'https://cms.eapiq.com/apk/version.json';
    final response = await http.get(Uri.parse(versionUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['version'];
    } else {
      throw Exception('Failed to load latest version');
    }
  }

  static Future<void> checkAndUpdateVersion() async {
    try {
      final latestVersion = await getLatestVersion();
      var currentVersion =
          await showAppVersion(); // Replace with your current version
      showSnackBar("the current version is $currentVersion");
      if (latestVersion != currentVersion) {
        showSnackBar("New version available: $latestVersion");
        // Notify user about new version
        await downloadApk();
      } else {
        showSnackBar("You're already on the latest version: $latestVersion");
      }
    } catch (e) {
      showSnackBar('Failed to check for updates. Details: $e');
    }
  }

  static Future<void> installApk(String apkPath) async {
    log('APK beging installing... ');
    final process = await Process.start('su', ['-c', 'pm install -r $apkPath']);
    final exitCode = await process.exitCode;
    if (exitCode == 0) {
      showSnackBar('APK installation successful');
      await runAppAfterupdate();
    } else {
      showSnackBar('Failed to install APK. Error code: $exitCode');
    }
  }

  static Future<void> runAppAfterupdate() async {
    log('Runing App after update ');
    final process = await Process.start(
        'su', ['-c', 'm start -n com.eapiq.app/.MainActivity']);
    final exitCode = await process.exitCode;
    if (exitCode == 0) {
      showSnackBar('App run successful');
    } else {
      showSnackBar('App run. Error code: $exitCode');
    }
  }

  static Future<void> downloadApk() async {
    // URL of the APK file to be downloaded
    String apkUrl = 'https://cms.eapiq.com/apk/app-release.apk';
    showSnackBar("Start Downloading File");
    try {
      // Send a GET request to fetch the APK file
      var response = await http.get(Uri.parse(apkUrl));

      // Get the temporary directory of the device
      Directory tempDir = await getTemporaryDirectory();

      // Create a new file for the APK
      File apkFile = File('${tempDir.path}/app.apk');
      log("Start Downlading  :$apkUrl");
      // Write the APK content to the file
      showSnackBar('Starting Downloading');
      await apkFile.writeAsBytes(response.bodyBytes);
      // showSuccessSnackbar('Starting Downloading');
      // Install the APK using platform channels
      //await installApk(apkFile.path);
      showSnackBar("Downloading completed");

      await installApk(apkFile.path);
    } catch (e) {
      log('Error downloading or installing APK: $e');
    }
  }
}
