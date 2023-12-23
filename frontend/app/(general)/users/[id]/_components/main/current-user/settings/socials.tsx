import Container from "../container";
import Form from "./form";
import Input from "./input";

const Socials = () => {
  return (
    <Container className="cardboard" title="Socials">
      <Form id="socials">
        <Input
          label="Tiktok"
          name="tiktok"
          placeholder="https://www.tiktok.com/@_jongbo"
          type="url"
        />
        <Input
          label="Twitter"
          name="twitter"
          placeholder="https://twitter.com/_jongbo"
          type="url"
        />
        <Input
          label="Instagram"
          name="instagram"
          placeholder="https://www.instagram.com/__jongbo"
          type="url"
        />
      </Form>
    </Container>
  );
};

export default Socials;
