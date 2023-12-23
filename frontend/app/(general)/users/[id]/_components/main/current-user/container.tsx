import { cn } from "@/lib/utils";
import { PropsWithChildren } from "react";

interface ContainerProps extends PropsWithChildren {
  title: string;
  className?: string;
}

const Container = ({ title, className, children }: ContainerProps) => {
  return (
    <section className={cn(["cardboard px-4 py-2", className])}>
      <header className="mb-4">
        <h2 className="text-3xl">{title}</h2>
      </header>
      {children}
    </section>
  );
};

export default Container;
