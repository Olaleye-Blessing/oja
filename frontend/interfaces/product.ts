import { UserType } from "@/store/useAuth";

export interface IProduct {
  id: number;
  name: string;
  price: number;
  description: string;
  stock_quantity: number;
  category_id: number;
  condition: string;
  image: string;
  created_at: string;
  updated_at: string;
  watchers: number;
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
