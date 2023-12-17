import { Label } from "@/components/ui/label";
import Container from "../container";
import { Input } from "@/components/ui/input";
import Form from "./form";

const Contact = () => {
  return (
    <Container className="cardboard" title="Contact">
      <Form id="contact">
        <div className="mb-4">
          <Label htmlFor="website">Website</Label>
          <Input
            id="website"
            name="website"
            placeholder="https://www.blessingolaleye.xyz"
            type="url"
          />
        </div>
        <div className="mb-4">
          <Label htmlFor="phone_number">Phone number</Label>
          <Input
            id="phone_number"
            name="phone_number"
            placeholder="+234 703 528 7586"
            type="number"
          />
        </div>
      </Form>
    </Container>
  );
};

export default Contact;
