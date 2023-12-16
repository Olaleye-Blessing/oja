"use client";

import Product from "@/app/(general)/products/_components/product";
import { IProduct } from "@/interfaces/product";

const ShopProduct = (product: IProduct) => {
  return <Product product={product} />;
};

export default ShopProduct;
