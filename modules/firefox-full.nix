{ config, pkgs, ... }:

let
  # Firefox's internal add-on ID (shown in about:support) is not the same
  # string as the AMO ("addons.mozilla.org") URL slug used in download
  # links — ExtensionSettings is keyed by the id, install_url needs the slug.
  extensions = [
    { id = "uBlock0@raymondhill.net";     slug = "ublock-origin"; }             # uBlock Origin
    { id = "sponsorBlocker@ajay.app";     slug = "sponsorblock"; }              # SponsorBlock
    { id = "jid1-KKzOGWgsW3Ao4Q@jetpack"; slug = "i-dont-care-about-cookies"; } # I don't care about cookies
  ];
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    # Check about:policies#documentation for options.
    policies = {
      ExtensionSettings = builtins.listToAttrs (map (ext: {
        name = ext.id;
        value = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${ext.slug}/latest.xpi";
          installation_mode = "force_installed"; # "force_installed" = can't be removed/disabled by user
                                                   # "normal_installed" = installed, but user can remove/disable it
                                                   # "allowed" / "blocked" = user may / may not install it manually
        };
      }) extensions);

      #### DEBLOAT ###
      DisableFirefoxStudies = true;
      #DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true; # locks the check off regardless of the pref below
      UserMessaging = {
        ExtensionRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      #### SECURITY ###
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      #### PRIVACY ###
      DisableTelemetry = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        Exceptions = [
          "https://youtube.com"
        ];
      };
      DisablePocket = true; # removes Pocket entirely; the pref below only hides its UI
      NetworkPrediction = false;

      # # Delete data on shutdown
      # SanitizeOnShutdown = {
      #     Cache = true;
      #     FormData = true;
      #     SiteSettings = true;
      #     OfflineApps = true;
      # };

      SearchEngines = {
        Remove = [
          "eBay"
          "Google"
          "Bing"
          "Ecosia"
          "Wikipedia"
          "Perplexity"
        ];
        Add = [
          {
            "Name" = "DuckDuckGo";
            "URLTemplate" = "https://duckduckgo.com/?q={searchTerms}&ia=web&assist=false";
            "IconURL" = "https://duckduckgo.com/favicon.ico";
            "Alias" = "ddg";
            "Description" = "Duckduckgo without AI integrations";
          }
        ];
        Default = "DuckDuckGo";
      };
      SearchSuggestEnabled = false;
    };

    profiles.default = {
      id = 0;
      isDefault = true;

      # about:config settings. The old top-level "preferences" option
      # doesn't exist in home-manager — this is the real option name.
      settings = {

        #### GENERAL (left at Firefox's own defaults — change freely) ###
        "browser.startup.page" = 1;                       # 0 = blank page, 1 = home page, 2 = last visited page, 3 = resume previous session
        "browser.startup.homepage" = "about:home";         # any URL string, e.g. "https://example.com", or "about:blank"
        "browser.newtabpage.enabled" = true;               # true / false — show Firefox Home on new tab
        "browser.shell.checkDefaultBrowser" = true;        # true / false — moot here: DontCheckDefaultBrowser policy above locks this off
        "browser.tabs.warnOnClose" = true;                 # true / false — warn when closing a window with multiple tabs
        "browser.tabs.closeWindowWithLastTab" = true;      # true / false — close the window when its last tab is closed
        "browser.download.useDownloadDir" = true;          # true / false — if false, always ask where to save each file
        "browser.download.folderList" = 1;                 # 0 = Desktop, 1 = Downloads folder, 2 = custom folder (see browser.download.dir)
        "signon.rememberSignons" = true;                   # true / false — offer to save logins/passwords
        "browser.formfill.enable" = true;                  # true / false — remember form and search bar history
        #"browser.formfill.enable" = false;                # ^ source config had this disabled instead
        "privacy.trackingprotection.enabled" = true;               # true / false — tracking protection (Standard mode); reinforced by EnableTrackingProtection policy above
        "privacy.trackingprotection.socialtracking.enabled" = true; # true / false — block social media trackers
        "privacy.donottrackheader.enabled" = false;                # true / false — send the "Do Not Track" header
        "network.cookie.cookieBehavior" = 5;                       # 0 = accept all, 1 = block 3rd-party, 2 = block all,
                                                                    # 3 = block based on visited, 4 = reject trackers,
                                                                    # 5 = reject trackers + partition 3rd-party storage
        "dom.security.https_only_mode" = false;            # true / false — force HTTPS-Only Mode everywhere
        "browser.uidensity" = 0;                           # 0 = normal, 1 = compact, 2 = touch
        "toolkit.legacyUserProfileCustomizations.stylesheets" = false; # true / false — allow userChrome.css / userContent.css
        "browser.aboutConfig.showWarning" = true;          # true / false — show the warning page on about:config

        #### FEATURES ###
        "layout.spellcheckDefault" = 1;                    # 0 = off, 1 = multi-line fields, 2 = all text fields
        "widget.use-xdg-desktop-portal.file-picker" = 1;   # 0 = GTK picker, 1 = xdg-desktop-portal file picker
        "extensions.webextensions.restrictedDomains" = ""; # domains extensions can't touch; empty = none restricted (WARNING: lets adblockers run everywhere)
        "media.webrtc.camera.allow-pipewire" = true;       # true / false — allow camera capture via PipeWire
        "browser.download.always_ask_before_handling_new_types" = true; # true / false — ask what to do for unknown file types

        #### DEBLOAT ###
        "browser.discovery.enabled" = false;               # true / false — share installed add-ons with AMO for recommendations
        "app.shield.optoutstudies.enabled" = false;        # true / false — allow Mozilla "Shield" studies/experiments
        "browser.topsites.contile.enabled" = false;        # true / false — sponsored tiles on the Top Sites new-tab section
        "browser.urlbar.suggest.quicksuggest.sponsored" = false; # true / false — sponsored suggestions in the address bar
        "browser.urlbar.trending.featureGate" = false;     # true / false — trending search suggestions in the address bar
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # true / false — Pocket "recommended stories" feed
        "browser.newtabpage.activity-stream.feeds.snippets" = false;          # true / false — promotional snippets on new tab
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;         # true / false — sponsored stories on new tab (Firefox default: true)
        "browser.newtabpage.activity-stream.system.showSponsored" = false;  # true / false — system-level counterpart of the above
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # true / false — sponsored top sites (Firefox default: true)
        "browser.link.open_newwindow" = 3;                 # 1 = current window/tab, 2 = new window, 3 = new tab
        "browser.link.open_newwindow.restriction" = 0;     # 0 = apply to all cases, 1/2 = only certain script-opened windows

        #### PRIVACY ###
        "privacy.resistFingerprinting" = true;             # true / false — normalize browser fingerprint (can break some sites)
        "browser.safebrowsing.downloads.remote.enabled" = false; # true / false — send downloaded files' info to Google Safe Browsing
        "network.dns.disablePrefetch" = false;             # true / false — disable DNS prefetching
        "network.predictor.enabled" = false;               # true / false — network prediction/prefetching (see NetworkPrediction policy too)
        "network.http.speculative-parallel-limit" = 0;     # integer — speculative (preconnect) connections allowed; 0 disables it
        "browser.places.speculativeConnect.enabled" = false; # true / false — pre-connect when hovering bookmarks/history
        "privacy.globalprivacycontrol.enabled" = true;     # true / false — send the Global Privacy Control signal
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false; # true / false — clear cookies/storage on shutdown
        "privacy.fingerprintingProtection" = true;         # true / false — Firefox's fingerprinting-protection feature
        "extensions.pocket.enabled" = false;               # true / false — Pocket integration (Firefox default: true; also see DisablePocket policy above)
        "browser.search.suggest.enabled" = false;          # true / false — search engine suggestions in the address/search bar
        "browser.search.suggest.enabled.private" = false;  # true / false — same, in private browsing windows
        "browser.urlbar.suggest.searches" = false;         # true / false — search suggestions in the address bar
        "browser.privatebrowsing.forceMediaMemoryCache" = true; # true / false — keep media cache in memory only during private browsing
        "network.http.referer.XOriginTrimmingPolicy" = 2;  # 0 = full referer, 1 = scheme+host+port+path, 2 = scheme+host+port only
        "security.csp.reporting.enabled" = false;          # true / false — allow sites to receive CSP violation reports
        #"browser.contentblocking.category" = "strict";    # "standard" / "strict" / "custom" — overall content-blocking preset

        #### SECURITY ###
        "pdfjs.enableScripting" = false;                   # true / false — allow JavaScript inside the built-in PDF viewer
        #"signon.autofillForms" = false;                   # true / false — autofill saved logins into forms
        "signon.formlessCapture.enabled" = false;          # true / false — capture logins from forms with no <form> tag
        "dom.disable_window_move_resize" = true;           # true / false — stop scripts from moving/resizing the window
        "devtools.debugger.remote-enabled" = false;        # true / false — allow remote debugging
        "extensions.enabledScopes" = 5;                    # bitmask of locations extensions may be loaded from

        #### SSL ###
        "security.ssl.require_safe_negotiation" = true;     # true / false — require RFC 5746 safe TLS renegotiation
        "security.tls.enable_0rtt_data" = 2;                 # 0/1/2 — TLS 1.3 0-RTT handling (2 = disabled)
        "security.cert_pinning.enforcement_level" = 2;       # 0 = disabled, 1 = enforce (allow user MITM), 2 = strict
        "security.pki.crlite_mode" = 2;                      # 0 = disabled, 1 = telemetry only, 2 = enforce revocations
        "security.ssl.treat_unsafe_negotiation_as_broken" = true; # true / false
        "browser.xul.error_pages.expert_bad_cert" = true;    # true / false — show extra detail on the cert-error page
      };
    };
  };
}
