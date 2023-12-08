"use client";
import { useRouter } from "next/navigation";
import { useProductsSearchParams } from "@/app/(general)/products/_components/hooks/useProductsSearchParams";
import { Input } from "../ui/input";
import { FormEvent } from "react";

const Search = () => {
  const router = useRouter();
  const { filterParams } = useProductsSearchParams();

  return (
    <form
      aria-label="Search for products"
      role="search"
      onSubmit={(e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        router.push(`/products/${filterParams(new FormData(e.currentTarget))}`);
      }}
    >
      <Input name="name" placeholder="Search" type="search" />
    </form>
  );
};

export default Search;
