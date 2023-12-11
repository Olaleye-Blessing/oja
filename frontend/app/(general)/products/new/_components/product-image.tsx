import { FormEvent } from "react";
import Image from "next/image";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Field } from "../_utils/fields";

export interface ProductImageType {
  id: string;
  previewUrl: string;
  file: File;
}

interface ProductImageProps {
  images: ProductImageType[];
  field: Omit<Field, "label">;
  label: string;
  handleImageChange: (e: FormEvent<HTMLInputElement>) => Promise<void>;
  handleRemoveImage: (id: string) => void;
}

const ProductImage = ({
  field,
  label,
  images,
  handleImageChange,
  handleRemoveImage,
}: ProductImageProps) => {
  return (
    <div className="mb-4">
      <Label htmlFor={field.name}>{label}</Label>
      <Input {...field} onChange={handleImageChange} />
      {images.length > 0 && (
        <output className="block mt-5">
          <ul className="grid gap-x-2 gap-y-5 grid-cols-2">
            {images.map(({ id, previewUrl }) => (
              <li
                key={id}
                className="flex items-center justify-center relative cardboard p-0 shadow"
              >
                <button
                  type="button"
                  onClick={() => handleRemoveImage(id)}
                  className=" absolute -top-2 -right-2 bg-red-900 text-white text-sm flex items-center justify-center text-center font-semibold rounded-full w-6 h-6"
                >
                  X
                </button>
                <figure className="flex items-center justify-center h-full w-full">
                  <Image
                    src={previewUrl}
                    alt="Product"
                    className="rounded-md"
                    width={400}
                    height={400}
                  />
                </figure>
              </li>
            ))}
          </ul>
        </output>
      )}
    </div>
  );
};

export default ProductImage;
