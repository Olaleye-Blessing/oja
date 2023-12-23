interface ListItemProps {
  value: string;
  label: string;
}

const ListItem = ({ value, label }: ListItemProps) => {
  return (
    <li className="inline-flex items-center justify-start">
      <span className="mr-1 font-semibold">{value}</span>
      <span>{label}</span>
    </li>
  );
};

export default ListItem;
