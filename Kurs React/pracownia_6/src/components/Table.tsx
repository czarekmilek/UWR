import React, { useState } from 'react';
import {
  Box,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TablePagination,
  TableRow,
  IconButton,
  Tooltip,
  Button,
  Icon,
} from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import AddProduct from './AddProduct';
import Delete from './Delete';
import { visuallyHidden } from '@mui/utils';
import initialRows from './initialRows';

const headCells = [
  { id: 'name', label: 'Name' },
  { id: 'type', label: 'Type' },
  { id: 'price', label: 'Price' },
  { id: 'available', label: 'Available' },
  { id: 'quantity', label: 'Stock' },
];

const OrderedTable = () => {
  const [order, setOrder] = useState('asc');
  const [orderBy, setOrderBy] = useState('name');
  const [data, setData] = useState(initialRows);
  const [open, setOpen] = useState(false);
  const [deletedProductName, setDeletedProductName] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);

  const emptyRows =
    page > 0 ? Math.max(0, (1 + page) * rowsPerPage - data.length) : 0;

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };
  const handleRequestSort = (property) => {
    const isAsc = orderBy === property && order === 'asc';
    setOrder(isAsc ? 'desc' : 'asc');
    setOrderBy(property);
  };

  const handleDeleteProduct = (row) => {
    const newData = data.filter((item) => item.id !== row.id);
    setData(newData);
    setDeletedProductName(row.name);
    const newEmptyRows = rowsPerPage - (newData.length % rowsPerPage);
    if (newEmptyRows === rowsPerPage && page > 0) {
      setPage(page - 1);
    }
  };

  const getComparison = (order, orderBy) => {
    return order === 'desc'
      ? (a, b) => {
          if (b[orderBy] < a[orderBy]) return -1;
          if (b[orderBy] > a[orderBy]) return 1;
          return 0;
        }
      : (a, b) => {
          if (a[orderBy] < b[orderBy]) return -1;
          if (a[orderBy] > b[orderBy]) return 1;
          return 0;
        };
  };

  const ssort = (array, comparator) => {
    const temp = array.map((el, index) => [el, index]);
    temp.sort((a, b) => {
      const order = comparator(a[0], b[0]);
      if (order !== 0) return order;
      return a[1] - b[1];
    });
    return temp.map((el) => el[0]);
  };

  const sortedData = ssort(data, getComparison(order, orderBy)).slice(
    page * rowsPerPage,
    page * rowsPerPage + rowsPerPage
  );

  return (
    <>
      <Box sx={{ width: '100%' }}>
        <Paper>
          <TableContainer sx={{ maxHeight: 500 }}>
            <Table stickyHeader aria-label="sticky table">
              <TableHead>
                <TableRow>
                  {headCells.map((headCell) => (
                    <TableCell key={headCell.id}>
                      <Tooltip title="Sort" placement="bottom-start">
                        <IconButton
                          onClick={() => handleRequestSort(headCell.id)}
                        >
                          <span>{headCell.label}</span>

                          {orderBy === headCell.id ? (
                            <Box component="span" sx={visuallyHidden}>
                              {order === 'desc'
                                ? 'sorted descending'
                                : 'sorted ascending'}
                            </Box>
                          ) : null}
                        </IconButton>
                      </Tooltip>
                    </TableCell>
                  ))}
                  <TableCell>Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {sortedData.map((row) => (
                  <TableRow key={row.id}>
                    <TableCell>{row.name}</TableCell>
                    <TableCell>{row.type}</TableCell>
                    <TableCell>{row.price + ' PLN'}</TableCell>
                    <TableCell>{row.available ? 'Yes' : 'No'}</TableCell>
                    <TableCell>{row.quantity}</TableCell>
                    <TableCell>
                      <Tooltip title="Delete">
                        <IconButton onClick={() => handleDeleteProduct(row)}>
                          <DeleteIcon />
                        </IconButton>
                      </Tooltip>
                    </TableCell>
                  </TableRow>
                ))}
                {emptyRows > 0 && (
                  <TableRow style={{ height: 50 * emptyRows }}>
                    <TableCell colSpan={6} />
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
          <TablePagination
            rowsPerPageOptions={[5, 10, 15]}
            component="div"
            count={data.length}
            rowsPerPage={rowsPerPage}
            page={page}
            onPageChange={handleChangePage}
            onRowsPerPageChange={handleChangeRowsPerPage}
          />
        </Paper>
      </Box>
      <Button
        sx={{ mt: 2 }}
        endIcon={<Icon>add_circle</Icon>}
        onClick={() => setOpen(true)}
      >
        Add Product
      </Button>
      {deletedProductName !== '' && (
        <Delete
          name={deletedProductName}
          onClose={() => setDeletedProductName('')}
        />
      )}
      {open && (
        <AddProduct
          data={data}
          onClose={() => setOpen(false)}
          updateData={(newData) => setData(newData)}
        />
      )}
    </>
  );
};

export default OrderedTable;
