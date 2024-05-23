export interface Book {
  id: string;
  title: string;
  author: string;
  year: string;
  copies: number;
  price: number;
  genreId: string;
  genre?: string;
}
