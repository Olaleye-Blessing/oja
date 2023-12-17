import Container from "../container";
import Form from "./form";
import Input from "./input";

const Location = () => {
  return (
    <Container className="cardboard" title="Location">
      <Form id="location">
        <Input
          label="Country"
          name="country"
          placeholder="Nigeria"
          type="text"
        />
        <Input label="State" name="state" placeholder="Lagos" type="text" />
        <Input label="City" name="city" placeholder="Lagos" type="text" />
      </Form>
    </Container>
  );
};

export default Location;
