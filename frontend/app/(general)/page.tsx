import { getProducts } from "@/components/home_page/utils";
import {
  HydrationBoundary,
  QueryClient,
  dehydrate,
} from "@tanstack/react-query";
import Filter from "@/components/home_page/filter";
import Products from "@/components/home_page/products";
import { Metadata } from "next";

// TODO: Improve metadata
export const metadata: Metadata = {
  title: "Oja - Products",
  description: "A better description is coming",
};

export default async function Home() {
  const queryClient = new QueryClient();

  await queryClient.prefetchQuery({
    queryKey: ["products"],
    queryFn: getProducts,
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
