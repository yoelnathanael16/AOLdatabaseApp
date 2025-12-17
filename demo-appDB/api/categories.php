<?php
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $stmt = $pdo->query('SELECT * FROM Category');
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
}

if ($method === 'POST') {
    $d = json_decode(file_get_contents('php://input'), true);
    $stmt = $pdo->prepare('INSERT INTO Category (CategoryID, CategoryName) VALUES(:id, :name)');
    $stmt->execute([':id' => $d['CategoryID'], ':name' => $d['CategoryName']]);
    echo json_encode(['success' => true]);
}
?>