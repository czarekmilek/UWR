type User = {
  name: string;
  age: number;
  occupation: string;
  type: 'user'; // Dodane pole typu 'user'
};

type Admin = {
  name: string;
  age: number;
  role: string;
  type: 'admin'; // Dodane pole typu 'admin'
};

export type Person = User | Admin;

export const persons: Person[] = [
  {
    name: 'Jan Kowalski',
    age: 17,
    occupation: 'Student',
    type: 'user', // Dodane pole typu 'user'
  },
  {
    name: 'Tomasz Malinowski',
    age: 20,
    role: 'Administrator',
    type: 'admin', // Dodane pole typu 'admin'
  },
];

export function isAdmin(person: Person): person is Admin {
  return person.type === 'admin';
}

export function isUser(person: Person): person is User {
  return person.type === 'user';
}

export function logPerson(person: Person) {
  let additionalInformation: string = '';

  if (isAdmin(person)) {
    additionalInformation = person.role;
  }

  if (isUser(person)) {
    additionalInformation = person.occupation;
  }

  console.log(` - ${person.name}, ${person.age}, ${additionalInformation}`);
}

persons.forEach(logPerson);
