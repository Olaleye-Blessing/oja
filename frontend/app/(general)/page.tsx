"use client";

import { useOjaQuery } from "@/hooks/useOjaQuery";
import { IProduct } from "@/interfaces/product";
import { API_URL } from "@/utils/constant";
import Loading from "./loading";
import Filter from "@/components/home_page/filter";
import Products from "@/components/home_page/products";

export default function Home() {
  const { data, isLoading, error } = useOjaQuery<IProduct[]>({
    url: `${API_URL}/products`,
    options: {
      queryKey: ["products"],
    },
  });

  return (
    <main className="px-4">
      <Filter />
      <div>
        {isLoading ? (
          <Loading />
        ) : error ? (
          <div>error</div>
        ) : (
          <Products products={data!} />
        )}
      </div>
    </main>
  );
}
