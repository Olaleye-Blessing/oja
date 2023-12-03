import "./index.css";

interface CartInputProps {
  stock_quantity: number;
  quantity: number;
  handleSetQuantity: (props: { quantity: number; replace?: boolean }) => void;
}

const CartInput = ({
  stock_quantity,
  quantity,
  handleSetQuantity,
}: CartInputProps) => {
  return (
    <div className="flex items-center justify-center rounded-md border border-input bg-background p-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-1">
      <button
        className="flex items-center justify-center text-center p-3 text-red-800 rounded-full w-2 h-2 mr-0.5"
        type="button"
        onClick={() => handleSetQuantity({ quantity: -1 })}
      >
        -
      </button>
      <input
        type="number"
        min={1}
        max={stock_quantity}
        step={1}
        className="flex h-full ring-offset-background placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50 text-center"
        value={quantity}
        onChange={(e) =>
          handleSetQuantity({ quantity: +e.target.value, replace: true })
        }
      />
      <button
        className="flex items-center justify-center text-center p-3 text-green-800 rounded-full w-2 h-2 ml-0.5"
        type="button"
        onClick={() => handleSetQuantity({ quantity: 1 })}
      >
        +
      </button>
    </div>
  );
};

export default CartInput;
