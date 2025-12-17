<?php
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $stmt = $pdo->query('SELECT * FROM Customer');
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
}

if ($method === 'POST') {
    $d = json_decode(file_get_contents('php://input'), true);
    $stmt = $pdo->prepare('INSERT INTO Customer (CustomerID,CustomerName,CustomerGender,CustomerAddress,CustomerEmail,CustomerDOB)
                           VALUES(:id,:name,:gender,:address,:email,:dob)');
    $stmt->execute([
        ':id'=>$d['CustomerID'],':name'=>$d['CustomerName'],':gender'=>$d['CustomerGender'] ?? null,
        ':address'=>$d['CustomerAddress'] ?? null,':email'=>$d['CustomerEmail'] ?? null,':dob'=>$d['CustomerDOB'] ?? null
    ]);
    echo json_encode(['success'=>true]);
}
