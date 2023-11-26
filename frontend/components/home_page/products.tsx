import { IProduct } from "@/interfaces/product";
import Image from "next/image";
import Link from "next/link";
import React from "react";
import { Button } from "../ui/button";
import toast from "react-hot-toast";
import { ShoppingCart } from "lucide-react";

interface ProductsProps {
  products: IProduct[];
}

const Products = ({ products }: ProductsProps) => {
  return (
    <ul className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
      {products.map((product) => {
        return (
          <li key={product.id}>
            <Link
              href={`/products/${product.id}`}
              className="h-full flex flex-col rounded-md cardboard"
            >
              <figure className="bg-blue-500 flex items-center justify-center overflow-hidden mb-3 rounded-md rounded-b-none">
                <Image
                  className="w-full h-[20rem] object-cover rounded-md"
                  src={product.image}
                  alt={product.name}
                  width={200}
                  height={200}
                />
              </figure>
              <div className="flex flex-col p-2 flex-grow">
                <p className="font-semibold">{product.name}</p>
                <p className="line-clamp-3 mb-8">{product.description}</p>
                <div className="flex items-center justify-between mt-auto">
                  <div className="flex items-center justify-between flex-wrap w-full">
                    <p className="flex items-center justify-center">
                      <span className="text-2xl">$</span>
                      <span>{product.price}</span>
                    </p>
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
                  <Button
                    variant={"outline"}
                    size={"icon"}
                    type="button"
                    className="p-0 text-primary ml-4"
                    onClick={(e) => {
                      e.stopPropagation();
                      e.preventDefault();

                      toast.success("Added to cart");
                    }}
                  >
                    <ShoppingCart size={20} />
                  </Button>
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
