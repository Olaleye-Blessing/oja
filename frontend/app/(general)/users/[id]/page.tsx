import { PageProps } from "@/interfaces/page";
import React from "react";
import Header from "./_components/header";
import Main from "./_components/main";
import { useOjaDB } from "@/hooks/useOjaDB";
import { getUser } from "./_utils";
import { IProfile } from "@/interfaces/profile";

export type UserPageProps = PageProps<{
  tab?: string;
}>;

const Page = async ({ params: { id }, searchParams }: UserPageProps) => {
  const { ojaInstance } = useOjaDB();

  let user: IProfile | undefined, error: string | undefined;

  try {
    user = await getUser(ojaInstance, id);
  } catch (e) {
    error = e as string;
  }

  return (
    <div className="px-4">
      {user ? (
        <>
          <Header user={user} />
          <Main user={user} searchParams={searchParams} />
        </>
      ) : (
        <p className="text-center text-red-800">{error}</p>
      )}
    </div>
  );
};

export default Page;
