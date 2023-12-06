import { getProducts } from "@/components/home_page/utils";
import {
  HydrationBoundary,
  QueryClient,
  dehydrate,
} from "@tanstack/react-query";
import Filter from "@/components/home_page/filter";
import Products from "@/components/home_page/products";
import { Metadata } from "next";
import { ProductsFilter } from "@/components/home_page/types";

// TODO: Improve metadata
export const metadata: Metadata = {
  title: "Oja - Products",
  description: "A better description is coming",
};

interface HomeProps {
  searchParams: ProductsFilter;
}

export default async function Home({ searchParams }: HomeProps) {
  const queryClient = new QueryClient();

  await queryClient.prefetchQuery({
    queryKey: ["products"],
    queryFn: () => getProducts(searchParams),
  });

  return (
    <HydrationBoundary state={dehydrate(queryClient)}>
      <main className="px-4">
        <Filter />
        <Products />
      </main>
    </HydrationBoundary>
  );
}
