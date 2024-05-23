import * as React from 'react';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Header from './components/Header';
import OrderedTable from './components/Table';

const theme = createTheme({
  palette: {
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#ff9800',
    },
    background: {
      default: '#f5f5f5',
    },
  },
  typography: {
    fontFamily: 'Arial, sans-serif',
    h1: {
      fontSize: '2.5rem',
      fontWeight: 'bold',
      marginBottom: '1rem',
    },
    h2: {
      fontSize: '2rem',
      fontWeight: 'bold',
      marginBottom: '0.8rem',
    },
    subtitle1: {
      fontSize: '1rem',
    },
    button: {
      textTransform: 'none',
      fontWeight: 'bold',
    },
  },
});

function App() {
  return (
    <>
      <ThemeProvider theme={theme}>
        <Header />
        <OrderedTable />
      </ThemeProvider>
    </>
  );
}

export default App;
