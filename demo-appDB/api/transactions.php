<?php
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';
$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'POST') {
$d = json_decode(file_get_contents('php://input'), true);
try {
$pdo->beginTransaction();
$h = $pdo->prepare('INSERT INTO TransactionHeader (TransactionID, CustomerID, TransactionDate) VALUES(:tid,:cid,:tdate)');
$h->execute([':tid'=>$d['TransactionID'],':cid'=>$d['CustomerID'],':tdate'=>$d['TransactionDate']]);
$detail = $pdo->prepare('INSERT INTO TransactionDetail (TransactionID, ProductID, Quantity, UnitPrice) VALUES(:tid,:pid,:qty,:price)');
foreach ($d['details'] as $it) {
$detail->execute([':tid'=>$d['TransactionID'],':pid'=>$it['ProductID'],':qty'=>$it['Quantity'],':price'=>$it['UnitPrice']]);
}
$pdo->commit();
echo json_encode(['success'=>true]);
} catch (Exception $e) {
$pdo->rollBack();
http_response_code(500);
echo json_encode(['error'=>$e->getMessage()]);
}
}
if ($method === 'GET') {
$stmt = $pdo->query('SELECT h.TransactionID, h.TransactionDate, c.CustomerName FROM TransactionHeader h LEFT JOIN Customer c ON h.CustomerID=c.CustomerID');
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);
}