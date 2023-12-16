"use client";

import { useAuthStore } from "@/store/useAuth";
import { useStore } from "@/store/useStore";
import { useParams } from "next/navigation";
import React from "react";
import Settings from "./settings";
import WatchedProducts from "./watched-products";

const CurrentUserContents = () => {
  const user = useStore(useAuthStore, (state) => state.user);
  const params = useParams<{ id: string }>();

  if (user?.id !== +params.id) return null;

  return (
    <>
      <WatchedProducts />
      <Settings />
    </>
  );
};

export default CurrentUserContents;
