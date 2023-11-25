import { Loader2 } from "lucide-react";

const Loading = () => {
  return (
    <div className="flex flex-col items-center justify-center space-y-2">
      <Loader2 size={24} className="animate-spin text-primary" />
      <p>Loading...</p>
    </div>
  );
};

export default Loading;
