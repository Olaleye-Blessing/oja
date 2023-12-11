import { InputProps } from "@/components/ui/input";
import { IFullProduct } from "@/interfaces/product";

export interface Field extends Omit<InputProps, "name"> {
  label: string;
  name: keyof Omit<IFullProduct, "id" | "created_at" | "updated_at">;
}

export const fields: Field[] = [
  {
    label: "Name",
    name: "name",
    type: "text",
    placeholder: "Red shoe",
    required: true,
    // 3 character minimum
    pattern: "^.{3,}$",
  },
  {
    label: "Description",
    name: "description",
    type: "text",
    placeholder: "My new shoe",
  },
  {
    label: "Price($)",
    name: "price",
    type: "number",
    placeholder: "23",
    required: true,
    min: 0.1,
    step: 0.1,
  },
  {
    label: "Quantity",
    name: "stock_quantity",
    type: "number",
    placeholder: "3",
    required: true,
    min: 1,
  },
  {
    label: "Category",
    name: "category",
    type: "text",
    placeholder: "Shoes",
    required: true,
  },
  {
    label: "Condition",
    name: "condition",
    type: "text",
    placeholder: "new or used",
    required: true,
  },
  {
    label: "Image",
    name: "image",
    type: "file",
    accept: "image/*",
    multiple: true,
  },
];
