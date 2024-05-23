import React from "react";

interface ConfirmationProps {
  message: string;
  onConfirm: () => void;
  onCancel: () => void;
}

const Confirmation: React.FC<ConfirmationProps> = ({
  message,
  onConfirm,
  onCancel,
}) => {
  return (
    <div className="fixed inset-0 bg-gray-800 bg-opacity-50 flex items-center justify-center tracking-widest">
      <div className="bg-zinc-900 p-8 rounded-lg shadow-lg w-full max-w-lg">
        <p className="mb-4 text-center text-white-700">{message}</p>
        <div className="flex justify-center">
          <button
            onClick={onConfirm}
            className="bg-gradient-to-b from-red-600 to-red-800 text-white px-4 py-2 mr-2 rounded 
                        hover:bg-gradient-to-b hover:from-red-700 hover:to-red-900 
                        transition ease-in-out hover:translate-y-0.5 hover:scale-110 duration-300"
          >
            Yes
          </button>
          <button
            onClick={onCancel}
            className="bg-gradient-to-b from-gray-500 to-gray-800 text-white px-4 py-2 rounded 
          hover:bg-gradient-to-b hover:from-gray-600 hover:to-gray-900
          transition ease-in-out hover:translate-y-0.5 hover:scale-110 duration-300"
          >
            No
          </button>
        </div>
      </div>
    </div>
  );
};

export default Confirmation;
