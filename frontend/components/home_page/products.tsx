import { IProduct } from "@/interfaces/product";
import Image from "next/image";
import Link from "next/link";
import React from "react";

interface ProductsProps {
  products: IProduct[];
}

const Products = ({ products }: ProductsProps) => {
  return (
    <ul className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
      {products.map((product) => {
        return (
          <li key={product.id}>
            <Link href={`/products/${product.id}`}>
              <figure className="bg-blue-500 flex items-center justify-center overflow-hidden mb-3 rounded-md">
                <Image
                  className="w-full h-[20rem] object-cover rounded-md"
                  src={product.image}
                  alt={product.name}
                  width={200}
                  height={200}
                />
              </figure>
              <p className="font-semibold">{product.name}</p>
              <p className="line-clamp-3 mb-2">{product.description}</p>
              <div className="flex items-center justify-between">
                <p className="flex items-center justify-center">
                  <span className="text-2xl">$</span>
                  <span>{product.price}</span>
                </p>
                <div>
                  <p
                    className={`text-sm px-3 pt-[0.125rem] pb-[0.18rem] mb-1 rounded-md bg-black bg-opacity-90 ${
                      product.condition === "new"
                        ? "text-green-500"
                        : "text-red-300"
                    }`}
                  >
                    {product.condition}
                  </p>
                  <p>
                    <span
                      className={`font-semibold ${
                        product.stock_quantity < 4 ? " text-red-600" : ""
                      }`}
                    >
                      {product.stock_quantity}
                    </span>{" "}
                    <span>left</span>
                  </p>
                </div>
              </div>
            </Link>
          </li>
        );
      })}
    </ul>
  );
};

export default Products;
