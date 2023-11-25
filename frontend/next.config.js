/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    //   TODO: Update this when backend allows image upload
    remotePatterns: [
      {
        protocol: "https",
        hostname: "**",
      },
    ],
  },
};

module.exports = nextConfig;
