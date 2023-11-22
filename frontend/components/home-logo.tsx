import Link from "next/link";
import React from "react";

interface IHomeLogo {
  className?: string;
}

const HomeLogo = ({ className }: IHomeLogo) => {
  return (
    <Link href="/" className={`${className}`}>
      Oja
    </Link>
  );
};

export default HomeLogo;
