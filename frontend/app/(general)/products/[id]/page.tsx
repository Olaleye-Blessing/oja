"use client";

import React from "react";
import { useOjaQuery } from "@/hooks/useOjaQuery";
import { PageProps } from "@/interfaces/page";
import { ProductKey } from "./_utils/query-key";
import Loading from "../../loading";
import { IFullProduct } from "@/interfaces/product";
import Product from "./_components/product";

const Page = ({ params: { id } }: Pick<PageProps, "params">) => {
  const { data, isFetching, error } = useOjaQuery<IFullProduct>({
    url: `/products/${id}`,
    options: {
      queryKey: ProductKey.base(id),
    },
  });

  return (
    <main className="px-4">
      {isFetching ? (
        <Loading />
      ) : error ? (
        <p className=" text-red-700 text-sm text-center">{error}</p>
      ) : (
        <Product product={data!} />
      )}
    </main>
  );
};

export default Page;
