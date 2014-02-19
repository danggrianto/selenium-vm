Install Google's Chrome browser (use the chromium package for the open source version).

By default, the recipe installs the stable version of chrome.  However, you can set the track by setting a node/role attribute:
    "google-chrome" => { "track" => "beta" }
