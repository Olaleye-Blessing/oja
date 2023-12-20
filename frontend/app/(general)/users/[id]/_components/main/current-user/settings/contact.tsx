import Container from "../container";
import Form from "./form";
import Input from "./input";

const Contact = () => {
  return (
    <Container className="cardboard" title="Contact">
      <Form id="contact">
        <Input
          label="Website"
          name="website"
          placeholder="https://www.blessingolaleye.xyz"
          type="url"
        />
        <Input
          label="Phone number"
          name="phone_number"
          placeholder="+234 703 528 7586"
          type="tel"
        />
      </Form>
    </Container>
  );
};

export default Contact;
