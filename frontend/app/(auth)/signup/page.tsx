import HomeLogo from "@/components/home-logo";

import React from "react";
import Form from "./_components/form";

const Page = () => {
  return (
    <main>
      <header className="my-8">
        <p className="flex items-center justify-center text-center">
          <HomeLogo className=" text-3xl text-primary font-bold" />
        </p>
      </header>

      <Form />
    </main>
  );
};

export default Page;
