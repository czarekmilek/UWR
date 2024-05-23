import React from "react";

interface InputFieldProps {
  label: string;
  type: string;
  value: string | number;
  onChange: (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => void;
  error?: string;
  options?: { id: string; name: string }[];
  step?: string;
  min?: number;
}

const InputField: React.FC<InputFieldProps> = ({
  label,
  type,
  value,
  onChange,
  error,
  options,
  step,
  min,
}) => {
  return (
    <div className="mb-4 tracking-widest">
      <label className="block text-white-700">{label}</label>
      {type === "select" ? (
        <select
          className="w-full p-2 bg-zinc-700 rounded"
          value={value}
          onChange={onChange}
        >
          <option value="">Select {label}</option>
          {options?.map((option) => (
            <option key={option.id} value={option.id}>
              {option.name}
            </option>
          ))}
        </select>
      ) : (
        <input
          type={type}
          step={step}
          min={min}
          className="w-full p-2 bg-zinc-700 rounded"
          value={value}
          onChange={onChange}
        />
      )}
      {error && <p className="text-red-500 text-base">{error}</p>}
    </div>
  );
};

export default InputField;
