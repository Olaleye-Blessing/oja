import { forwardRef } from "react";
import { Splide } from "@splidejs/react-splide";
import { Options } from "@splidejs/splide";

interface GlassProps {
  generateImages: () => JSX.Element[];
}

const mainOptions: Options = {
  type: "loop",
  perPage: 1,
  perMove: 1,
  gap: "1rem",
  pagination: false,
};

const Glass = forwardRef<any, GlassProps>(({ generateImages }, ref) => {
  return (
    <Splide
      options={mainOptions}
      ref={ref}
      aria-labelledby="thumbnail-slider-example"
      className="mt-4 cardboard p-5"
    >
      {generateImages()}
    </Splide>
  );
});

Glass.displayName = "Glass";

export default Glass;
