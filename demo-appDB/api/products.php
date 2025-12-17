<?php
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    $stmt = $pdo->query('SELECT * FROM CarInfo');
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
}

if ($method === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $sql = "INSERT INTO CarInfo (ProductID, CategoryID, Price, Manufacturer, ModelName, ModelYear, Color, Engine, Odometer, EngineNumber, VIN, RegistrationNumber)
            VALUES (:ProductID,:CategoryID,:Price,:Manufacturer,:ModelName,:ModelYear,:Color,:Engine,:Odometer,:EngineNumber,:VIN,:RegistrationNumber)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':ProductID'=>$data['ProductID'],
        ':CategoryID'=>$data['CategoryID'] ?? null,
        ':Price'=>$data['Price'] ?? 0,
        ':Manufacturer'=>$data['Manufacturer'] ?? null,
        ':ModelName'=>$data['ModelName'] ?? null,
        ':ModelYear'=>$data['ModelYear'] ?? null,
        ':Color'=>$data['Color'] ?? null,
        ':Engine'=>$data['Engine'] ?? null,
        ':Odometer'=>$data['Odometer'] ?? 0,
        ':EngineNumber'=>$data['EngineNumber'] ?? null,
        ':VIN'=>$data['VIN'] ?? null,
        ':RegistrationNumber'=>$data['RegistrationNumber'] ?? null
    ]);
    echo json_encode(['success'=>true]);
}

if ($method === 'DELETE') {
    parse_str(file_get_contents('php://input'), $data);
    $stmt = $pdo->prepare('DELETE FROM CarInfo WHERE ProductID = :id');
    $stmt->execute([':id'=>$data['ProductID']]);
    echo json_encode(['success'=>true]);
}
