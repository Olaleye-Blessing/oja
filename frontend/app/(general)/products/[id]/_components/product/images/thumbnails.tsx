import { forwardRef } from "react";
import { Splide } from "@splidejs/react-splide";
import { Options } from "@splidejs/splide";

interface ThumbnailsProps {
  generateImages: () => JSX.Element[];
}

const thumbsOptions: Options = {
  type: "slide",
  rewind: true,
  gap: "1rem",
  pagination: false,
  fixedWidth: 100,
  fixedHeight: 70,
  cover: true,
  focus: "center",
  isNavigation: true,
};

const Thumbnails = forwardRef<any, ThumbnailsProps>(
  ({ generateImages }, ref) => {
    return (
      <Splide
        options={thumbsOptions}
        ref={ref}
        aria-label="The carousel with thumbnails. Selecting a thumbnail will change the main carousel"
        className="cardboard"
      >
        {generateImages()}
      </Splide>
    );
  },
);

Thumbnails.displayName = "Thumbnails";

export default Thumbnails;
