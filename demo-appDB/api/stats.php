<?php
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';

$catQuery = "SELECT cat.CategoryName, SUM(td.Quantity) as TotalTerjual
             FROM TransactionDetail td
             JOIN CarInfo c ON td.ProductID = c.ProductID
             JOIN Category cat ON c.CategoryID = cat.CategoryID
             GROUP BY cat.CategoryID
             ORDER BY TotalTerjual DESC LIMIT 5";

$colorQuery = "SELECT c.Color, SUM(td.Quantity) as TotalTerjual
               FROM TransactionDetail td
               JOIN CarInfo c ON td.ProductID = c.ProductID
               GROUP BY c.Color
               ORDER BY TotalTerjual DESC LIMIT 5";

$stats = [
    'top_categories' => $pdo->query($catQuery)->fetchAll(PDO::FETCH_ASSOC),
    'top_colors' => $pdo->query($colorQuery)->fetchAll(PDO::FETCH_ASSOC)
];

echo json_encode($stats);
?>