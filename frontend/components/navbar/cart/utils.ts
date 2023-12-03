import { CheckoutData } from "./hook";

interface Field {
  name: keyof CheckoutData["shipping_address"];
  type: string;
  required?: boolean;
  label?: string;
  disabled?: boolean;
}

export const fields: Field[] = [
  {
    name: "full_name",
    type: "text",
    required: true,
    label: "Full Name",
  },
  {
    name: "email",
    type: "email",
    disabled: true,
  },
  {
    name: "address",
    type: "text",
    required: true,
  },
  {
    name: "city",
    type: "text",
    required: true,
  },
  {
    name: "state",
    type: "text",
    required: true,
  },
  {
    name: "country",
    type: "text",
    required: true,
  },
  {
    name: "zip_code",
    type: "text",
    label: "Zip Code",
  },
];
