import React from 'react';

const ContactForm = () => {
  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
  };

  return (
    <form onSubmit={handleSubmit} className={`contact-form bg-[#f9f9f9] dark:bg-[#333] max-w-[600px] flex flex-col 
                                            mx-auto my-0 mb-[-20px] p-5 mt-[-20px] rounded-[10px] 
                                            border border-solid border-gray-300 dark:border-[#555]`}>
      <div className="form-group mb-[20px] ">
        <input
          type="text"
          placeholder="Name"
          className={`w-[calc(100%)] mt-[5px] p-[10px] h-9 rounded-[5px] border-[none] focus:outline-black 
                    border border-solid border-[#ccc] dark:border-[#555] bg-[#FFFFFF] dark:bg-[#444444]`}
          required
        />
      </div>
      <div className="form-group mb-[20px] ">
        <input
          type="email"
          placeholder="Email"
          className={`w-[calc(100%)] mt-[5px] p-[10px] h-9 rounded-[5px] border-[none] focus:outline-black 
                    border border-solid border-[#ccc] dark:border-[#555] bg-[#FFFFFF] dark:bg-[#444444]`}
          required
        />
      </div>
      <div className="form-group mb-[5px] ">
        <textarea
          rows={5}
          placeholder="Message"
          className={`w-[calc(100%)] mt-[5px] p-[10px] h-24 rounded-[5px] border-[none] focus:outline-black 
                    border border-solid border-[#ccc] dark:border-[#555] bg-[#FFFFFF] dark:bg-[#444444]`}
          required
        ></textarea>
      </div>
      <button
        type="submit"
        className={`cursor-pointer transition-[background-color] duration-[0.3s] ease-[ease] px-[20px] py-[8px] rounded-[5px] 
                    border-[none] bg-[#4CAF50] font-arial text-[13.333px] font-normal hover:bg-[#45a049]} text-white font-bold py-2 px-4 rounded mt-4`}
      >
        Send Message
      </button>
    </form>
  );
};

export default ContactForm;
