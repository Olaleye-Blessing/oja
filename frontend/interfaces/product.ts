import { UserType } from "@/store/useAuth";

export interface IProduct {
  id: number;
  name: string;
  price: number;
  description: string;
  stock_quantity: number;
  category_id: number;
  condition: string;
  created_at: string;
  updated_at: string;
  watchers: number;
  images: string[];
}

export interface IFullProduct extends Omit<IProduct, "watchers"> {
  user: UserType;
  category: {
    id: number;
    name: string;
    inserted_at: string;
    updated_at: string;
  };
  watchers: UserType[];
}
