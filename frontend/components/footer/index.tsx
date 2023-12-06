import React from "react";

const Footer = () => {
  return (
    <footer className="mt-auto text-center px-4 py-2">
      <p>© {new Date().getFullYear()} Oja, Inc. All rights reserved.</p>
      <p className="mt-0.5">
        Built by{" "}
        <a
          href="http://https://github.com/Olaleye-Blessing"
          target="_blank"
          rel="noopener noreferrer"
          className="text-primary font-semibold border-b border-primary"
        >
          Blessing Olaleye
        </a>
      </p>
    </footer>
  );
};

export default Footer;
