"use client";

import { FormEvent, useRef } from "react";
import { useRouter } from "next/navigation";
import { ChevronRight } from "lucide-react";
import { Label } from "../ui/label";
import { Input } from "../ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "../ui/select";
import { Button } from "../ui/button";
import "./index.css";
import { useFilterParams } from "./hooks/useFilterParams";
import Categories from "../categories";

const Filter = () => {
  const router = useRouter();
  const formRef = useRef<HTMLFormElement>(null);
  const { filterParams, filter } = useFilterParams();

  const handleSearch = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    router.push(`/${filterParams(new FormData(e.currentTarget))}`);
  };

  const toggleFilter = () => {
    const form = formRef.current;

    if (!form) return;

    form.classList.toggle("close");
  };

  return (
    <form
      data-filter="form"
      className="mb-4 close md:basis-64 md:flex-shrink-0 md:sticky md:left-0 md:top-[4.5rem] md:mr-4"
      onSubmit={handleSearch}
      id="search-products"
      ref={formRef}
    >
      <header className="flex items-center justify-between mb-1 md:hidden">
        <h2>Filter</h2>
        <button
          data-filter="form_toggle"
          type="button"
          onClick={() => toggleFilter()}
        >
          <ChevronRight size={16} />
        </button>
      </header>
      <div data-filter="form_body" className="close">
        <div>
          <div className="mb-4">
            <Label htmlFor="name">Name</Label>
            <Input
              type="text"
              id="name"
              name="name"
              placeholder="Guitar"
              defaultValue={filter.name || ""}
            />
          </div>
          <div className="mb-4" key="condition">
            <Label htmlFor="condition">Condition</Label>
            <Select
              required
              name="condition"
              defaultValue={filter.condition || "all"}
            >
              <SelectTrigger className="w-full">
                <SelectValue placeholder="" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">All</SelectItem>
                <SelectItem value="new">New</SelectItem>
                <SelectItem value="used">Used</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="mb-4">
            <Label htmlFor="categories">Categories</Label>
            <Categories
              name="category"
              includeAll
              defaultValue={filter.category || "0"}
            />
          </div>
          <div>
            <Label htmlFor="price">Price($)</Label>
            <div className="flex items-center justify-start">
              <Input
                type="number"
                id="price"
                name="price_from"
                placeholder="Min"
                className=""
                defaultValue={filter.price_from || ""}
              />
              <span className="mx-3 text-lg font-extrabold">-</span>
              <Input
                type="number"
                id="price"
                name="price_to"
                placeholder="Max"
                className=""
                defaultValue={filter.price_to || ""}
              />
            </div>
          </div>

          <div>
            <Button className="w-full mt-6" type="submit">
              Search
            </Button>
          </div>
        </div>
      </div>
    </form>
  );
};

export default Filter;
