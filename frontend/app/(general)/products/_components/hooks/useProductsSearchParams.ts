import { useSearchParams } from "next/navigation";

export const useProductsSearchParams = () => {
  const search = useSearchParams();

  const filter = {
    name: search.get("name"),
    category: search.get("category"),
    condition: search.get("condition"),
    price_from: search.get("price_from"),
    price_to: search.get("price_to"),
  };

  const filterParams = (formData: FormData) => {
    let values = Object.fromEntries(formData.entries()) as any;

    // remove any empty or all values
    Object.keys(values).forEach((key) => {
      if (values[key] === "" || values[key] === "all") {
        delete values[key];
      }
    });

    if (values.category === "0") delete values.category;

    return `?${new URLSearchParams(values).toString()}`;
  };

  return { filter, filterParams };
};
