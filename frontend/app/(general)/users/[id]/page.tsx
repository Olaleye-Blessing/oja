import { PageProps } from "@/interfaces/page";
import React from "react";

const Page = ({ params: { id } }: PageProps) => {
  return <main>User page: {id}</main>;
};

export default Page;
