import { createRef, useEffect } from "react";
import Image from "next/image";
import { SplideSlide } from "@splidejs/react-splide";
import "@splidejs/splide/dist/css/splide.min.css";
import { ImagesProps } from "./types";
import Thumbnails from "./thumbnails";
import Glass from "./glass";

const Images = ({ images }: ImagesProps) => {
  const mainRef = createRef<any>();
  const thumbnailsRef = createRef<any>();

  useEffect(() => {
    if (
      mainRef.current &&
      thumbnailsRef.current &&
      thumbnailsRef.current.splide
    ) {
      mainRef.current.sync(thumbnailsRef.current.splide);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const generateImages = () =>
    images.map((image, index) => {
      return (
        <SplideSlide key={image} className="flex items-center justify-center">
          <figure className="overflow-hidden max-h-[25rem] flex items-center justify-center w-full bg-orange-900">
            <Image
              src={image}
              alt={`Product image ${index + 1}`}
              className="rounded-md overflow-hidden w-full h-fu"
              width={150}
              height={100}
            />
          </figure>
        </SplideSlide>
      );
    });

  return (
    <section>
      <Thumbnails generateImages={generateImages} ref={thumbnailsRef} />

      <Glass ref={mainRef} generateImages={generateImages} />
    </section>
  );
};

export default Images;
