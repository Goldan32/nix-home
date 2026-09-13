{ config, pkgs, ... }:

let
  # Check about:support for extension/add-on ID strings.
  extensions = [
    "uBlock0@raymondhill.net"                   # uBlock Origin
    "sponsorBlocker@ajay.app"                   # SponsorBlock
    "jid1-KKzOGWgsW3Ao4Q@jetpack"               # I don't care about cookies
  ];
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    # Check about:policies#documentation for options.
    policies = {

        #### DEBLOAT ###
        DisableFirefoxStudies = true;
        #DisableFirefoxScreenshots = true;
        DontCheckDefaultBrowser = true;
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
        DisablePocket = true;
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

      ExtensionSettings = builtins.listToAttrs (builtins.map (id: {
        name = id;
        value = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
          installation_mode = "force_installed";
        };
      }) extensions);
    };

    preferences = {

        #### FEATURES ###
        "layout.spellcheckDefault" = 1;
        # Use the systems native filechooser portal
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        # allow adblockers to act everywhere. WARNING this is a security hole.
        "extensions.webextensions.restrictedDomains" = "";
        "media.webrtc.camera.allow-pipewire" = true;
        "browser.download.always_ask_before_handling_new_types" = true;


        #### DEBLOAT ###
        "browser.discovery.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # Privacy: Disable automatic opening in new windows (manually still works)
        # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/9881
        "browser.link.open_newwindow" = 3;
        # Privacy: Set all window open modes to abide above method
        "browser.link.open_newwindow.restriction"= 0;

        #### PRIVACY ###
        "privacy.resistFingerprinting" = "true";
        # disable sending downloaded files to the internet
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "network.dns.disablePrefetch" = false;
        # redundancy: disable network prefetching
        "network.predictor.enabled" = false;
        # disable preloading websites when hovering over links
        "network.http.speculative-parallel-limit" = 0;
        # disable connecting to bookmarks when hovering over them
        "browser.places.speculativeConnect.enabled" = "false";
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.fingerprintingProtection" = true;

        #"browser.contentblocking.category" = "strict";
        "extensions.pocket.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.urlbar.suggest.searches" = false;
        # store media in cache only on private browsing
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        # Privacy: Disable CSP reporting
        # https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
        "security.csp.reporting.enabled" = false;

        #### SECURITY ###
        #"browser.formfill.enable" = false;
        "pdfjs.enableScripting" = false;
        #"signon.autofillForms" = false
        # UNCLEAR
        "signon.formlessCapture.enabled" = false;
        # prevent scripts from moving or resizing windows
        "dom.disable_window_move_resize" = true;
        # Security: Disable remote debugging feature
        # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222
        "devtools.debugger.remote-enabled" = false;
        # Security: Restrict directories from which extensions can be loaded (Unclear)
        # https://archive.is/DYjAM
        "extensions.enabledScopes" = 5;

        #### SSL ###
        # Security: Require safe SSL negotiation to avoid potentially MITMed sites
        "security.ssl.require_safe_negotiation" = true;
        # Security: Disable TLS1.3 0-RTT as key encryption may not be forward secret
        # https://github.com/tlswg/tls13-spec/issues/1001
        "security.tls.enable_0rtt_data" = 2;
        # Security: Enable strict public key pinning, prevents some MITM attacks
        "security.cert_pinning.enforcement_level" = 2;
        # Security: Enable CRLite to ensure that revoked certificates are detected
        "security.pki.crlite_mode" = 2;
        # Security: Treat unsafe negotiation as broken
        # https://wiki.mozilla.org/Security:Renegotiation
        # https://bugzilla.mozilla.org/1353705
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        #  Security: Display more information on Insecure Connection warning pages
        # Test: https://badssl.com
        "browser.xul.error_pages.expert_bad_cert" = true;
        };
    };
}
