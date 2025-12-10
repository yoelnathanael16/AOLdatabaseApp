const api = {
  products: 'api/products.php',
  customers: 'api/customers.php',
  transactions: 'api/transactions.php'
};

async function fetchProducts(){
  const res = await fetch(api.products);
  const data = await res.json();
  const tbody = document.querySelector('#tblProducts tbody');
  tbody.innerHTML = data.map(p=>`<tr><td>${p.ProductID}</td><td>${p.ModelName||''}</td><td>${p.Price||''}</td></tr>`).join('');
}

async function fetchCustomers(){
  const res = await fetch(api.customers);
  const data = await res.json();
  document.getElementById('lstCustomers').innerHTML = data.map(c=>`<li>${c.CustomerID} - ${c.CustomerName}</li>`).join('');
}

async function fetchTransactions(){
  const res = await fetch(api.transactions);
  const data = await res.json();
  document.getElementById('lstTransactions').innerHTML = data.map(t=>`<li>${t.TransactionID} - ${t.CustomerName||t.CustomerID} - ${t.TransactionDate} - ${t.TransactionTime}</li>`).join('');
}

document.getElementById('refreshProducts').addEventListener('click', fetchProducts);
document.getElementById('refreshCustomers').addEventListener('click', fetchCustomers);
document.getElementById('refreshTransactions').addEventListener('click', fetchTransactions);

document.getElementById('formProduct').addEventListener('submit', async e=>{
  e.preventDefault();
  const f = new FormData(e.target);
  const body = Object.fromEntries(f.entries());
  await fetch(api.products, {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(body)});
  fetchProducts();
  e.target.reset();
});

document.getElementById('formCustomer').addEventListener('submit', async e=>{
  e.preventDefault();
  const f = new FormData(e.target);
  const body = Object.fromEntries(f.entries());
  await fetch(api.customers, {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(body)});
  fetchCustomers();
  e.target.reset();
});

document.getElementById('formTransaction').addEventListener('submit', async e=>{
  e.preventDefault();
  const f = new FormData(e.target);
  const body = Object.fromEntries(f.entries());
  try{
  body.details = JSON.parse(body.details);
  }catch(err){alert('details harus JSON');return}
  await fetch(api.transactions, {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(body)});
  fetchTransactions();
  e.target.reset();
});

fetchProducts();fetchCustomers();fetchTransactions();
