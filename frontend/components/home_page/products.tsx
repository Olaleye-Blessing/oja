"use client";

import { IProduct } from "@/interfaces/product";
import { getProducts } from "./utils";
import { useOjaQuery } from "@/hooks/useOjaQuery";
import { API_URL } from "@/utils/constant";
import Loading from "@/app/(general)/loading";
import Product from "./product";
import { useFilterParams } from "./hooks/useFilterParams";

const Products = () => {
  const { filter } = useFilterParams();
  const {
    data: products,
    isFetching,
    error,
  } = useOjaQuery<IProduct[]>({
    url: `${API_URL}/products`,
    options: {
      queryKey: ["products"],
      queryFn: () => getProducts(filter),
    },
  });

  return (
    <>
      {isFetching ? (
        <Loading />
      ) : error ? (
        <div>{error}</div>
      ) : products ? (
        <>
          {products.length === 0 ? (
            <p>No products available</p>
          ) : (
            <ul className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
              {products.map((product) => {
                return <Product key={product.id} product={product} />;
              })}
            </ul>
          )}
        </>
      ) : null}
    </>
  );
};

export default Products;
