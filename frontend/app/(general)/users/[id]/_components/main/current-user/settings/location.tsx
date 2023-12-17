import { Label } from "@/components/ui/label";
import Container from "../container";
import { Input } from "@/components/ui/input";
import Form from "./form";

const Location = () => {
  return (
    <Container className="cardboard" title="Location">
      <Form id="location">
        <div className="mb-4">
          <Label htmlFor="country">Country</Label>
          <Input
            id="country"
            name="country"
            placeholder="Nigeria"
            type="text"
          />
        </div>
        <div className="mb-4">
          <Label htmlFor="state">State</Label>
          <Input id="state" name="state" placeholder="Lagos" type="text" />
        </div>
        <div className="mb-4">
          <Label htmlFor="city">City</Label>
          <Input id="city" name="city" placeholder="Lagos" type="text" />
        </div>
      </Form>
    </Container>
  );
};

export default Location;
