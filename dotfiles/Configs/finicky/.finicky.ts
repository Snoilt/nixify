import type {FinickyConfig} from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

const DEFAULT_BROWSER = "/Applications/Zen.app";
const WORK_BROWSER = "/Applications/Microsoft Edge.app";

const anyHostEndsWith = (url: URL, hosts: string[]) => {
  return hosts.some((host) => url.hostname.endsWith(host));
};

const isWorkMachine = () => {
  return finicky.getSystemInfo().localizedName.startsWith("T");
};

export default {
  defaultBrowser: DEFAULT_BROWSER,

  rewrite: [
    {
      match: (url) => {
        return anyHostEndsWith(url, [
          "teams.cdn.office.net",
          "protection.outlook.com",
        ]);
      },
      url: (url) => {
        const targetUrl = url.searchParams.get("url");

        if (targetUrl) {
          return new URL(decodeURIComponent(targetUrl));
        }

        return url;
      },
    },
  ],
  handlers: [
    {
      match: finicky.matchHostnames("open.spotify.com"),
      browser: "Spotify",
    },
    {
      match: (url) => {
        return anyHostEndsWith(url, ["devops.telekom.de"]);
      },
      browser: DEFAULT_BROWSER,
    },
    {
      match: (url) => {
        return (
          isWorkMachine() &&
          anyHostEndsWith(url, [
            "telekom.de",
            "telekom.com",
            "t-systems-ifs.com",
            "office.net",
            "sharepoint.de",
            "sharepoint.com",
          ])
        );
      },
      browser: WORK_BROWSER,
    },
  ],
} satisfies FinickyConfig;
