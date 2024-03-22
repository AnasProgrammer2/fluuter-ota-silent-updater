<h1>Project Name</h1>

<p>This function is designed for rooted Android devices.</p>

<h2>Installation</h2>

<h3>Step 1: Download the <code>ota_updater_apk.dart</code> file to your Flutter project.</h3>

<h3>Step 2: Import <code>ota-updater-apk.dart</code> into your Flutter project.</h3>

<pre><code>import 'package:[Project_name]/ota_updater_apk.dart';
</code></pre>

<h3>Step 3: Upload an APK file and a <code>version.json</code> file to your web server.</h3>

<ol>
  <li>Create a directory named <code>Apk</code> on your website.</li>
  <li>Upload the version of your APK file.</li>
  <li>Create a JSON file named <code>version.json</code> containing the version of your app.</li>
</ol>

<p>Example <code>version.json</code>:</p>

<pre><code>{
  "version": "1.0.2"
}
</code></pre>

<h2>Usage</h2>

<p>Call the <code>checkAndUpdateVersion</code> function in your <code>main.dart</code> file.</p>

<pre><code>await VersionCheckService.checkAndUpdateVersion();
</code></pre>

<h2>Running the App</h2>

<p>Run the app using the following command:</p>

<pre><code>flutter run
</code></pre>
