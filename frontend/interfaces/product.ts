export interface IProduct {
  id: number;
  name: string;
  price: number;
  description: string;
  stock_quantity: number;
  category_id: number;
  category: {
    id: number;
    name: string;
    inserted_at: string;
    updated_at: string;
  };
  condition: string;
  image: string;
  created_at: string;
  updated_at: string;
}
