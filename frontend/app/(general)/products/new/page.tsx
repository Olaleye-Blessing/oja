"use client";

import Protected from "@/components/protected";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { fields } from "./_utils/fields";
import Categories from "@/components/categories";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useProductForm } from "./_utils/hook";

const Page = () => {
  const { submitting, handleCreateProduct } = useProductForm();

  return (
    <Protected>
      <div className="px-4">
        <header>
          <h1 className="text-center text-3xl mb-4">List a product</h1>
        </header>
        <main>
          <form
            onSubmit={handleCreateProduct}
            className="cardboard w-full max-w-2xl mx-auto rounded-md p-4"
          >
            {fields.map(({ label, ...field }) => {
              if (field.name === "category")
                return (
                  <div className="mb-4" key="categories">
                    <Label htmlFor="categories">Categories</Label>
                    <Categories name="category" />
                  </div>
                );

              if (field.name === "description")
                return (
                  <div className="mb-4" key="description">
                    <Label htmlFor="description">Description</Label>
                    <Textarea
                      name="description"
                      placeholder="Give a brief description of the product"
                    />
                  </div>
                );

              if (field.name === "condition") {
                return (
                  <div className="mb-4" key="condition">
                    <Label htmlFor="condition">Condition</Label>
                    <Select required name="condition" defaultValue="new">
                      <SelectTrigger className="w-full">
                        <SelectValue placeholder="" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="new">New</SelectItem>
                        <SelectItem value="used">Used</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                );
              }

              return (
                <div key={field.name} className="mb-4">
                  <Label htmlFor={field.name}>{label}</Label>
                  <Input {...field} />
                </div>
              );
            })}
            <Button
              className="w-full mx-auto mt-6"
              type="submit"
              loading={submitting}
              aria-disabled={submitting}
            >
              Create market
            </Button>
          </form>
        </main>
      </div>
    </Protected>
  );
};

export default Page;
