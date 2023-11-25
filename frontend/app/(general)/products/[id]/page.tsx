import React from "react";

interface PageProps {
  params: { id: string };
  searchParams: {};
}

const Page = ({ params }: PageProps) => {
  return (
    <main>
      <h1 className="text-7xl">Product ID: {params.id}</h1>
      <p className="text-lg">full detail</p>
    </main>
  );
};

export default Page;
