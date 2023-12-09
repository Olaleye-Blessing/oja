import { Metadata } from "next";
import {
  HydrationBoundary,
  QueryClient,
  dehydrate,
} from "@tanstack/react-query";
import Filter from "./_components/filter";
import { ProductsFilter } from "./_components/types";
import { getProducts } from "./_components/utils";
import Products from "./_components/products";
import { useOjaDB } from "@/hooks/useOjaDB";

// TODO: Improve metadata
export const metadata: Metadata = {
  title: "Oja - Products",
  description: "A better description is coming",
};

interface PageProps {
  searchParams: ProductsFilter;
}

export default async function Page({ searchParams }: PageProps) {
  const queryClient = new QueryClient();
  const { ojaInstance } = useOjaDB();

  await queryClient.prefetchQuery({
    queryKey: ["products"],
    queryFn: () => getProducts(ojaInstance, searchParams),
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <main className="px-4 md:flex md:items-start">
        <Filter />
        <Products />
      </main>
    </HydrationBoundary>
  );
}
